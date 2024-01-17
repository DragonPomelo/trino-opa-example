package access
import data.abac_am
import input
allow_access_catalog {
    # get user attributes
    print(input)
    print(user)
    user_attrs := abac_am.user_attributes(input.context.identity.user)
    print(user_attrs)
    user_attrs["user_id"] == "scott"
}