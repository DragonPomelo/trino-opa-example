import multiprocessing

from load_iceberg import load_iceberg_data
from load_mongo import load_mongo_data

if __name__ == "__main__":
    # Create separate processes for each function
    mongo_process = multiprocessing.Process(target=load_mongo_data)
    iceberg_process = multiprocessing.Process(target=load_iceberg_data)

    # Start both processes
    mongo_process.start()
    iceberg_process.start()

    # Wait for both processes to finish
    mongo_process.join()
    iceberg_process.join()
