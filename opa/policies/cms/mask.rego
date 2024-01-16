package cms
import data.admin
import input

default column_name := ""
column_resource := input.action.resource.column.columnName


# column_attribute := abac_am.get_column_attributes(column_resource)
# user_attribute := abac_am.get_user_attributes(input.user)
# table_attribute := abac_am.get_table_attributes(column_resource)

table_attribute := {"content_world": "logistics", "row_filter": false}
column_attribute := {"classification": "common","mask": "hash"}
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



mask := hash_masking(column_name) {
    check_column_attribute
    check_if_user_need_masking
    Check_if_column_needs_masking
    check_if_masking_hash
}
mask := star_masking() {
    check_column_attribute
    check_if_user_need_masking
    Check_if_column_needs_masking
    check_if_masking_star
}

check_column_attribute if {
    some user_attribute in user_attributes.attributes
    user_attribute.content_world == table_attribute.content_world
    user_attribute.classification == column_attribute.classification
    
}

check_if_user_need_masking if {
    user_attributes.mask
}

Check_if_column_needs_masking if {
    column_attribute.mask
}

# star_masking.rego
star_masking() = star_mask {
    star_mask := {"expression": "Null"}
}

# TODO
# hash_masking.rego
# change to accept column name
hash_masking = hash_mask if {
	column_name := "zibi"
	hash_mask := {"expression": sprintf("CAST(to_base64(hmac_md5(to_utf8(%v), to_utf8('124356676363'))) AS VARCHAR(55))",[column_name])}
}