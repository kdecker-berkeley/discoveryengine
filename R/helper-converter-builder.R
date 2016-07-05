converter_builder <- function(lb, table,
                              from, from_type = NULL,
                              to, to_type = NULL,
                              parameter = NULL,
                              aggregate_parameter = NULL,
                              switches = NULL,
                              aggregate_switches = NULL) {

    if (is.null(from_type)) from_type <- from
    if (is.null(to_type)) to_type <- to

    stopifnot(listbuilder::get_id_type(lb) == from_type)

    # build the where and having clauses
    logic <- build_logic(parameter, aggregate_parameter,
                         switches, aggregate_switches)

    listbuilder::flist_(lb,
                        table = table,
                        from = from,
                        to = to,
                        id_type = to_type,
                        where = logic$where,
                        having = logic$having,
                        schema = "CDW")
}
