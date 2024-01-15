def load_opa_policies():
    import os
    import socket
    import time

    from opa_client import OpaClient

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

    # Create an OPA client
    opa_client = OpaClient(host="opa", port=8182, version="v1")
    # Specify the base directory
    base_dir = "/usr/src/app/policies"
    # Wait for OPA to be ready
    wait_for_service("opa", 8182)
    # Iterate over all subdirectories
    for root, dirs, files in os.walk(base_dir):
        # Skip the 'examples' folder
        if "examples" in dirs:
            dirs.remove("examples")
        for file in files:
            # Check if the file is a rego file
            if file.endswith(".rego"):
                # Construct the full file path
                file_path = os.path.join(root, file)
                # Construct the policy name from the subfolder and file name
                if root == base_dir:
                    policy_name = os.path.splitext(file)[0]
                else:
                    policy_name = (
                        f"{os.path.basename(root)}_{os.path.splitext(file)[0]}"
                    )
                # Upload the policy to OPA
                print(f"Uploading policy {policy_name} from {file_path}...")
                opa_client.update_opa_policy_fromfile(file_path, policy_name)

    print("the policies uploaded to OPA are:")
    print(opa_client.get_policies_list())
