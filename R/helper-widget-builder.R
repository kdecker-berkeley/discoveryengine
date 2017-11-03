widget_builder <- function(table, id_field, id_type, parameter = NULL,
                           aggregate_parameter = NULL,
                           switches = NULL, aggregate_switches = NULL,
                           schema = "CDW") {
    # build the where and having clauses
    logic <- build_logic(parameter, aggregate_parameter,
                         switches, aggregate_switches)

    listbuilder::aggregate_q_(table = table,
                              where = logic$where,
                              having = logic$having,
                              id_field = id_field,
                              id_type = id_type,
                              schema = schema)
}

