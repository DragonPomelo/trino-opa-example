package access
import data.utils
import future.keywords.if

allow_for_resource_catalog(operation, resource) if {
    operation == "AccessCatalog"
    utils.user_can_access_catalog(utils.user_id, resource.catalog.name)
}

allow_for_resource_catalog(operation, resource) if {
    operation == "ShowSchemas"
    utils.user_can_access_catalog(utils.user_id, resource.catalog.name)
}

allow_for_resource_catalog(operation, resource) if {
	operation == "FilterCatalogs"
    utils.user_can_access_catalog(utils.user_id ,resource.catalog.name)
}