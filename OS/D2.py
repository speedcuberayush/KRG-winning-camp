import time
import threading
from collections import deque
from queue import PriorityQueue
from tabulate import tabulate

class Process:
    def __init__(self, pid, instructions, priority):
        self.pid = pid
        self.instructions = deque(instructions)
        self.original_instructions = list(instructions)
        self.state = "NEW"
        self.priority = priority
        self.waiting_time = 0
    
    def __lt__(self, other):
        return self.priority < other.priority
    
    def __repr__(self):
        return f"Process({self.pid}, Priority: {self.priority})"
    
    def execute_instruction(self):
        if self.instructions:
            instruction = self.instructions.popleft()
            if instruction!="$$$$":
                print(f"Process {self.pid}: Executing {instruction}")
                time.sleep(0.2)  # Simulate the time taken to execute an instruction
            if instruction == "$$$$":
                return "IO"
            return "EXECUTED"
        return "DONE"
    
    def reset_instructions(self):
        self.instructions = deque(self.original_instructions)
        self.waiting_time = 0

class OSStateManager:
    def __init__(self):
        self.ready_queue = PriorityQueue(maxsize=3)
        self.waiting_queue = PriorityQueue(maxsize=3)
        self.suspended_waiting_queue = PriorityQueue(maxsize=3)
        self.suspended_ready_queue = PriorityQueue(maxsize=3)
        self.running_process = None
        self.terminated_processes = []
        self.lock = threading.Lock()
        self.exit_flag = threading.Event()
        self.print_flag = threading.Event()
    
    def add_process(self, process):
        with self.lock:
            process.state = "READY"
            if self.ready_queue.qsize() < self.ready_queue.maxsize:
                self.ready_queue.put(process)
            else:
                print(f"Ready queue full. Process {process.pid} suspended.")
                process.state = "SUSPENDED_READY"
                self.suspended_ready_queue.put(process)
    
    def execute_process(self):
        while not self.exit_flag.is_set():
            with self.lock:
                if not self.running_process and not self.ready_queue.empty():
                    self.running_process = self.ready_queue.get()
                    self.running_process.state = "RUNNING"
                    print(f"Process {self.running_process.pid} is now RUNNING.")
            
            if self.running_process:
                result = self.running_process.execute_instruction()
                time.sleep(0.75)  # Simulate remaining execution time after instruction print
                if result == "IO":
                    with self.lock:
                        self.running_process.state = "WAITING"
                        self.running_process.waiting_time = 0
                        if self.waiting_queue.qsize() < self.waiting_queue.maxsize:
                            self.waiting_queue.put(self.running_process)
                        else:
                            print(f"Waiting queue full. Process {self.running_process.pid} moved to SUSPENDED_WAITING.")
                            self.running_process.state = "SUSPENDED_WAITING"
                            self.suspended_waiting_queue.put(self.running_process)
                        self.print_flag.set()  # Signal to print the table for waiting queue entry
                        self.running_process = None
                elif result == "DONE":
                    with self.lock:
                        self.running_process.state = "TERMINATED"
                        self.terminated_processes.append(self.running_process.pid)
                        print(f"Process {self.running_process.pid} is now TERMINATED.")
                        self.print_flag.set()  # Signal to print the table for process termination
                        self.running_process = None
                        if len(self.terminated_processes) == len(process_list):
                            self.exit_flag.set()
            
            time.sleep(1)

    def handle_io(self):
        while not self.exit_flag.is_set():
            if not self.waiting_queue.empty():
                with self.lock:
                    waiting_process = self.waiting_queue.get()
                time.sleep(2)  # Simulate IO operation taking time
                with self.lock:
                    waiting_process.state = "READY"
                    if self.ready_queue.qsize() < self.ready_queue.maxsize:
                        self.ready_queue.put(waiting_process)
                    else:
                        waiting_process.state = "SUSPENDED_READY"
                        self.suspended_ready_queue.put(waiting_process)
                    print(f"Process {waiting_process.pid} completed IO and is now READY.")
                    self.print_flag.set()  # Signal to print the table for IO completion
            
            # Move processes from suspended waiting to waiting queue if space available
            with self.lock:
                to_suspend_ready = []
                to_waiting = []
                for process in list(self.suspended_waiting_queue.queue):
                    process.waiting_time += 1
                    if process.waiting_time >= 10:  # 10 seconds limit
                        to_suspend_ready.append(process)
                    elif self.waiting_queue.qsize() < self.waiting_queue.maxsize:
                        to_waiting.append(process)
                
                for process in to_suspend_ready:
                    self.suspended_waiting_queue.queue.remove(process)
                    process.state = "SUSPENDED_READY"
                    process.reset_instructions()  # Reset instructions to start from scratch
                    self.suspended_ready_queue.put(process)
                    print(f"Process {process.pid} moved to SUSPENDED_READY after waiting too long.")
                    self.print_flag.set()  # Signal to print the table for state change
                
                for process in to_waiting:
                    self.suspended_waiting_queue.queue.remove(process)
                    process.state = "WAITING"
                    self.waiting_queue.put(process)
                    print(f"Suspended Process {process.pid} moved back to WAITING.")
                    self.print_flag.set()  # Signal to print the table for state change
            
            time.sleep(1)

    def manage_suspended_ready_queue(self):
        while not self.exit_flag.is_set():
            with self.lock:
                while self.ready_queue.qsize() < self.ready_queue.maxsize and not self.suspended_ready_queue.empty():
                    suspended_process = self.suspended_ready_queue.get()
                    suspended_process.state = "READY"
                    self.ready_queue.put(suspended_process)
                    print(f"Suspended Process {suspended_process.pid} is now READY.")
                    self.print_flag.set()  # Signal to print the table for state change
            time.sleep(1)
    
    def print_queues(self):
        while not self.exit_flag.is_set():
            self.print_flag.wait()  # Wait for the signal to print the table
            with self.lock:
                headers = ["Queue", "Processes"]
                data = [
                    ["Ready Queue", list(self.ready_queue.queue)],
                    ["Waiting Queue", list(self.waiting_queue.queue)],
                    ["Suspended Ready Queue", list(self.suspended_ready_queue.queue)],
                    ["Suspended Waiting Queue", list(self.suspended_waiting_queue.queue)],
                    ["Running Process", self.running_process],
                    ["Terminated Processes", self.terminated_processes]
                ]
                table = tabulate(data, headers, tablefmt="pretty")
                print(table)
                self.print_flag.clear()  # Reset the print flag
            if self.exit_flag.is_set():
                print("All processes completed. Exiting the program.")
                break
            time.sleep(1)
    
if __name__ == "__main__":
    process_list = [
        Process(1, ["instr1", "instr2", "$$$$", "instr3"], priority=1),
        Process(2, ["instr1", "$$$$", "instr2", "instr3"], priority=2),
        Process(3, ["instr1", "instr2", "instr3"], priority=1),
        Process(4, ["instr1", "$$$$", "instr2"], priority=3),
        Process(5, ["instr1", "instr2"], priority=2),
        Process(6, ["$$$$","instr1", "instr2"], priority=1),
    ]
    
    os_manager = OSStateManager()
    
    for process in process_list:
        os_manager.add_process(process)
    
    cpu_thread = threading.Thread(target=os_manager.execute_process)
    io_thread = threading.Thread(target=os_manager.handle_io)
    suspended_ready_thread = threading.Thread(target=os_manager.manage_suspended_ready_queue)
    print_thread = threading.Thread(target=os_manager.print_queues)
    
    cpu_thread.start()
    io_thread.start()
    suspended_ready_thread.start()
    print_thread.start()
    
    cpu_thread.join()
    io_thread.join()
    suspended_ready_thread.join()
    print_thread.join()
