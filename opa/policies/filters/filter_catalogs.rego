package filters
import data.admin
import data.utils
import input
import future.keywords.in

filter_catalogs {
	input.action.operation == "FilterCatalogs"
    utils.user_can_access_catalog(input.context.identity.user ,input.action.resource.catalog.name)
}