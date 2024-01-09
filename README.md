## Setup
The setup includes building the trino with the plugin and lanching opa-trino docker compose

### Building Trino
- `cd trino`
- `docker build -t trino:opa-plugin .`
- `cd ..`
### opa-trino docker compose
- `cd opa-trino-compose`
- `docker compose up --build --detach`

### Publish policy
For publishing access_policy_user.rego we will run
`curl -X PUT --data-binary @access_policy_user.rego http://localhost:8181/v1/policies/main`

### Deploy API
- `python -m api.main`