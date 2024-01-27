package utils
import data.abac_am
import data.utils
import future.keywords.in
import future.keywords.if

user_can_access_table(user_id, catalog_name, schema_name, table_name) if {
    table_obj := abac_am.table_attributes(catalog_name, schema_name, table_name)
    user_has_access_to_at_least_one_column(user_id, catalog_name, schema_name, table_obj)
}

user_has_access_to_at_least_one_column(user_id, catalog_name, schema_name, table_obj) if {
    some column_name, column_obj in table_obj.columns_dict
    utils.user_can_access_column(user_id, catalog_name, schema_name, table_obj, column_name)
}