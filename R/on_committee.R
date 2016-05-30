#' @export
on_committee <- function(..., status = c("A", "D"), env = parent.frame()) {
    committees <- pryr::dots(...)
    on_committee_(committees, status = status, env = env)
}

on_committee_ <- function(committees, status = c("A", "D"), env = parent.frame()) {
    d_bio_widget("committee",
                 parameter = string_param("committee_code", committees, env = env),
                 switches = string_switch("status_code", status),
                 env = env)
}

## add role as another level
