package abac_am

import future.keywords.if
import future.keywords.in

opa_abac_api := opa.runtime().env.ABAC_API_URL

user_attributes(user_id) := value if {
	url := concat("", [sprintf("http://%v:8081/users?id=", [opa_abac_api]), user_id])
	value := http.send({"method": "GET", "url": url}).body
}

if_user_exists(user_id) if {
	url := sprintf("http://%v:8081/users", [opa_abac_api])
	value := http.send({"method": "GET", "url": url}).body
	some user in value
	user == input.context.identity.user
}

table_attributes(catalog_name, schema_name, table_name) := value if {
	url := concat("", [sprintf("http://%v:8081/tables?catalog=", [opa_abac_api]), catalog_name, "&schema=", schema_name, "&table=", table_name])
	value := http.send({"method": "GET", "url": url}).body
}

content_world_attributes(cw_name) := value if {
	url := concat("", [sprintf("http://%v:8081/content_worlds?name=", [opa_abac_api]), cw_name])
	value := http.send({"method": "GET", "url": url}).body
}

all_tables_in_schema(catalog_name, schema_name) := value if {
	url := concat("", [sprintf("http://%v:8081/tables?catalog=", [opa_abac_api]), catalog_name, "&schema=", schema_name])
	value := http.send({"method": "GET", "url": url}).body
}