package filters
import data.admin
import data.abac_am

filter_catalog {
    not admin.user_is_admin
	input.action.operation == "FilterCatalogs"
    user_catalogs := abac_am.user_attributes["catalogs"]
    print(user_catalogs)
	input.action.resource.catalog.name in user_catalogs
}