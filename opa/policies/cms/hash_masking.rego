package cms

hash_masking(column_name, column_type) = expression {
    check_column_general_type("varchar") == "varchar"
    expression := {"expression": sprintf("CAST(to_base64(hmac_md5(to_utf8(%v), to_utf8('124356676363'))) AS %v)",[column_name, column_type])}
}

hash_masking(column_name, column_type) = expression {
    check_column_general_type(column_type, "bigint") == "bigint"
    expression := {"expression": sprintf("crc32(lpad(hmac_md5(to_big_endian_64(%v), to_utf8('124356676363')), 8, from_base32('0645d')))",[column_name])}
}

check_column_general_type(column_type, general_type) = general_type {
    contains(column_type, general_type)
}