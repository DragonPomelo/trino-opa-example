package trino
import future.keywords.contains
import future.keywords.every
import future.keywords.if

default allow = false
default single_resource = false
url := concat("", ["http://abac_api:8081/users?user_id=", input.context.identity.user])
user_attributes := http.send({"method": "GET", "url": url}).body
allow {
    headers = {
        "Content-Type": "application/json",
        "Accept": "application/json"
    }
    print("user_attributes")
	print(user_attributes)
}

single_resource {
    print("FilterCatalogs")
    input.action.operation == "FilterCatalogs"
}

single_resource {
    print("FilterSchemas")
    input.action.operation == "FilterSchemas"
}


single_resource {
    print("FilterTables")
    input.action.operation == "FilterTables"
    requested_table := {"catalog_name": input.action.resource.table.catalogName, "schema_name": input.action.resource.table.schemaName, "table_name": input.action.resource.table.tableName}
	print(requested_table)
    headers = {
        "Content-Type": "application/json",
        "Accept": "application/json"
    }
    table_attributes := http.send({"method": "POST", "url": "http://abac_api:8081/tables","body": requested_table, "headers": headers}).body
    print("table_attributes")
    print(table_attributes)
    print(user_attributes)
    table_attributes.content_world == user_attributes[0].content_world
	# attributes_match(user_attributes, table_attributes)
}
# =================Functions=================

# If the intersection of the two arrays(user and table attributes) matches the user array, allow 
attributes_match(user_attributes, table_attributes) if {
    # attributes := {user_attributes |
    #     some i
    #     parts := split(string, ",")
    #     user_attributes := parts[i]
    # }

    inter_atr := user_attributes[0] & table_attributes
    inter_atr == user_attributes[0]
    print( "inter=", inter_atr)
}

apple(color){
    color == "red"
}
# ================== batch ==================

# ... rest of the policy ...
# this assumes the non-batch response field is called "allow"
batch contains i {
    some i
    raw_resource := input.action.filterResources[i]
    single_resource with input.action.resource as raw_resource
}

# Corner case: filtering columns is done with a single table item, and many columns inside
# We cannot use our normal logic in other parts of the policy as they are based on sets
# and we need to retain order
batch contains i {
    some i
    input.action.operation == "FilterColumns"
    count(input.action.filterResources) == 1
    raw_resource := input.action.filterResources[0]
    count(raw_resource["table"]["columns"]) > 0
    new_resources := [
        object.union(raw_resource, {"table": {"column": column_name}})
        | column_name := raw_resource["table"]["columns"][_]
    ]
    single_resource with input.action.resource as new_resources[i]
}