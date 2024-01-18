package policies
import data.admin
import data.rls
import data.cms
import data.filter
import future.keywords.if
import future.keywords.contains
import data.access

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

# allow {
#     not true
# }

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
    filter_type := input.action.operation

}


rowFilters {
    rls.filter
}

columnMask {
    cms.mask
}