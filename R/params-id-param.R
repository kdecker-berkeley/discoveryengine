entity_id_param <- function(...) {
    # testcase:
    # temp <- c(548769, 3004587)
    # ents <- prep_dots(1234, entities(57575, 37374), has_capacity(1), "4576", temp, 347*5)

    ents <- prep_dots(...)
    ents <- prep_id_param(ents)
    if (length(ents) <= 0L) return(is_a(include_deceased = TRUE))
    negation <- attr(ents, "negation")

    ents <- lazyeval::lazy_eval(ents)

    literal <- vapply(
        ents,
        is.atomic,
        logical(1)
    )
    plain <- as.integer(unlist(ents[literal]))

    entity_def <- vapply(
        ents[!literal],
        function(x) listbuilder::get_id_type(x) == "entity_id",
        logical(1)
    )
    if (any(!entity_def))
        stop("Expected entity IDs or definitions of type entity_id, but got something else")

    if (all(literal)) res <- entities(plain)
    rest <- Reduce(`%or%`, ents[!literal])

    if (any(literal) && length(rest) > 0) res <- entities(plain) %or% rest
    if (!any(literal)) res <- rest

    if (!is.null(negation) && negation)
        return(is_a(include_deceased = TRUE) %but_not% res)
    else return(res)
}

allocation_id_param <- function(allocs) {
    # bloop <- fund_area(business)
    # test case: allocs <- prep_dots(FW2347, funds(FW5737), "FS3737", paste0("S", "037398"), bloop)

    null_alloc <- widget_builder(
        table = "f_allocation_mv",
        id_field = "allocation_code",
        id_type = "allocation_code"
    )

    allocs <- prep_id_param(allocs)
    if (length(allocs) <= 0L) return(null_alloc)

    negation <- attr(allocs, "negation")
    is_lb <- vapply(allocs, function(x) inherits(x$expr, "listbuilder"), FUN.VALUE = logical(1))

    allocs <- c(lapply(allocs[is_lb], function(x) x$expr), partial_sub(allocs[!is_lb]))

    literal <- vapply(
        allocs,
        function(x) is.name(x) || is.character(x),
        logical(1))

    plain <- as.character(unlist(allocs[literal]))

    evaluated <- lapply(allocs[!literal], eval)

    good_to_go <- vapply(evaluated, is.character, logical(1))
    plain <- c(plain, as.character(unlist(evaluated[good_to_go])))


    alloc_def <- vapply(
        evaluated[!good_to_go],
        function(x) listbuilder::get_id_type(x) == "allocation_code",
        logical(1)
    )
    if (any(!alloc_def))
        stop("Expected allocation codes or definitions of type allocation_code, but got something else")
    additional <- Reduce(`%or%`, evaluated[!good_to_go])

    if (all(literal)) res <- funds(plain)
    if (any(literal) && length(additional) > 0) res <- funds(plain) %or% additional
    if (!any(literal)) res <- additional

    if (!is.null(negation) && negation)
        return(null_alloc %but_not% res)
    else return(res)
}
