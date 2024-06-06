import time
import threading
from collections import deque
from queue import PriorityQueue
from tabulate import tabulate

class Process:
    def __init__(self, pid, instructions, priority):
        self.pid = pid
        self.instructions = deque(instructions)
        self.state = "NEW"
        self.priority = priority
        self.waiting_time = 0
    
    def __lt__(self, other):
        return self.priority < other.priority
    
    def __repr__(self):
        return f"Process({self.pid},Priority: {self.priority})"
    
    def execute_instruction(self):
        if self.instructions:
            instruction = self.instructions.popleft()
            if instruction == "$$$$":
                return "IO"
            return "EXECUTED"
        return "DONE"
    
    def add_instruction(self, instruction):
        self.instructions.appendleft(instruction)

class OSStateManager:
    def __init__(self):
        self.ready_queue = PriorityQueue(maxsize=3)
        self.waiting_queue = PriorityQueue(maxsize=3)
        self.suspended_waiting_queue = PriorityQueue(maxsize=3)
        self.suspended_ready_queue = PriorityQueue(maxsize=3)
        self.running_process = None
        self.terminated_processes = []
        self.lock = threading.Lock()
        self.exit_flag = False
    
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
        while not self.exit_flag:
            with self.lock:
                if not self.running_process and not self.ready_queue.empty():
                    self.running_process = self.ready_queue.get()
                    self.running_process.state = "RUNNING"
                    print(f"Process {self.running_process.pid} is now RUNNING.")
            
            if self.running_process:
                result = self.running_process.execute_instruction()
                time.sleep(1)  # Simulate execution time
                if result == "IO":
                    with self.lock:
                        self.running_process.state = "WAITING"
                        self.running_process.waiting_time = 0
                        self.waiting_queue.put(self.running_process)
                        print(f"Process {self.running_process.pid} is now WAITING for IO.")
                        self.running_process = None
                elif result == "DONE":
                    with self.lock:
                        self.running_process.state = "TERMINATED"
                        self.terminated_processes.append(self.running_process)
                        print(f"Process {self.running_process.pid} is now TERMINATED.")
                        self.running_process = None
                        if len(self.terminated_processes) == len(process_list):
                            self.exit_flag = True
            
            time.sleep(1)

    def handle_io(self):
        while not self.exit_flag:
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
            
            # Check for infinite waiting and move to suspended waiting if necessary
            with self.lock:
                to_suspend = []
                for process in list(self.waiting_queue.queue):
                    process.waiting_time += 1
                    if process.waiting_time >= 3:  # Assuming 3 seconds is the limit before suspending
                        to_suspend.append(process)
                
                for process in to_suspend:
                    self.waiting_queue.queue.remove(process)
                    if self.suspended_waiting_queue.qsize() < self.suspended_waiting_queue.maxsize:
                        process.state = "SUSPENDED_WAITING"
                        self.suspended_waiting_queue.put(process)
                        print(f"Process {process.pid} is now SUSPENDED_WAITING.")
            
            time.sleep(1)
    
    def manage_suspended_ready_queue(self):
        while not self.exit_flag:
            with self.lock:
                while self.ready_queue.qsize() < self.ready_queue.maxsize and not self.suspended_ready_queue.empty():
                    suspended_process = self.suspended_ready_queue.get()
                    suspended_process.state = "READY"
                    self.ready_queue.put(suspended_process)
                    print(f"Suspended Process {suspended_process.pid} is now READY.")
            time.sleep(1)
    
    def print_queues(self):
        headers = ["Queue", "Processes"]
        while not self.exit_flag:
            with self.lock:
                data = [
                    ["Ready Queue", list(self.ready_queue.queue)],
                    ["Waiting Queue", list(self.waiting_queue.queue)],
                    ["Suspended Ready Queue", list(self.suspended_ready_queue.queue)],
                    ["Suspended Waiting Queue", list(self.suspended_waiting_queue.queue)],
                    ["Running Process", self.running_process],
                    ["Terminated Processes", self.terminated_processes]
                ]
                table = tabulate(data, headers, tablefmt="grid")
                print(table)
                if self.exit_flag:
                    print("All processes completed. Exiting the program.")
                    return
            time.sleep(5)

if __name__ == "__main__":
    process_list = [
        Process(1, ["instr1", "instr2", "$$$$", "instr3"], priority=1),
        Process(2, ["instr1", "$$$$", "instr2", "instr3"], priority=2),
        Process(3, ["instr1", "instr2", "instr3"], priority=1),
        Process(4, ["instr1", "$$$$", "instr2"], priority=3),
        Process(5, ["instr1", "instr2"], priority=2),
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
