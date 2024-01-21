def load_iceberg_data():
    import os
    import socket
    import time

    from opa_client import OpaClient

    import trino

    trino_host = os.getenv("TRINO_URL", "localhost")

    # insert data to datalake using trino
    def wait_for_service(host, port):
        while True:
            try:
                with socket.create_connection((host, port), timeout=1):
                    print(f"Service at {host}:{port} is reachable.")
                    time.sleep(10)
                    break
            except (socket.timeout, ConnectionRefusedError):
                print(f"Waiting for service at {host}:{port}...")
                time.sleep(1)

    # Wait for Trino to be ready
    wait_for_service(trino_host, 8080)

    # Connect to Trino (assuming it's running on localhost and the default port)
    conn = trino.dbapi.connect(host=trino_host, port=8080, user="admin")

    # Create a cursor to execute SQL queries
    cursor = conn.cursor()

    # Read SQL script from a file
    with open("datalake_insert_data.sql", "r") as file:
        sql_statements = file.read().split(";")  # Split statements by semicolon

    # Execute each SQL statement
    for sql_statement in sql_statements:
        sql_statement = sql_statement.strip()
        if sql_statement:
            cursor.execute(sql_statement)

    # Commit the changes
    conn.commit()
    print("inserted data to datalake")
    # Close the Trino connection
    conn.close()
