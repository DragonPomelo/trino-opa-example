package cms

hash_masking(column_name, column_type) = expression{
    expression := {"expression": sprintf("CAST(to_base64(hmac_md5(to_utf8(%v), to_utf8('124356676363'))) AS %v)",[column_name, column_type])}
}