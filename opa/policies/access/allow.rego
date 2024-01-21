package access

import data.access
import input

allow_resource {
    print(input)
    access.allow_catalog
}

allow_resource {
    access.allow_schema
}