finder_builder <- function(table, id_field, id_type,
                           search_fields, search_terms,
                           switches = NULL, aggregate_switches = NULL) {
    param <- function(fieldname) regex_param(fieldname, search_terms)

    finders <- lapply(search_fields, function(search_field)
        widget_builder(
            table = table,
            id_field = id_field,
            id_type = id_type,
            parameter = param(search_field),
            switches = switches,
            aggregate_switches = aggregate_switches
        ))

    Reduce(`%or%`, finders[-1], init = finders[[1]])
}
