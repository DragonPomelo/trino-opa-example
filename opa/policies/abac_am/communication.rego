package abac_am

import future.keywords.if

opa_abac_api := opa.runtime().env["ABAC_API_URL"]

user_attributes(user_id) := value {
    url := concat("", [sprintf("http://%v:8081/users?id=",[opa_abac_api]), user_id])
    value := http.send({"method": "GET", "url": url}).body
}

table_attributes(catalog_name, schema_name, table_name) := value {
    url := concat("", [sprintf("http://%v:8081/tables?catalog=",[opa_abac_api]), "scott", "&schema=", schema_name, "&table=", table_name])
    value := http.send({"method": "GET", "url": url}).body
}

content_world_attributes(cw_name) := value {
    url := concat("", [sprintf("http://%v:8081/content_worlds?name=",[opa_abac_api]), cw_name])
    value := http.send({"method": "GET", "url": url}).body
}