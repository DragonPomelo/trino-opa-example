## Setup Service

The Setup Service is responsible for handling all the setup tasks for the project. It consists of three main functionalities:

1. Inserting data to MongoDB: This service inserts data into the MongoDB database.
2. Inserting data to the Datalake: This service inserts data into the Datalake.
3. Uploading OPA Policies: On startup, the service uploads all the Rego policies to OPA.

## Load OPA Policies

The `load_opa_policies` function is responsible for uploading the OPA policies to the OPA endpoint. It achieves this by iterating over the policies subfolder in the OPA main folder in the root of this repository. Each policy is uploaded to the endpoint with the name of the subfolder and the name of the policy file.

For example, if we have a policy file named `admin.rego` in the `admin` subfolder, the policy will be uploaded under the name `admin_admin`.

Please note that the specific implementation details of the `load_opa_policies` function are not provided in this README.

