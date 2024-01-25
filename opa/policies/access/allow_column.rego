package access

import data.abac_am
import data.input
import data.utils
import future.keywords.in
import future.keywords.if
import input
allow_show_tables if {
	input.action.operation == "ShowColumns"
    # user_has_access_for_requested_table()
}

# user_has_access_for_requested_table(catalog_name, schema_name, table_name) if {
#     user_has_access_for_at_least_one_column(catalog_name, schema_name, table_name)
# }

user_has_access_for_at_least_one_column(catalog_name, schema_name, table_name) if {
    abac_am.table_attributes(catalog_name, schema_name, table_name)
    # TODO implement this rule
    true
}

column_attributes := attributes {
    some column in utils.table_attributes.columns_list
    column.column_name == utils.column_name
    attributes := column
}

column_attributes_match_user_attributes {
    some user_attribute in utils.user_attributes.attributes
    user_attribute.content_world == utils.table_attributes.attributes.content_world
}