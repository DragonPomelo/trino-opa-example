package cms
import data.admin
import input
import future.keywords.in

default hash_mask := ""
column_name := input.action.resource.column.columnName
column_type := input.action.resource.column.columnType

# column_attribute := abac_am.get_column_attributes(column_resource)
# user_attribute := abac_am.get_user_attributes(input.user)
# table_attribute := abac_am.get_table_attributes(column_resource)

table_attribute := {"content_world": "logistics", "row_filter": false}
column_attribute := {"column_name": "name","classification": "common","mask": "hash"}
user_attributes := {
"user_id": "scott",
"mask": true,
"attributes": [
{
"content_world": "logistics",
"classification": "sales",
"filter_value": [
5,
6
]
},
{
"content_world": "logistics",
"classification": "personnel",
"filter_value": [
3
]
},
{
"content_world": "logistics",
"classification": "common"
}
]
}

user_need_masking {
    user_attributes.mask
}

column_needs_masking {
    column_attribute.mask
    column_attribute.column_name == column_name
}

column_attribute_match {
    some user_attribute in user_attributes.attributes
    user_attribute.content_world == table_attribute.content_world
    user_attribute.classification == column_attribute.classification 
}


mask := hash_masking {
    column_attribute_match
    user_need_masking
    column_needs_masking
    column_attribute.mask == "hash"
}

mask := star_masking {
    column_attribute_match
    user_need_masking
    column_needs_masking
    column_attribute.mask == "star"
}

# star_masking.rego
star_masking = star_mask {
    star_mask := {"expression": "Null"}
}

# hash_masking.rego
hash_masking := {"expression": sprintf("CAST(to_base64(hmac_md5(to_utf8(%v), to_utf8('124356676363'))) AS %v)",[column_name, column_type])}