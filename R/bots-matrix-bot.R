matrix_bot_query_template <- getcdw::parameterize_template(
"
with savedlist as (
##disco##
),

sa as (
select distinct
'participated_in' as widget,
student_activity_code as code,
student_activity_desc as description,
count (distinct savedlist.entity_id) over (partition by student_activity_code) as overlap,
count (distinct savedlist.entity_id) over () as sl_total,
count (distinct tags.entity_id) over (partition by student_activity_code) as tag_cnt,
count(distinct tags.entity_id) over () as total
from cdw.d_bio_student_activity_mv tags
left join savedlist on tags.entity_id = savedlist.entity_id
),

dept as (
select distinct
'gave_to_department' as widget,
alloc_dept_code as code,
alloc_department_desc as description,
count (distinct savedlist.entity_id) over (partition by alloc_dept_code) as overlap,
count (distinct savedlist.entity_id) over () as sl_total,
count (distinct tags.donor_entity_id_nbr) over (partition by alloc_dept_code) as tag_cnt,
count(distinct tags.donor_entity_id_nbr) over () as total
from cdw.f_transaction_detail_mv tags
left join savedlist on tags.donor_entity_id_nbr = savedlist.entity_id
where benefit_dept_credited_amt > 0
),

affil as (
select distinct
'has_affiliation' as widget,
affil_code as code,
affil_code_desc as description,
count (distinct savedlist.entity_id) over (partition by affil_code) as overlap,
count (distinct savedlist.entity_id) over () as sl_total,
count (distinct tags.entity_id) over (partition by affil_code) as tag_cnt,
count(distinct tags.entity_id) over () as total
from cdw.d_bio_affiliation_mv tags
left join savedlist on tags.entity_id = savedlist.entity_id
),

major as (
select distinct
'majored_in' as widget,
major_code1 as code,
major_1_desc as description,
count (distinct savedlist.entity_id) over (partition by major_code1) as overlap,
count (distinct savedlist.entity_id) over () as sl_total,
count (distinct tags.entity_id) over (partition by major_code1) as tag_cnt,
count(distinct tags.entity_id) over () as total
from cdw.d_bio_degrees_mv tags
left join savedlist on tags.entity_id = savedlist.entity_id
where local_ind = 'Y'
and degree_year <> ' '
and major_code1 <> 'UNK'
),

interest as (
select distinct
'has_interest' as widget,
interest_code as code,
interest_desc as description,
count (distinct savedlist.entity_id) over (partition by interest_code) as overlap,
count (distinct savedlist.entity_id) over () as sl_total,
count (distinct tags.entity_id) over (partition by interest_code) as tag_cnt,
count(distinct tags.entity_id) over () as total
from cdw.d_bio_interest_mv tags
left join savedlist on tags.entity_id = savedlist.entity_id
),

sport as (
select distinct
'played_sport' as widget,
sport_code as code,
sport_desc as description,
count (distinct savedlist.entity_id) over (partition by sport_code) as overlap,
count (distinct savedlist.entity_id) over () as sl_total,
count (distinct tags.entity_id) over (partition by sport_code) as tag_cnt,
count(distinct tags.entity_id) over () as total
from cdw.d_bio_sport_mv tags
left join savedlist on tags.entity_id = savedlist.entity_id
)

select * from sa where overlap >= ##MIN_CUTOFF##
union
select * from dept where overlap >= ##MIN_CUTOFF##
union
select * from affil where overlap >= ##MIN_CUTOFF##
union
select * from major where overlap >= ##MIN_CUTOFF##
union
select * from interest where overlap >= ##MIN_CUTOFF##
union
select * from sport where overlap >= ##MIN_CUTOFF##
")

matrix_bot_query <- function(sl)
    matrix_bot_query_template(
        disco = to_sql(sl),
        MIN_CUTOFF = 10)


#' Broaden a search using co-occurrence analysis
#'
#' The \code{matrix_bot} takes a disco engine definition and compares it to
#' other codes in CADS, looking for patterns of co-occurrence. That is, it
#' analyzes individuals who match your definition, looking for other codes they
#' have in common.
#'
#' @param savedlist A disco engine definition
#'
#' @examples
#' ## we start out with a basic definition of interst in Chicano Studies
#' chicano_interest = majored_in(chicano_studies) %or% gave_to_department(CHICANO)
#'
#' ## now the matrix_bot discovers related characteristics, such as
#' ## majoring in ethnic studies or participating in MEChXA
#' matrix_bot(chicano_interest)
#'
#' @export
matrix_bot <- function(savedlist) {
    MIN_EFFECT <- 5
    PROB_CUTOFF <- 1E-10

    stopifnot(listbuilder::get_id_type(savedlist) == "entity_id")

    overlap_df <- getcdw::get_cdw(matrix_bot_query(savedlist))
    overlap_df <- dplyr::mutate(
        overlap_df,
        prob = pbinom(
            overlap,
            size = sl_total,
            prob = tag_cnt / total,
            lower.tail = FALSE
        ), effect = (overlap / sl_total) / (tag_cnt / total))

    overlap_df <- dplyr::filter(overlap_df, effect >= MIN_EFFECT, prob < PROB_CUTOFF)
    overlap_df <- dplyr::select(overlap_df,
                                widget, code, description, effect)
    overlap_df <- dplyr::arrange(overlap_df, widget, desc(effect))
    bigmap <- dplyr::select(overlap_df, -effect)

    bigmap <- split(bigmap, bigmap$widget)

    if (length(bigmap) > 0L)
        stop("Bleep bloop. Sorry, matrix bot didn't find anything",
             call. = FALSE)

    lblist <- Map(function(fun, df)
        do.call(fun, list(df[["code"]])),
        names(bigmap), bigmap)

    lb <- lblist[[1]]
    lb <- Reduce(`%or%`, lblist[-1], init = lb)
    structure(lb,
              matrix_bot_results = bigmap,
              class = c("matrix_bot", "listbuilder", class(bigmap)))
}

#' @export
print.matrix_bot <- function(bigmap, ...) {
    printres <- function(df) {
        cat(df[["widget"]][[1]], "\n")
        codes <- df$code
        descr <- df$description
        for (index in seq_along(codes))
            cat("    ", codes[[index]], ": ", descr[[index]], "\n", sep = "")
    }

    lapply(attr(bigmap, "matrix_bot_results"), printres)
    invisible(bigmap)
}
