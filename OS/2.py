import queue
import threading
import time
import os
from tabulate import tabulate

# Define process states
NEW = 'New'
READY = 'Ready'
RUNNING = 'Running'
WAITING = 'Waiting'
TERMINATED = 'Terminated'

# Directory where process files are stored
process_dir = r'C:\Users\msdak\OneDrive\Desktop\Kargil-winning-camp\OS\process'

# Define a Process class
class Process:
    def __init__(self, pid, priority, filename):
        self.pid = pid
        self.priority = priority
        self.state = NEW
        self.filename = filename
        self.lines = self.read_file_lines()
        self.current_line = 0

    def read_file_lines(self):
        file_path = os.path.join(process_dir, self.filename)
        with open(file_path, 'r') as file:
            return file.readlines()

    def __lt__(self, other):
        return self.priority < other.priority

    def __str__(self):
        return f'Process[PID={self.pid}, Priority={self.priority}, State={self.state}, File={self.filename}, Current Line={self.current_line}]'

# Function to simulate IO operation
def perform_io(process, waiting_queue):
    print(f"IO Operation detected for Process {process.pid}. Performing IO operation...")
    time.sleep(2)  # Simulating IO operation
    print(f"IO operation completed for Process {process.pid}. Resuming execution.")
    process.state = READY
    waiting_queue.put(process)

# Function to execute lines
def execute_lines(process, ready_queue, waiting_queue):
    lines = process.lines
    for i in range(process.current_line, len(lines)):
        line = lines[i].strip()
        process.current_line = i
        print(f"{process.filename} executing line {i+1}: {line}")
        if '$$$$$$' in line:
            print(f"IO Operation detected in {process.filename}. Saving state and moving to Waiting state.")
            process.state = WAITING
            process.current_line += 1  # Move to the next line after the IO operation
            threading.Thread(target=perform_io, args=(process, waiting_queue)).start()
            return  # Exit the loop after encountering an IO operation
        time.sleep(0.5)  # Simulating regular execution
    else:
        process.state = TERMINATED
        print(f"Execution of {process.filename} completed. Process {process.pid} is terminated.")

# Function to simulate process state transitions
def simulate_process_transitions(process_queue, max_ready_size):
    ready_queue = queue.Queue(max_ready_size)
    waiting_queue = queue.Queue()  # No size limit for waiting queue
    terminated_processes = []

    while not process_queue.empty() or not ready_queue.empty() or not waiting_queue.empty():
        # Admit new processes to the ready queue
        while not process_queue.empty() and not ready_queue.full():
            process = process_queue.get()
            process.state = READY
            ready_queue.put(process)
            print(f"Process {process.pid} with priority {process.priority} is admitted and moved to Ready state.")
            time.sleep(0.5)
        
        # Dispatch process to running state
        if not ready_queue.empty():
            process = ready_queue.get()
            process.state = RUNNING
            print(f"Process {process.pid} with priority {process.priority} is dispatched to Running state.")
            threading.Thread(target=execute_lines, args=(process, ready_queue, waiting_queue)).start()
            
        # Handle processes in waiting state
        while not waiting_queue.empty() and not ready_queue.full():
            process = waiting_queue.get()
            process.state = READY
            ready_queue.put(process)
            print(f"IO operation completed for Process {process.pid}. It is moved to Ready state.")
            time.sleep(0.5)

        # Move terminated processes to the list of terminated processes
        while not ready_queue.empty() and ready_queue.queue[0].state == TERMINATED:
            terminated_processes.append(ready_queue.get())

    print("\nAll processes completed.")

    # Display the number of lines executed for each process
    executed_lines_data = []
    for process in terminated_processes:
        executed_lines_data.append([process.pid, process.filename, process.current_line])

    # Generate a table with all queues and their respective processes
    process_queues = {
        "Process Queue": list(process_queue.queue),
        "Ready Queue": list(ready_queue.queue),
        "Waiting Queue": list(waiting_queue.queue),
        "Terminated Processes": terminated_processes
    }

    print("\nProcess Queues:")
    for queue_name, processes in process_queues.items():
        print(f"\n{queue_name}:")
        queue_data = [[process.pid, process.filename, process.state, process.current_line] for process in processes]
        print(tabulate(queue_data, headers=["PID", "Filename", "State", "Current Line"]))

    # Display the number of lines executed for each process
    print("\nNumber of lines executed for each process:")
    print(tabulate(executed_lines_data, headers=["Process ID", "File Name", "Lines Executed"]))

# Example usage
if __name__ == "__main__":
    # Create process objects with filenames
    process1 = Process(1, 3, "A.txt")
    process2 = Process(2, 1, "B.txt")
    process3 = Process(3, 4, "C.txt")
    process4 = Process(4, 2, "D.txt")
    process5 = Process(5, 5,"E.txt")
    process6 = Process(6, 6,"F.txt")
    process7 = Process(7, 7,"G.txt")
    process8 = Process(8, 8,"H.txt")

    # Create a priority queue and add process objects
    process_queue = queue.PriorityQueue()
    for process in [process1, process2, process3, process4, process5, process6, process7, process8]:
        process_queue.put(process)

    max_ready_size = 3
    simulate_process_transitions(process_queue, max_ready_size)
