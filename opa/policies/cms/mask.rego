package cms
import data.admin
import data.abac_am
import data.access
import data.utils
import input
import future.keywords.in

default hash_mask := ""
secret_key := opa.runtime().env.SECRET_KEY

mask := hash_mask if {
    column_attributes_match_user_attributes
    user_need_masking
    column_needs_masking
    column_attributes.attributes.mask == "id"
    hash_mask := hash_masking(utils.column_name, utils.column_type, secret_key)
}

mask := star_mask if {
    column_attributes_match_user_attributes
    user_need_masking
    column_needs_masking
    column_attributes.attributes.mask == "star"
    star_mask := star_masking
}

user_need_masking if {
    utils.user_attributes.mask
}

column_needs_masking := true if {
    column_attributes.attributes.mask
    column_attributes.column_name == utils.column_name
}

column_attributes := attributes if {
    utils.table_attributes.columns_dict[utils.column_name]
    attributes := utils.table_attributes.columns_dict[utils.column_name]
}

column_attributes_match_user_attributes if {
    some user_attribute in utils.user_attributes.attributes
    user_attribute.content_world == utils.table_attributes.attributes.content_world
}