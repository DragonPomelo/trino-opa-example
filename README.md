## Setup
The setup includes building the trino with the plugin and lanching opa-trino docker compose

### Building Trino
- `cd trino`
- `docker build -t trino:opa-plugin .`
- `cd ..`
### opa-trino docker compose
- `cd opa-trino-compose`
- `docker compose up --build`