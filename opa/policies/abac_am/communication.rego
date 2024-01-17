package abac_am

import future.keywords.if

user_attributes(user_id) := value {
    print(user_id)
    url := concat("", ["http://abac_api:8081/users?user_id=", user_id])
    value := http.send({"method": "GET", "url": url}).body
    print(url)
    print(value)
}

table_attributes(catalog_name, schema_name, table_name) := value {
    url := concat("", ["http://abac_api:8081/users?user_id=", "scott"])
    value := http.send({"method": "GET", "url": url}).body
}