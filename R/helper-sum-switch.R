sum_switch <- function(field_name, amount) {
    stopifnot(is.numeric(amount))
    sum_field_name <- paste("sum(", field_name, ")", sep = "")
    .call <- list(
        quote(`>=`),
        as.name(sum_field_name),
        amount
    )
    as.call(.call)
}
