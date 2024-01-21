package access
import future.keywords.if
import data.abac_am
import data.input

allow_show_tables if {
	input.action.operation == "ShowColumns"
    # user_has_access_for_requested_table()
}

user_has_access_for_requested_table(catalog_name, schema_name, table_name) if {
    user_has_access_for_at_least_one_column(catalog_name, schema_name, table_name)
}

user_has_access_for_at_least_one_column(catalog_name, schema_name, table_name) if {
    abac_am.table_attributes(catalog_name, schema_name, table_name)
    # TODO implement this rule
    true
}