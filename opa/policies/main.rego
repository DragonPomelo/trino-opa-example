package policies
import data.admin

import future.keywords.if
import future.keywords.contains

#  ----------------------------------------------
# That section handle the policies for the admin user
allow {
    print("Admin user is allowed to do anything")
    admin.allow_admin
}

single_resource {
    admin.allow_admin
}
# ----------------------------------------------


# ----------------------------------------------
# That section handle the policies for the regular user

allow {
    not true
}

# ----------------------------------------------

# ----------------------------------------------
# That handle the genaric case of batch operations
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