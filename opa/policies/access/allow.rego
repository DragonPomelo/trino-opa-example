package access

import data.access
import future.keywords.if
import input

allow_resource if {
	access.allow_default_access
}

allow_resource if {
	operation := input.action.operation
	resource := input.action.resource
	access.allow_for_resource(operation, resource)
}
