#' Interest code widget
#'
#' Find entities with a given interest(s)
#'
#' If no interests are entered, widget will search for entities with any interest
#' code.
#'
#' @return A definition of type \code{entity_id}
#'
#' @param ... Interest code(s)
#' @param include_former If TRUE, will include all interest codes,
#' even if they have a stop date. If FALSE (default), will exclude codes with a stop date.
#' @param include_children If TRUE, will include interest codes in the interest group listed
#' (for example, when searching "health", if TRUE, will include interest codes
#' such as Aging, Nutritional Science, Parkinson's Disease, etc.).
#' @param comment (Optional) Supply one or more search terms to search through
#' the comment fields of the interest area
#'
#' @examples
#' has_interest(data_science)
#'
#' ## prospects for cancer research can be interest coded with "cancer"
#' ## or with the more general "health"
#' has_interest(cancer) %or% has_interest(health, comment = "cancer")
#'
#' @export
has_interest <- function(..., include_children = FALSE, include_former = FALSE, comment = NULL) {
    interests <- prep_dots(...)
    reroute(has_interest_(interests, include_former = include_former, include_children = include_children,
                          comment = comment))
}

has_interest_ <- function(interests, include_children = FALSE, include_former = FALSE, comment = NULL) {
    interest_codes <- readr::read_csv("R:/Prospect Development/Prospect Analysis/discoveryengine/inst/extdata/interest_codes.csv")

    if (include_former) former_switch <- NULL
    else former_switch <- quote(stop_dt %is% null)

    comment_switch <- regex_switch("comment1 || comment2", comment)

    interest_list <- as.data.frame(resolve_codes(prep_string_param(interests, "interest_code"), type = "interest_code",
                                                 width = NULL, side = "left", pad = 0))

    colnames(interest_list)<-c("INTEREST_GROUP_CODE")
    add_codes <- dplyr::select(dplyr::inner_join(interest_codes, interest_list, by = "INTEREST_GROUP_CODE"), INTEREST_CODE)
    colnames(interest_list)<-c("INTEREST_CODE")
    interest_list <- distinct(dplyr::bind_rows(interest_list, add_codes))
    interests_with_children <- as.list(interest_list$INTEREST_CODE)

    if (include_children) param = string_param("interest_code", interests_with_children)
    else param = string_param("interest_code", interests)

    entity_widget("d_bio_interest_mv",
                  parameter = param,
                  switches = list(former_switch,
                                  comment_switch))
}


