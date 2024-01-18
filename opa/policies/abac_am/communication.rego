package abac_am

import input
import future.keywords.in

table_attributes := {"table_name": "partsupp","content_world": "logistics", "row_filter": false}
column_attributes := {"column_name": "nationkey","classification": "common","mask": "hash"}
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

get_user_attributes(column_name) = api_user_attributes {
    api_user_attributes = user_attributes
}

get_table_attributes(table_name) = api_table_attributes {
    api_table_attributes = table_attributes
}

get_column_attributes(column_name) = api_column_attributes {
    api_column_attributes = column_attributes
}