## Setup
The setup includes building the trino with the plugin and lanching opa-trino docker compuse

### Building Trino
- `cd trino`
- `docker build -t trino:opa-plugin .`
- `cd ..`
### opa-trino docker compose
- `cd opa-trino-compose`
- `cd docker compose up --build .`