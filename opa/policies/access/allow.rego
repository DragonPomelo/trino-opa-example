package access

import data.access
import input

allow_resource {
    access.allow_catalog
}

allow_resource {
    access.allow_show_catalogs
}

allow_resource {
    access.allow_schema
}

allow_resource {
    access.allow_show_tables
}

allow_resource {
    access.allow_show_schema
}
