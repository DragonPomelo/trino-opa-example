package access

import data.access
import input

allow_resource {
    access.allow_default_access
}

allow_resource {
    operation := input.action.operation
    resource := input.action.resource
    access.allow_for_resource(operation, resource)
}
