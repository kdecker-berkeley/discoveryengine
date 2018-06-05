sec_filed <- function(..., from = NULL, to = NULL, director = NULL,
          officer = NULL, ten_percenter = NULL, other = NULL,
          title_text = NULL) {
    reroute(sec_filed_(prep_dots(...), from = from, to = to,
                       director = director, officer = officer,
                       ten_percenter = ten_percenter, other = other,
                       title_text = title_text))
}


sec_filed_ <- function(issuers, from = NULL, to = NULL, director = NULL,
           officer = NULL, ten_percenter = NULL, other = NULL,
           title_text = NULL) {

    flag10 <- function(lgl) {
        if (is.null(lgl)) return(NULL)
        if (!assertthat::is.flag(lgl))
            stop("expected ", deparse(substitute(lgl)), " to be TRUE/FALSE or NULL, but instead it was ", lgl)
        if (lgl) 1L else 0L
    }

    director <- flag10(director)
    officer <- flag10(officer)
    ten_percenter = flag10(ten_percenter)
    other = flag10(other)

    title_text_switch <- regex_switch("officer_title || ' ' || other_text", title_text)

    issuers <- widget_builder(
        table = "sec_hdr",
        id_field = "cik",
        id_type = "sec_cik",
        parameter = string_param("issuer_cik", issuers),
        switches = list(
            daterange("filing_date", from, to),
            string_switch("is_director", director),
            string_switch("is_officer", officer),
            string_switch("is_ten_percenter", ten_percenter),
            string_switch("is_other", other),
            title_text_switch,
            daterange("filing_date", from, to)
        ),
        schema = "rdata"
    )

    converter_builder(
        issuers,
        table = "sec_cik_dict",
        from = "cik",
        from_type = "sec_cik",
        to = "entity_id",
        to_type = "entity_id",
        schema = "rdata"
    )
}
