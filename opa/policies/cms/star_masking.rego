package cms

star_masking(column_name) = star_mask {
    columnMask := {"expression": "*****"} if {
        not is_admin
        column_resource.columnName == column_name
#        column_needs_masking(column_name)
        print("column_masking")
        print(input)
    }
}