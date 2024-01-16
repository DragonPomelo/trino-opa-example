package access
import data.abac_am

allow_access_catalog {
    print("accessing abac_am")
    abac_am.f(100) == "A"
}
