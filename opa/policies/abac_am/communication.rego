package abac_am

import future.keywords.if

user_attributes(user_id) := value {
    url := concat("", ["http://abac_api:8081/users?user_id=", user_id])
    value := http.send({"method": "GET", "url": url}).body
}

table_attributes(catalog_name, schema_name, table_name) := value {
    url := concat("", ["http://abac_api:8081/users?user_id=", "scott"])
    value := http.send({"method": "GET", "url": url}).body
}