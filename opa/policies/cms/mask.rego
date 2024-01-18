package cms
import data.admin
import data.abac_am
import input
import future.keywords.in
import data.cms

default hash_mask := ""
column_name := input.action.resource.column.columnName
column_type := input.action.resource.column.columnType

column_attributes := abac_am.get_column_attributes(column_name)
user_attributes := abac_am.get_user_attributes(input.user)
table_attributes := abac_am.get_table_attributes(column_name)

user_need_masking {
    user_attributes.mask
}

column_needs_masking {
    column_attributes.mask
    column_attributes.column_name == column_name
}

column_attributes_match {
    some user_attribute in user_attributes.attributes
    user_attribute.content_world == table_attributes.content_world
    user_attribute.classification == column_attributes.classification 
}


mask := hash_mask {
    # column_attributes_match
    # user_need_masking
    column_needs_masking
    column_attributes.mask == "hash"
    hash_mask := hash_masking(column_name, column_type)
}

mask := star_mask {
    # column_attributes_match
    # user_need_masking
    column_needs_masking
    column_attributes.mask == "star"
    star_mask := star_masking
}