build_logic <- function(parameter = NULL, aggregate_parameter = NULL,
                        switches = NULL, aggregate_switches = NULL) {

    # a widget can at most have one parameter
    if (!is.null(parameter) && !is.null(aggregate_parameter))
        stop("too many parameters")

    where <- list()
    having <- list()

    if (!is.null(parameter))
        where <- c(where, parameter)
    if (!is.null(switches))
        where <- c(where, switches)
    if (!is.null(aggregate_parameter))
        having <- c(having, aggregate_parameter)
    if (!is.null(aggregate_switches))
        having <- c(having, aggregate_switches)

    not_null <- function(x) !is.null(x)
    where <- Filter(not_null, where)
    having <- Filter(not_null, having)

    list(where = where, having = having)
}
