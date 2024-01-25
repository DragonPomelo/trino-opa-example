package utils

import data.abac_am

user_attributes := abac_am.user_attributes(user_id)

table_attributes := abac_am.table_attributes(catalog_name, schema_name, table_name)

content_world_attributes := abac_am.content_world_attributes(table_attributes.attributes.content_world)