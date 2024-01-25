package access

import data.access
import future.keywords.if

allow_for_resource(operation, resource) if {
    access.allow_for_resource_catalog(operation, resource)
}

allow_for_resource(operation, resource) if {
    access.allow_for_resource_schema(operation, resource)
}

allow_for_resource(operation, resource) if {
    access.allow_for_resource_table(operation, resource)
}