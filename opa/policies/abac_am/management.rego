package abac_am
import input
import future.keywords.if

user_catalogs(user_id) := returned_user_catalogs if {
    returned_user_attributes := user_attributes(user_id)
    returned_user_catalogs = returned_user_attributes["catalogs"]
}