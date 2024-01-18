package abac_am

import future.keywords.if

user_attributes(user_id) := value {
    url := concat("", ["http://abac_api:8081/users?id=", user_id])
    value := http.send({"method": "GET", "url": url}).body
}

table_attributes(catalog_name, schema_name, table_name) := value {
    url := concat("", ["http://abac_api:8081/tables?catalog=", "scott", "&schema=", schema_name, "&table=", table_name])
    value := http.send({"method": "GET", "url": url}).body
}

content_world_attributes(cw_name) := value {
    url := concat("", ["http://abac_api:8081/content_worlds?name=", cw_name])
    value := http.send({"method": "GET", "url": url}).body
}