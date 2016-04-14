gave_to_aog_ <- function(aogs, atleast = 0, from = NULL,
                         to = NULL, env = parent.frame()) {
    param <- aogs
    param <- resolve_codes(param, "")
    atleast <- atleast
    param1 <- substitute(alloc_school_code %in% param)

    from <- resolve_date(from)
    to <- resolve_date(to)

    if (is.null(from)) {
        if (is.null(to))
            dateparam <- NULL
        else
            dateparam <- substitute(giving_record_dt <= to_date(to, 'yyyymmdd'))
    } else {
        if (is.null(to))
            dateparam <- substitute(giving_record_dt >= to_date(from, 'yyyymmdd'))
        else
            dateparam <- substitute(between(giving_record_dt,
                                            to_date(from, 'yyyymmdd'),
                                            to_date(to, 'yyyymmdd')))
    }

    if (length(param) > 0) params <- list(param1)
    else params <- NULL

    if (!is.null(dateparam)) params <- c(params, list(dateparam))

    params <- c(params, list(substitute(pledged_basis_flg == "Y")))

    atleast <- substitute(sum(benefit_aog_credited_amt) >= atleast)
    aggregate_q_(table = "f_transaction_detail_mv",
                 where = params,
                 having = list(atleast),
                 id_field = "donor_entity_id_nbr",
                 id_type = "cads_id",
                 schema = "CDW", env = env)
}

gave_to_aog <- function(..., atleast = 0,
                        from = NULL, to = NULL,
                        env = parent.frame()) {
    param <- pryr::dots(...)
    param <- prep_string_param(param, env = env)
    gave_to_aog_(param, atleast = atleast,
                 from = from, to = to, env = env)
}
