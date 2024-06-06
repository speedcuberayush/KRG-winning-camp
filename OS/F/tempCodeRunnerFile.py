import os
import time
import subprocess
from tabulate import tabulate
from collections import deque

# Define the directory path
directory_path = r"C:\Users\msdak\OneDrive\Desktop\Kargil-winning-camp\OS\F\processes"

# Define process class
class Process:
    def __init__(self, pid, priority, type, file_path):
        self.pid = pid
        self.priority = priority
        self.type = type
        self.file_path = file_path
        self.state = "New"
        self.execution_time = 1

# Create processes
processes = [
    Process("T1", 1, "Text", os.path.join(directory_path, "1.txt")),
    Process("T2", 1, "Text", os.path.join(directory_path, "2.txt")),
    Process("P1", 2, "Python", os.path.join(directory_path, "p1.py")),
    Process("P2", 2, "Python", os.path.join(directory_path, "p2.py")),
    Process("F1", 1, "Function", "pyramid"),
    Process("F2", 1, "Function", "revpyramid"),
    Process("F3", 1, "Function", "pyramid")
]

# Queues
new_queue = deque()
ready_queue = deque(maxlen=3)
running_state = None
waiting_queue = deque(maxlen=3)
suspended_queue = deque(maxlen=3)

# Add processes to new queue
for process in processes:
    new_queue.append(process)

# Function to move process to ready queue based on priority
def load_to_ready_queue():
    global new_queue, ready_queue, suspended_queue
    while len(ready_queue) < 3 and new_queue:
        process = new_queue.popleft()
        process.state = "Ready"
        ready_queue.append(process)

    # If ready queue is full, move extra processes to suspended queue
    while len(new_queue) > 0:
        process = new_queue.popleft()
        process.state = "Suspended"
        suspended_queue.append(process)

# Function to simulate running state
def run_process():
    global running_state, ready_queue, waiting_queue
    if running_state is None and ready_queue:
        running_state = ready_queue.popleft()
        running_state.state = "Running"
    
    if running_state:
        display_waiting_queue()
        print(f"Running process: {running_state.pid}")
        execute_process(running_state)
        time.sleep(running_state.execution_time)
        io_interrupt = running_state.type == "Python" and running_state.execution_time > 1
        if io_interrupt:
            running_state.state = "Waiting"
            waiting_queue.append(running_state)
        else:
            running_state.state = "Terminated"
        running_state = None

# Function to execute process
def execute_process(process):
    if process.type == "Text":
        with open(process.file_path, 'r') as file:
            for line in file:
                print(line.strip())
                time.sleep(1)  # Simulate the time taken to process each line
    elif process.type == "Python":
        subprocess.run(["python", process.file_path], shell=True)
    elif process.type == "Function":
        if process.file_path == "pyramid":
            pyramid()
        elif process.file_path == "revpyramid":
            revpyramid()

# Function to handle waiting queue
def handle_waiting_queue():
    global waiting_queue, ready_queue, suspended_queue
    while waiting_queue and len(ready_queue) < 3:
        process = waiting_queue.popleft()
        process.state = "Ready"
        ready_queue.append(process)

    while suspended_queue and len(ready_queue) < 3:
        process = suspended_queue.popleft()
        process.state = "Ready"
        ready_queue.append(process)

# Function to display queues
def display_queues():
    headers = ["PID", "Priority", "Type", "State"]
    all_queues = {
        "Ready Queue": ready_queue,
        "Waiting Queue": waiting_queue,
        "Suspended Queue": suspended_queue
    }
    
    for queue_name, queue in all_queues.items():
        print(f"{queue_name}:")
        table = [[p.pid, p.priority, p.type, p.state] for p in queue]
        print(tabulate(table, headers=headers))
        print()

# Functions defined within the script
def pyramid():
    n = int(input("Enter N: "))
    for i in range(1, n + 1):
        for j in range(n - i):
            print(" ", end="")
        for k in range(1, 2*i):
            print("*", end="")
        print()
        time.sleep(1)  # Simulate the time taken to process each line

def revpyramid():
    n = int(input("Enter N: "))
    for i in range(n, 0, -1):
        for j in range(n - i):
            print(" ", end="")
        for k in range(2*i - 1):
            print("*", end="")
        print()
        time.sleep(1)  # Simulate the time taken to process each line

# Simulate the process life cycle
while any([new_queue, ready_queue, running_state, waiting_queue, suspended_queue]):
    load_to_ready_queue()
    run_process()
    handle_waiting_queue()
    display_queues()
    time.sleep(1)
