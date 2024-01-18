package filters
import data.admin
import data.abac_am
import input
import future.keywords.in
from future.keywords.some

filter_catalog {
	input.action.operation == "FilterCatalogs"
    print("Filtering catalogs")
    user_catalogs := abac_am.user_attributes(input.context.identity.user)["catalogs"]
    print(user_catalogs)
    some catalog in user_catalogs 
    catalog == input.action.resource.catalog.name
}