# ABAC Authorization with Trino and OPA using External API

## Overview

This project demonstrates how to implement Attribute-Based Access Control (ABAC) authorization in Trino (formerly known as PrestoSQL) using Open Policy Agent (OPA). The unique aspect of this implementation is that user attributes and schema/table/column information are dynamically fetched from an external API.

## Requirements

- Trino Server
- Open Policy Agent (OPA)
- External API providing user attributes and schema information
- Docker (For containerized deployment)


## Docker Deployment:

Use the provided Docker Compose file (docker-compose.yml) for a containerized deployment. Update the environment variables in the file according to your configuration.
- `docker compose up --build --detach`

## Usage

### Publish policy
For publishing access_policy_user.rego we will run
- `curl -X PUT --data-binary @access_policy_user.rego http://localhost:8181/v1/policies/main`

For check if the policy was succeffuly published run:
- `curl http://localhost:8181/v1/policies`
