package trino
import future.keywords.contains
import future.keywords.every

default allow = false
default single_resource = false

allow {
    headers = {
        "Content-Type": "application/json",
        "Accept": "application/json"
    }

	print(input)
	url := concat("", ["http://localhost:8081/users?user_id=", input.context.identity.user])
    print(url)
	response = http.send({"method": "get", "url": "http://localhost:8081/users?user_id=8398239", "headers": headers})
	print("shohhhaaaam")
	print(response)
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