package policies

import data.abac_am
import data.access
import data.admin
import data.cms
import data.rls
import data.utils
import future.keywords.contains
import future.keywords.if
import future.keywords.in

#  ----------------------------------------------
# That section handle the policies for the admin user
allow if {
	# abac_am.if_user_exists(input.context.identity.user)
	admin.allow_admin
	print(input)
}

# ----------------------------------------------
# That section handle the policies for the regular user
allow if {
	abac_am.if_user_exists(utils.user_id)
	access.allow_resource
}

# ----------------------------------------------

# ----------------------------------------------
# That handle the genaric case of batch operations
batch contains i if {
	some i
	raw_resource := input.action.filterResources[i]
	allow with input.action.resource as raw_resource
}

# Corner case: filtering columns is done with a single table item, and many columns inside
# We cannot use our normal logic in other parts of the policy as they are based on sets
# and we need to retain order
batch contains i if {
	some i
	input.action.operation == "FilterColumns"
	count(input.action.filterResources) == 1
	raw_resource := input.action.filterResources[0]
	count(raw_resource.table.columns) > 0
	new_resources := [
	object.union(raw_resource, {"table": {"column": column_name}}) |
		column_name := raw_resource.table.columns[_]
	]
	allow with input.action.resource as new_resources[i]
}

columnMask := column_mask if {
	column_mask := cms.mask
}

rowFilters contains row_filter if {
	row_filter := rls.filter
}
