package cms

mask(column_name) = column_mask {
    mask_type == "star"
    star_masking(column_name) 
}

mask(column_name) = column_mask {
    mask_type == "hash"
    hash_masking(column_name) 
}