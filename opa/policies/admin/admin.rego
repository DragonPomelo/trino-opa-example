package admin
import input


allow_admin {
    user_is_admin
}

user_is_admin {
    input.context.identity.user = "admin"
}

user_is_admin {
    input.context.identity.user = "scott"
}