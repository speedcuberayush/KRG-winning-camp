import queue
import time
import os

# Print current working directory

# Define process states
NEW = 'New'
READY = 'Ready'
RUNNING = 'Running'
WAITING = 'Waiting'
TERMINATED = 'Terminated'
SUSPENDED_READY = 'Suspended Ready'
SUSPENDED_WAIT = 'Suspended Wait'

# Directory where process files are stored
process_dir = r'C:\Users\msdak\OneDrive\Desktop\Kargil-winning-camp\OS\process'

# Predefined map for the priority and file name
priority_file_map = {
    1: 'A.txt',
    2: 'B.txt',
    3: 'C.txt',
    4: 'D.txt'
}

# Define a Process class
class Process:
    def __init__(self, pid, priority):
        self.pid = pid
        self.priority = priority
        self.state = NEW
        self.filename = os.path.join(process_dir, priority_file_map[priority])
        self.current_line = 0
    
    def __lt__(self, other):
        return self.priority < other.priority

    def __str__(self):
        return f'Process[PID={self.pid}, Priority={self.priority}, State={self.state}, File={self.filename}, Current Line={self.current_line}]'

# Function to simulate process state transitions
def simulate_process_transitions(process_queue, max_queue_size):
    ready_queue = queue.PriorityQueue(max_queue_size)
    waiting_queue = queue.PriorityQueue(max_queue_size)
    suspended_ready_queue = queue.PriorityQueue(max_queue_size)
    suspended_wait_queue = queue.PriorityQueue(max_queue_size)
    terminated_processes = []

    while not process_queue.empty() or not ready_queue.empty() or not waiting_queue.empty() or not suspended_ready_queue.empty() or not suspended_wait_queue.empty():
        # Admit new processes to the ready queue
        while not process_queue.empty() and not ready_queue.full():
            process = process_queue.get()
            process.state = READY
            ready_queue.put(process)
            print(f"Admitted: {process}")
            time.sleep(0.5)
        
        # Dispatch process to running state
        if not ready_queue.empty():
            process = ready_queue.get()
            process.state = RUNNING
            print(f"Dispatched to Running: {process}")
            time.sleep(0.5)
            
            # Simulate process running and file execution
            try:
                with open(process.filename, 'r') as file:
                    lines = file.readlines()
                    for i in range(process.current_line, len(lines)):
                        line = lines[i].strip()
                        process.current_line = i
                        print(f"Executing: {line}")
                        if '$$$$$$' in line:
                            print(f"IO Operation Detected in {process}")
                            line = line.replace('$$$$$$', '').strip()
                            process.state = WAITING
                            if waiting_queue.full():
                                print(f"Waiting Queue Full. Moving {process} to Suspended Wait.")
                                process.state = SUSPENDED_WAIT
                                if not suspended_wait_queue.full():
                                    suspended_wait_queue.put(process)
                                else:
                                    print(f"Suspended Wait Queue Full. Moving {process} to Suspended Ready.")
                                    process.state = SUSPENDED_READY
                                    suspended_ready_queue.put(process)
                            else:
                                waiting_queue.put(process)
                            break
                        time.sleep(0.5)
                    else:
                        process.state = TERMINATED
                        terminated_processes.append(process)
                        print(f"Terminated: {process}")
                        time.sleep(0.5)
            except FileNotFoundError:
                print(f"Error: File {process.filename} not found. Terminating process {process.pid}.")
                process.state = TERMINATED
                terminated_processes.append(process)
                time.sleep(0.5)

        # Resume processes from suspended wait to ready if event completed
        while not waiting_queue.empty() and not ready_queue.full():
            process = waiting_queue.get()
            process.state = READY
            ready_queue.put(process)
            print(f"Event Completed, moved to Ready: {process}")
            time.sleep(0.5)

        # Handle suspended ready processes
        while not suspended_ready_queue.empty() and not ready_queue.full():
            process = suspended_ready_queue.get()
            process.state = READY
            ready_queue.put(process)
            print(f"Resuming Suspended Ready: {process}")
            time.sleep(0.5)
    
    print("\nFinal Terminated Processes:")
    for process in terminated_processes:
        print(process)

# Example usage
if __name__ == "__main__":
    process_queue = queue.PriorityQueue()
    process_queue.put(Process(1, 3))
    process_queue.put(Process(2, 1))
    process_queue.put(Process(3, 4))
    process_queue.put(Process(4, 2))

    max_queue_size = 3
    simulate_process_transitions(process_queue, max_queue_size)
