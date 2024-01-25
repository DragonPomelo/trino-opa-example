package rls

import data.admin
import data.utils
import future.keywords.if

filter := row_filter if {
    not admin.user_is_admin
	utils.table_attributes.attributes.row_filter == true
	filter_feild := utils.content_world_attributes.filter_key
    filter_values_string := concat(", ", filter_values_list)
	expression := sprintf("%v IN (%v)", [filter_feild, filter_values_string])
	row_filter := {"expression": sprintf("%v", [expression])}
}