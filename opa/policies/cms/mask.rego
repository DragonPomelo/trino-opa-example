package cms
import data.admin
import data.abac_am
import data.access
import data.utils
import input
import future.keywords.in

default hash_mask := ""
secret_key := opa.runtime().env.SECRET_KEY

mask := hash_mask {
    access.column_attributes_match_user_attributes
    user_need_masking
    column_needs_masking
    access.column_attributes.attributes.mask == "id"
    hash_mask := hash_masking(utils.column_name, utils.column_type, secret_key)
}

mask := star_mask {
    access.column_attributes_match_user_attributes
    user_need_masking
    column_needs_masking
    access.column_attributes.attributes.mask == "star"
    star_mask := star_masking
}