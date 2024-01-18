package cms
import data.admin
import data.abac_am
import input
import future.keywords.in
import data.cms

default hash_mask := ""
column_name := input.action.resource.column.columnName
column_type := input.action.resource.column.columnType
user_id := input.context.identity.user
catalog_name := input.action.resource.column.catalogName
schema_name := input.action.resource.column.schemaName
table_name := input.action.resource.column.tableName

user_attributes := abac_am.user_attributes(user_id)
table_attributes := abac_am.table_attributes(catalog_name, schema_name, table_name)

get_column_attributes = column_attributes {
    some i in table_attributes.columns_list[i]
    column_attributes := i
}

user_need_masking {
    user_attributes.mask
}

column_needs_masking {
    column_attributes.mask
    column_attributes.column_name == column_name
}

# To move to access column
column_attributes_match_user_attributes {
    some user_attribute in user_attributes.attributes
    user_attribute.content_world == table_attributes.content_world
    user_attribute.classification == column_attributes.classification 
}


mask := hash_mask {
    column_attributes_match_user_attributes
    user_need_masking
    column_needs_masking
    column_attributes.mask == "hash"
    hash_mask := hash_masking(column_name, column_type)
}

mask := star_mask {
    column_attributes_match_user_attributes
    user_need_masking
    column_needs_masking
    column_attributes.mask == "star"
    star_mask := star_masking
}