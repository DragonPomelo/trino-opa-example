package rls

import data.utils
import future.keywords.in
import future.keywords.contains
import future.keywords.if

filter_values_list contains val_string if {
	some attr in utils.user_attributes.attributes
    row_filtering_needed(attr)
    some val in attr.filter_value
    val_string := sprintf("%d", [val])
}

row_filtering_needed(user_attribute) if {
	user_attribute.filter_value
	user_attribute.content_world == utils.table_attributes.attributes.content_world
}