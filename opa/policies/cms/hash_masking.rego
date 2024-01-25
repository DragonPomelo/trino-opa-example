package cms

#TODO: check how to take the hmac key from external source, and make it implement the current date
hash_masking(column_name, column_type, secret_key) := expression {
    check_column_general_type(column_type, "varchar") == "varchar"
    expression := {"expression": sprintf("CAST(to_base64(hmac_md5(to_utf8(%v), to_utf8('124356676363'))) AS %v)",[column_name, column_type])}
}

hash_masking(column_name, column_type, secret_key) := expression {
    check_column_general_type(column_type, "bigint") == "bigint"
    expression := {"expression": sprintf("crc32(hmac_sha256(to_big_endian_64(%v), to_utf8('%v')))",[column_name, secret_key])}
}
check_column_general_type(column_type, general_type) := general_type {
    contains(column_type, general_type)
}