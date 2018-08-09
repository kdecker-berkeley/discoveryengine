at_least_switch <- function(field_name, amount) {
    stopifnot(is.numeric(amount), length(amount) == 1, all(amount >= 0))
    .call <- list(
        quote(`>=`),
        as.name(field_name),
        amount
    )
    as.call(.call)
}
