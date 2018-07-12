#' Find entities who made SEC filings
#'
#' Find entities who have filed an SEC Form 3/4/5. Data is based on a match of
#' CADS entities to SEC disclosures
#'
#' @return A definition of type \code{entity_id}
#'
#' @param ... Central Index Key for one or more companies -- if blank, will look at all SEC filings
#' @param from begin and end dates (filed between those dates). Enter as integer of the form YYYYMMDD
#' @param to begin and end dates (filed between those dates). Enter as integer of the form YYYYMMDD
#' @param director Look for people listed as directors? See details
#' @param officer Look for people listed as officers? See details
#' @param ten_percenter Look for people listed as ten percent owners? See details
#' @param other Look for people with some other relationship to the company? See details
#' @param title_text Search term to look for in filer's free-text entry for officer or other
#' @param verified See details
#'
#' @details By default, all matched filings are included in the search. If
#' \code{verified} is TRUE, then only those that have been verified by the
#' Prospect Discovery Team are included. If \code{verified} is FALSE, then only
#' filings that have NOT been verified by Prospect Discovery are included.
#' #'
#' Since this is based on a probabilistic match score, there will be some
#' false positive matches. If perfect accuracy is necessary, be sure to manually
#' review the results. You might want to use the `screening` chunk from the
#' `discoappend` package, which outputs links to filings on the SEC's website.
#'
#' SEC Form 4 includes checkboxes for "Director," "Officer," "ten percent owner,"
#' and "Other" to specify the filer's relationship to the company. Furthermore,
#' filers who check "officer" can enter their title as free text, and those who
#' check "Other" can similarly enter their title or other explanatory text.
#' Search these entries using the `title_text` argument.
#'
#' @examples
#' ## look up companies using the usual look-up feature
#' sec_filed(?twitter)
#'
#' ## with a code, i can now pull any filers with Twitter:
#' sec_filed(1418091)
#'
#' ## To look for anyone who's filed during calendar year 2017:
#' sec_filed(1418091, from = 20170101, to = 20171231)
#'
#' ## find people who are 10% owners of any company
#' sec_filed(ten_percenter = TRUE)
#'
#' ## find filers with any company who have listed their title as "chairman"
#' sec_filed(title_text = "chairman")
#'
#' @name sec
#' @export
sec_filed <- function(..., from = NULL, to = NULL, director = NULL,
          officer = NULL, ten_percenter = NULL, other = NULL,
          title_text = NULL, verified = NULL) {
    reroute(sec_filed_(prep_dots(...), from = from, to = to,
                       director = director, officer = officer,
                       ten_percenter = ten_percenter, other = other,
                       title_text = title_text, verified = verified))
}


sec_filed_ <- function(issuers, from = NULL, to = NULL, director = NULL,
           officer = NULL, ten_percenter = NULL, other = NULL,
           title_text = NULL, verified = NULL) {

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
            title_text_switch
        ),
        schema = "rdata"
    )

    res <- converter_builder(
        issuers,
        table = "sec_cik_dict",
        from = "cik",
        from_type = "sec_cik",
        to = "entity_id",
        to_type = "entity_id",
        schema = "rdata"
    )

    if (is.null(verified)) return(res)

    verified_sql <- "
select entity_id, to_number(other_id) as cik
from cdw.d_ids_base
where ids_type_code = 'SEC'
  and not regexp_like(other_id, '[^0-9]')
    "

    if (verified)
        return(
            converter_builder_custom(
                issuers,
                custom = verified_sql,
                from = "cik",
                from_type = "sec_cik",
                to = "entity_id",
                to_type = "entity_id"
            )
        )

    if (!verified)
        return(
            converter_builder_custom(
                issuers,
                custom = paste("select * from rdata.sec_cik_dict\nminus\n", verified_sql),
                from = "cik",
                from_type = "sec_cik",
                to = "entity_id",
                to_type = "entity_id"
            )
        )

    stop("Unexpected error")
}
