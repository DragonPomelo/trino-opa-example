package access
import input

allow_catalog {
    # TODO: implement acces through the abac_api to only allow known users
    print(input)
	input.action.operation == "AccessCatalogs"
}

allow_catalog {
    # TODO: implement acces through the abac_api to only allow known users
    print(input)
	input.action.operation == "ExecuteQuery"
}