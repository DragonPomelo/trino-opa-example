package utils
import data.abac_am
import future.keywords.in
import future.keywords.if

user_can_access_catalog(user_id, catalog_name) if {
    catalog_name in abac_am.user_catalogs(user_id)
}
