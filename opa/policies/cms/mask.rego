package cms
import data.admin
import data.abac_am
import input
import future.keywords.in

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

star_masking = star_mask {
    star_mask := {"expression": "Null"}
}

hash_masking := {"expression": sprintf("CAST(to_base64(hmac_md5(to_utf8(%v), to_utf8('124356676363'))) AS %v)",[column_name, column_type])}