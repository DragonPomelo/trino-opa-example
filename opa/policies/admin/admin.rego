package admin

import input
import future.keywords.if

allow_admin if {
	user_is_admin
}

user_is_admin if {
	input.context.identity.user = "admin"
}
