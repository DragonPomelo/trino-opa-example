package access
import data.abac_am
import input.context.identity.user

allow_access_catalog {
    # get user attributes
    user_attrs := abac_am.user_attributes(user)
    user_attrs["user_id"] == "scott"
}