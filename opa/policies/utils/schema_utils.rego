package utils
import data.abac_am
import future.keywords.in
import future.keywords.if

user_can_access_schema(user_id, catalog_name, schema_name) if {
    user_has_access_to_at_least_one_table(user_id, catalog_name, schema_name)
}

user_has_access_to_at_least_one_table(user_id, catalog_name, schema_name) if {
    tables_of_schema := abac_am.all_tables_in_schema(catalog_name, schema_name)
    some table_obj in tables_of_schema
    user_can_access_table(user_id, catalog_name, schema_name, table_obj.table_name)
}


