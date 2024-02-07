# ABAC Authorization with Trino and OPA using External API

## Overview

This project demonstrates how to implement Attribute-Based Access Control (ABAC) authorization in Trino (formerly known as PrestoSQL) using Open Policy Agent (OPA). The unique aspect of this implementation is that user attributes and schema/table/column information are dynamically fetched from an external API.

![Architecture](architecture/ABAC_Architecture.png)

## Requirements

- Docker (For containerized deployment)


## Docker Deployment:

Use the provided Docker Compose file (docker-compose.yml) for a full containerized deployment. Update the environment variables in the file according to your configuration.
- update your `.env` file as the one in the `dockerized_opa.env`
- `docker compose --profile opa up --build --detach`

Use the folowing command for dockerized environment with local opa:
- Change the `.env` file with the following: `OPA_URL=host.docker.internal` or just copy past `local_opa.env`
- `opa build --v1-compatible opa/policies`
- `export ABAC_API_URL=localhost` - export the `ABAC_API_URL` so it could be accessible in the rego file
- `export SECRET_KEY=secretkey123` - export the `SECRET_KEY` so it could be accessible in the rego file
- `opa run --v1-compatible -s --addr localhost:8181 -b bundle.tar.gz`
- `docker compose up --build --detach`

## pre-commit
- install pre-commit
- run `pre-commit install`
- check your changes with `pre-commit run`

## Usage

For checking that your policies are ok you can run:
`opa check ./opa/policies/`

### Publish policy
For publishing the policies you just need to make sure that there in the your git repo


For modifiying opal server to point to your git repo and the branch you can modifiy `.env` file in the root of the project


For check if the policy was succeffuly published run:
- `curl http://localhost:8181/v1/policies`


## Project services

### Services overview
- trino: A Trino (formerly PrestoSQL) service for distributed SQL query processing.
- opa: Open Policy Agent for policy-based access control.
- abac_api: An API service for Attribute-Based Access Control (ABAC).
- attribute_db: MongoDB service for storing attributes of users and resources (catalogs, schemas, tables and columns).
- rest: Iceberg REST service for interacting with a data lake, with dependencies on Postgres and Minio.
- postgres: PostgreSQL database service for storing metadata for the datalake catalog.
- minio: Minio, an object storage server compatible with Amazon S3.
- mc: Minio Client for managing Minio server.

### Services and Ports

- trino: http://localhost:8080
- opa: http://localhost:8181
- abac_api: http://localhost:8081
- attribute_db: MongoDB on port 27017
- rest: Iceberg REST service on http://localhost:8183
- postgres: PostgreSQL on port 5432
- minio: Minio on http://localhost:9000 (console on http://localhost:9001)
- mc: Minio Client (configured for Minio server)


