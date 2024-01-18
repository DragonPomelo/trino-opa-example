package cms
import data.admin
import data.abac
import input
import future.keywords.in

default hash_mask := ""
column_name := input.action.resource.column.columnName
column_type := input.action.resource.column.columnType

column_attributes := abac.get_column_attributes(column_name)
user_attributes := abac.get_user_attributes(input.user)
table_attributes := abac.get_table_attributes(column_name)

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


mask := hash_masking {
    # column_attributes_match
    # user_need_masking
    column_needs_masking
    column_attributes.mask == "hash"
}

mask := star_masking {
    # column_attributes_match
    # user_need_masking
    column_needs_masking
    column_attributes.mask == "star"
}