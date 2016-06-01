#' Capacity widget
#' @param ... capacity rating codes (eg: 1, 10, 99)
#' @export
has_capacity <- function(...) {
    d_entity_widget(
        parameter = integer_param("capacity_rating_code", ...,
                                  default = 1:14)
    )
}
