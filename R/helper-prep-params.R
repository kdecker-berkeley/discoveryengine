prep_integer_param <- function(ints) {
    param <- decorate_with_modifier(ints)
    modifiers <- get_modifiers(param)

    # after removing any modifiers such as not(),
    # an integer param should just evaluate to an integer-ish vector
    param <- lazyeval::lazy_eval(param)
    param <- as.integer(unlist(param))
    param <- param[!is.na(param)]
    param <- unique(param)
    attributes(param) <- modifiers
    param
}

prep_string_param <- function(param, field_name) {
    param <- Filter(function(x) !is.null(x), param)
    if (length(param) <= 0) return(character(0))

    # some codes have a integer/numeric form, eg activity codes
    param <- lapply(param,
                    function(x) if (is.numeric(x)) as.character(x) else x)

    # if input included quoted 0xxx, that will be evaluated by the interpreter
    # as an integer and the leading zeroes will drop.

    leading_zero_indices <- grepl("^0", param)
    param <- lapply(param, lazyeval::as.lazy)

    param <- decorate_with_modifier(param)
    modifiers <- get_modifiers(param)

    # can hijack the interpreter to have custom commands within
    # widgets with string params. eg widget_name(?search) to look
    # for synonyms
    check_for_instructions(field_name, param)

    interpreted_param <- partial_sub(param)

    # just replace with the original "0xx"
    if (any(leading_zero_indices))
        interpreted_param[leading_zero_indices] <- param[leading_zero_indices]
    interpreted_param <- as.character(unlist(interpreted_param))
    interpreted_param <- interpreted_param[!is.na(interpreted_param)]
    interpreted_param <- unique(interpreted_param)
    attributes(interpreted_param) <- modifiers
    interpreted_param
}

decorate_with_modifier <- function(param) {
    res <- structure(param, negation = FALSE)

    if(any(is_negation(param))) {
        if (any(!is_negation(param)))
            stop("can't use not() with regular codes within the same widget",
                 call. = FALSE)
        res <- unwrap_modified_param(param)
        if (any(is_negation(res))) stop("not(not()): no double negatives")
        res <- structure(res, negation = TRUE)
    }
    res
}

unwrap_modified_param <- function(param) {
    parses <- lapply(param, function(x) as.list(x$expr))
    envirs <- lapply(param, function(x) x$env)
    res <- lapply(parses, function(x) x[-1])
    res <- Map(function(elems, envir) {
        lazyeval::as.lazy_dots(elems, env = envir)
    }, elems = res, envir = envirs)
    lazyeval::as.lazy_dots(purrr::flatten(res))
}

get_modifiers <- function(param) {
    mods <- attributes(param)
    mods[names(mods) %in% known_modifiers()]
}

known_modifiers <- function() {
    "negation"
}

is_negation <- function(param) {
    parses <- lapply(param, function(x) as.list(x$expr))
    vapply(parses, function(x) identical(x[[1]], quote(`not`)),
           FUN.VALUE = logical(1))
}

prep_zip_param <- function(param, field_name) {
    param <- Filter(function(x) !is.null(x), param)
    if (length(param) <= 0) return(character(0))

    param <- lapply(param, lazyeval::as.lazy)

    param <- decorate_with_modifier(param)
    modifiers <- get_modifiers(param)

    res <- partial_sub(param)
    attributes(res) <- modifiers
    res
}

prep_regex_param <- function(...) {
    terms <- list(...)

    argnames <- unique(names(terms))
    argnames <- Filter(function(x) x != "", argnames)
    if (length(argnames) > 0)
        stop("Unrecognized argument(s): ", paste(argnames, collapse = ", "),
             call. = FALSE)
    as.character(unlist(terms))
}

prep_id_param <- function(ids) {
    param <- Filter(function(x) !is.null(x), ids)
    if (length(param) <= 0) return(NULL)
    param <- lapply(param, lazyeval::as.lazy)

    param <- decorate_with_modifier(ids)
    modifiers <- get_modifiers(param)

    res <- param
    attributes(res) <- c(attributes(res), modifiers)
    res
}
