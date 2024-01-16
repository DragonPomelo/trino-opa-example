package cms
import data.admin

default column_name := ""
column_resource := input.action.resource.column

# will be replaced by api call
mask_type := "hash"

mask(column_name) = column_mask {
    mask_type == "star"
    column_mask := star_masking(column_name)
}

mask(column_name) = column_mask {
    mask_type == "hash"
    column_mask := hash_masking(column_name) 
}

# star_masking.rego
star_masking(column_name) = star_mask {
    # not admin.user_is_admin
    column_resource.columnName == column_name
#        column_needs_masking(column_name)
    print("column_masking")
    print(input)
    star_mask := {"expression": "Null"}
}

# hash_masking.rego
hash_masking(column_name) = hash_mask {
    # not admin.user_is_admin
    column_resource.columnName == column_name
#        column_needs_masking(column_name)
    print("column_masking")
    print(input)
    # hashmasking for varchar55
    hash_mask := {"expression": "CAST(to_base64(hmac_md5(to_utf8(comment), to_utf8('124356676363'))) AS VARCHAR(55))"}
}