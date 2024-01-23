package filters

import future.keywords.if

filter_resource if {
	filter_catalogs
}

filter_resource if {
	filter_schemas
}
filter_resource if {
	filter_tables
}

filter_resource if {
	filter_columns
}