package utils
import data.abac_am
import future.keywords.in
import future.keywords.if

user_can_access_column(user_id, catalog_name, schema_name, table_obj, column_obj) if {
    user_attributes_matched_table_content_world := get_user_attributes_matched_table_content_world(user_id, table_obj)
    some user_attribute in user_attributes_matched_table_content_world
    column_has_clasification(column_obj, user_attribute.classification)
}

get_user_attributes_matched_table_content_world(user_id, table_obj) := user_attributes_by_table_content_world if {
    user_attributes := abac_am.user_attributes(user_id).attributes
    user_attributes_by_table_content_world := {user_attribute | user_attribute = user_attributes[_]; user_attribute.content_world == table_obj.attributes.content_world }
}

column_has_clasification(column_obj, classification) if {
    column_obj.attributes.classification == classification
}
