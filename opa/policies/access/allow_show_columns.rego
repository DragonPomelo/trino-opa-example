package access
import future.keywords.if
import data.abac_am
import data.utils
import input

allow_show_columns if {
    print(input)
	input.action.operation == "ShowColumns"
}

user_has_access_for_requested_table(user_id, catalog_name, schema_name, table_name) if {
     utils.user_can_access_table(user_id, catalog_name, schema_name, table_name)
}

user_has_access_for_at_least_one_column(catalog_name, schema_name, table_name) if {
    abac_am.table_attributes(catalog_name, schema_name, table_name)

    # TODO implement this rule
    true
}