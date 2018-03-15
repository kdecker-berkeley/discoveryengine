code_query <- function(tms = NULL) {
    if (!assertthat::is.string(tms)) stop("tms must be a string")
    if (!tms %in% names(code_xref)) tms <- "DEFAULT"
    data <- code_xref[[tms]]
    if ("where" %in% names(data)) {
        data$haswhere <- TRUE
        data$where <- paste("where", paste(data$where, collapse = " and "))
    }

    tmpl <- code_table_template()
    whisker::whisker.render(tmpl, data = data)
}

code_table_template <- function() {
"
select distinct
    {{{code_field}}} as code,
    {{{desc_field}}} as description,
    {{{table_field}}} as table_name,
    {{{view_field}}} as view_name,
    lower(regexp_replace(regexp_replace(trim({{{desc_field}}}), '([^A-Za-z0-9 //_-])', ''), '((( )+)|-|(\\/))+', '_')) as syn
from {{{code_table}}}
{{#haswhere}}
{{{where}}}
{{{/haswhere}}}
"
}

code_xref <- list(
    geo_code = list(
        code_field = "geo_code",
        desc_field = "geo_code_description",
        table_field = "'MSA'",
        view_field = "'geo_code'",
        code_table = "cdw.d_geo_metro_area_mv",
        where = "geo_type = 1"
    ),

    fec_cmte_id = list(
        code_field = "cmte_id",
        desc_field = "cmte_nm",
        table_field = "'FEC Committees'",
        view_field = "'fec_cmte_id'",
        code_table = "rdata.fec_committees"
    ),

    fec_cand_id = list(
        code_field = "cand_id",
        desc_field = "cand_name",
        table_field = "'FEC Candidates'",
        view_field = "'fec_cand_id'",
        code_table = "rdata.fec_candidates"
    ),

    fec_cmte_code = list(
        code_field = "cmte_code",
        desc_field = "catname",
        table_field = "'FEC Committee Categories'",
        view_field = "'fec_cmte_code'",
        code_table = "rdata.fec_cmte_category"
    ),

    DEFAULT = list(
        code_field = "tms_type_code",
        desc_field = "tms_type_desc",
        table_field = "tms_table_name",
        view_field = "tms_view_name",
        code_table = "cdw.d_tms_type_mv"
    )
)

