package access
import input

allow_catalog {
    # TODO: implement acces through the abac_api to only allow known users
	input.action.operation == "ShowCatalogs"
}