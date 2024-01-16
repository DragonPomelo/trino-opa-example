package filters
import future.keywords.if
import future.keywords.contains
import input
import data.admin

single_resource {
    admin.allow_admin
}

filter(filter_type) {
    input.action.operation == "FilterCatalogs"
    count(input.action.filterResources) == 1
    raw_resource := input.action.filterResources[0]
    count(raw_resource["table"]["columns"]) > 0
    new_resources := [
        object.union(raw_resource, {"table": {"column": column_name}})
        | column_name := raw_resource["table"]["columns"][_]
    ]
    single_resource with input.action.resource as new_resources[i]
}

filter(filter_type) {
    input.action.operation == "FilterTables"
    count(input.action.filterResources) == 1
    raw_resource := input.action.filterResources[0]
    count(raw_resource["columns"]) > 0
    new_resources := [
        object.union(raw_resource, {"table": {"column": column_name}})
        | column_name := raw_resource["columns"][_]
    ]
    single_resource with input.action.resource as new_resources[i]
}