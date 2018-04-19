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
),

phil_affin as (
select distinct
'has_philanthropic_affinity' as widget,
other_affinity_type as code,
other_affinity_type_desc as description,
count (distinct savedlist.entity_id) over (partition by other_affinity_type) as overlap,
count (distinct savedlist.entity_id) over () as sl_total,
count (distinct tags.entity_id) over (partition by other_affinity_type) as tag_cnt,
count(distinct tags.entity_id) over () as total
from cdw.d_oth_phil_affinity_mv tags
left join savedlist on tags.entity_id = savedlist.entity_id
),

industry as (
select distinct
'works_in_industry' as widget,
sic_code as code,
sic_code_desc as description,
count (distinct savedlist.entity_id) over (partition by sic_code) as overlap,
count (distinct savedlist.entity_id) over () as sl_total,
count (distinct tags.entity_id) over (partition by sic_code) as tag_cnt,
count(distinct tags.entity_id) over () as total
from cdw.d_bio_employment_mv tags
left join savedlist on tags.entity_id = savedlist.entity_id
where sic_code is not null
),

occupation as (
select distinct
'has_occupation' as widget,
fld_of_spec_code1 as code,
fld_of_spec_1_desc as description,
count (distinct savedlist.entity_id) over (partition by fld_of_spec_code1) as overlap,
count (distinct savedlist.entity_id) over () as sl_total,
count (distinct tags.entity_id) over (partition by fld_of_spec_code1) as tag_cnt,
count(distinct tags.entity_id) over () as total
from cdw.d_bio_employment_mv tags
left join savedlist on tags.entity_id = savedlist.entity_id
where trim(fld_of_spec_code1) is not null
),

event as (
select distinct
'attended_event' as widget,
activity_code as code,
activity_desc as description,
count (distinct savedlist.entity_id) over (partition by activity_code) as overlap,
count (distinct savedlist.entity_id) over () as sl_total,
count (distinct tags.entity_id) over (partition by activity_code) as tag_cnt,
count(distinct tags.entity_id) over () as total
from cdw.d_bio_activity_mv tags
left join savedlist on tags.entity_id = savedlist.entity_id
where activity_participation_code IN ('P', 'ST', 'SP', 'V', 'H', 'S', 'C', 'KN', 'MD', 'E', 'OL')
),

award as (
select distinct
'received_award' as widget,
awd_honor_code as code,
awd_honor_desc as description,
count (distinct savedlist.entity_id) over (partition by awd_honor_code) as overlap,
count (distinct savedlist.entity_id) over () as sl_total,
count (distinct tags.entity_id) over (partition by awd_honor_code) as tag_cnt,
count(distinct tags.entity_id) over () as total
from cdw.d_bio_awards_and_honors_mv tags
left join savedlist on tags.entity_id = savedlist.entity_id
),

philaffin as (
select distinct
'has_philanthropic_interest' as widget,
affinity_type as code,
affinity_type_desc as description,
count (distinct savedlist.entity_id) over (partition by affinity_type) as overlap,
count (distinct savedlist.entity_id) over () as sl_total,
count (distinct tags.entity_id) over (partition by affinity_type) as tag_cnt,
count(distinct tags.entity_id) over () as total
from cdw.d_philanthropic_interest_mv tags
left join savedlist on tags.entity_id = savedlist.entity_id
where stop_date is null
),

fec_category as (
select distinct
'fec_gave_to_category' as widget,
fec_cmte_category.cmte_code as code,
fec_cmte_category.catname as description,
count (distinct savedlist.entity_id) over (partition by fec_cmte_category.cmte_code) as overlap,
count (distinct savedlist.entity_id) over () as sl_total,
count (distinct tags.entity_id) over (partition by fec_cmte_category.cmte_code) as tag_cnt,
count(distinct tags.entity_id) over () as total
from rdata.fec tags
    inner join rdata.fec_cmte_category on tags.cmte_id = fec_cmte_category.cmte_id
    left join savedlist on tags.entity_id = savedlist.entity_id

),

fec_candidate as (
select distinct
'fec_gave_to_candidate' as widget,
fec_candidates.cand_id as code,
first_value(fec_candidates.cand_name) over (partition by fec_candidates.cand_id) as description,
count (distinct savedlist.entity_id) over (partition by fec_candidates.cand_id) as overlap,
count (distinct savedlist.entity_id) over () as sl_total,
count (distinct tags.entity_id) over (partition by fec_candidates.cand_id) as tag_cnt,
count(distinct tags.entity_id) over () as total
from rdata.fec tags
    inner join rdata.fec_ccl
        on tags.cmte_id = fec_ccl.cmte_id
        and tags.fec_cycle = fec_ccl.fec_cycle
    inner join rdata.fec_candidates
        on fec_ccl.fec_cycle = fec_candidates.fec_cycle
        and fec_ccl.cand_id = fec_candidates.cand_id
    left join savedlist on tags.entity_id = savedlist.entity_id
),

ca_candidate as (
select distinct
'ca_gave_to_candidate' as widget,
ca_candidates.candidate_id as code,
first_value(ca_candidates.candidate) over (partition by ca_candidates.candidate_id) as description,
count (distinct savedlist.entity_id) over (partition by ca_candidates.candidate_id) as overlap,
count (distinct savedlist.entity_id) over () as sl_total,
count (distinct tags.entity_id) over (partition by ca_candidates.candidate_id) as tag_cnt,
count(distinct tags.entity_id) over () as total
from rdata.ca_campaign tags
inner join rdata.ca_campaign_candidate ca_candidates
on tags.filing_id = ca_candidates.filing_id
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
union
select * from phil_affin where overlap >= ##MIN_CUTOFF##
union
select * from industry where overlap >= ##MIN_CUTOFF##
union
select * from occupation where overlap >= ##MIN_CUTOFF##
union
select * from event where overlap >= ##MIN_CUTOFF##
union
select * from award where overlap >= ##MIN_CUTOFF##
union
select * from philaffin where overlap >= ##MIN_CUTOFF##
union
select * from fec_category where overlap >= ##MIN_CUTOFF##
union
select * from fec_candidate where overlap >= ##MIN_CUTOFF##
union
select * from ca_candidate where overlap >= ##MIN_CUTOFF##
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
#' @param ... One or more disco engine definitions and/or individual entity IDs
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
matrix_bot <- function(...) {
    MIN_EFFECT <- 5
    PROB_CUTOFF <- 1E-10

    #stopifnot(listbuilder::get_id_type(savedlist) == "entity_id")
    savedlist <- entity_id_param(...)

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

    if (length(bigmap) == 0L)
        stop("Bleep bloop. Sorry, matrix bot didn't find anything",
             call. = FALSE)

    lblist <- Map(function(fun, df)
        do.call(fun, list(df[["code"]])),
        names(bigmap), bigmap)

    lb <- Reduce(`%or%`, lblist)
    structure(lb,
              bot_results = bigmap,
              class = c("matrix_bot", "bot_results", "listbuilder", class(bigmap)))
}
