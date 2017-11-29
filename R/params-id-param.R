entity_id_param <- function(...) {
    # testcase:
    # temp <- c(548769, 3004587)
    # ents <- list(1234, entities(57575, 37374), has_capacity(1), "4576", temp, 347*5)
    ents <- list(...)
    if (length(ents) <= 0L) return(is_a(include_deceased = TRUE))

    literal <- vapply(
        ents,
        is.atomic,
        logical(1)
    )
    plain <- prep_integer_param(ents[literal])
    if (all(literal)) return(entities(plain))

    entity_def <- vapply(
        ents[!literal],
        function(x) listbuilder::get_id_type(x) == "entity_id",
        logical(1)
    )
    if (any(!entity_def))
        stop("Expected entity IDs or definitions of type entity_id, but got something else")

    rest <- Reduce(`%or%`, ents[!literal])
    if (length(plain) > 0L) return(entities(plain) %or% rest)
    else return(rest)
}

allocation_id_param <- function(allocs) {
    # test case: allocs <- prep_dots(FW2347, funds(FW5737), "FS3737", paste0("S", "037398"))
    if (length(allocs) <= 0L) return(
        widget_builder(
            table = "f_allocation_mv",
            id_field = "allocation_code",
            id_type = "allocation_code"
        )
    )
    allocs <- lapply(allocs, lazyeval::as.lazy)
    is_lb <- vapply(allocs, function(x) inherits(x$expr, "listbuilder"), FUN.VALUE = logical(1))

    allocs <- c(lapply(allocs[is_lb], function(x) x$expr), partial_sub(allocs[!is_lb]))

    literal <- vapply(
        allocs,
        function(x) is.name(x) || is.character(x),
        logical(1))

    plain <- as.character(unlist(allocs[literal]))
    if (all(literal)) return(funds(plain))

    evaluated <- lapply(allocs[!literal], eval)

    good_to_go <- vapply(evaluated, is.character, logical(1))
    plain <- c(plain, as.character(unlist(evaluated[good_to_go])))

    if (any(!good_to_go)) {
        alloc_def <- vapply(
            evaluated[!good_to_go],
            function(x) listbuilder::get_id_type(x) == "allocation_code",
            logical(1)
        )
        if (any(!alloc_def))
            stop("Expected allocation codes or definitions of type allocation_code, but got something else")
        additional <- Reduce(`%or%`, evaluated[!good_to_go])
    }
    if (length(plain) > 0L) return(funds(plain) %or% additional)
    else return(additional)
}
