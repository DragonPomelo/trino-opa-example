package access

import data.abac_am
import input

allow_schema {
	abac_am.if_user_exists(input.context.identity.user)
	input.action.operation == "SelectFromColumns"
	input.action.resource.table.catalogName == "system"
	input.action.resource.table.tableName == "schemas"
}
