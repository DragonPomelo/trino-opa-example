package cms

import data.utils
import data.abac_am
import data.access
import future.keywords.in
import future.keywords.if

user_need_masking {
    utils.user_attributes.mask
}

column_needs_masking := true if {
    access.column_attributes.attributes.mask
    access.column_attributes.column_name == utils.column_name
}
