package policies
import data.abac_am
import data.admin
import data.rls
import data.cms
import data.filter
import data.access
import data.filters
import future.keywords.if
import future.keywords.contains

#  ----------------------------------------------
# That section handle the policies for the admin user
allow {
    abac_am.if_user_exists(input.context.identity.user)
    admin.allow_admin
    print(input)
}

single_resource {
    abac_am.if_user_exists(input.context.identity.user)
    admin.allow_admin
    print(input)
}

# ----------------------------------------------
# That section handle the policies for the regular user
allow {
    abac_am.if_user_exists(input.context.identity.user)
    access.allow_resource
}

single_resource {
    abac_am.if_user_exists(input.context.identity.user)
    filters.filter_resource
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


rowFilters {
    rls.filter
}

columnMask {
    cms.mask
}