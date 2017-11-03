#' FEC disclosure widgets
#'
#' Find entities who have disclosed political contributions in a federal election.
#' Data is based on a match of CADS entities to FEC disclosures.
#'
#' @return A definitio of type \code{entity_id}
#'
#' @param ... FEC Candidate or Committee code(s)
#' @param at_least Minimum of total contributions
#' @param from begin and end dates (contributed between those dates). Enter as integer of the form YYYYMMDD
#' @param to begin and end dates (contributed between those dates). Enter as integer of the form YYYYMMDD
#'
#' @details Since this is based on a probabilistic match score, there will be some
#' false positive matches. If perfect accuracy is necessary, be sure to manually
#' review the results. Also, FEC disclosure forms show giving to committees that are
#' registered with the FEC. In order to determine giving to a particular candidate,
#' we use a crosswalk linking candidates to the committees that support them.
#' In some instances, a committee will support multiple candidates, so for
#' example a search for contributors to Kamala Harris's senate campaign will
#' include in the results any contributors to the committee "Off the Sidelines Senate 2016",
#' which, in addition to Kamala Harris, also supported Tammy Duckworth and Catherine Masto.
#' Furthermore, some political donors will give to a PAC that then turns around and
#' gives to a different committee, and somewhere down the line they support a political
#' candidate. These donors may not be found when searching using \code{fec_gave_to_candidate}.
#'
#' @name fec
#' @export
fec_gave_to_committee <- function(..., at_least = .01, from = NULL, to = NULL) {
    cmtes <- prep_dots(...)
    reroute(fec_gave_to_committee_(cmtes, at_least = at_least,
                                   from = from , to = to))
}

fec_gave_to_committee_ <- function(cmtes, at_least = .01, from = NULL, to = NULL) {
    if (!is.numeric(at_least)) stop("at_least must be a number")
    if (length(at_least) != 1L) stop("need a single amount for at_least")

    widget_builder(
        table = "fec",
        id_field = "entity_id",
        id_type = "entity_id",
        parameter = string_param("cmte_id", cmtes),
        switches = list(
            daterange("transaction_dt", from, to)
        ),
        aggregate_switches = sum_switch("transaction_amt", at_least),
        schema = "rdata"
    )
}
