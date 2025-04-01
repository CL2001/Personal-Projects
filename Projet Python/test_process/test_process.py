from multiprocessing import Process, freeze_support
import time

def blocking_worker():
    print("Worker starting blocking call.")
    time.sleep(10)
    print("Worker finished.")

if __name__ == '__main__':
    freeze_support()  # This line is needed if you plan to freeze the code into an executable.
    
    worker_process = Process(target=blocking_worker)
    worker_process.start()
    
    time.sleep(2)  # Simulate other work
    
    worker_process.terminate()
    worker_process.join()
    
    print("Blocking process terminated. Main program continues.")
