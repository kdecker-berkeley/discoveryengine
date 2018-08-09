proposal_query <- function() {
    "
select
    prop.proposal_id,
    nvl(asst.assignment_id, 0) as assignment_id,
    prop.prospect_id,
    prop.proposal_type,
    prop.stage_code as current_stage,
    lag(stg.stage_code, 1) over (partition by prop.proposal_id, nvl(asst.assignment_id, 0)
    order by stg.stage_date, stg.proposal_stage_id) as stage_from,
    stg.stage_code as stage_to,
    stg.stage_date as stage_transition_date,
    case when stg.stage_date between asst.start_date and nvl(asst.stop_date, sysdate) then 'Y' else 'N' end as assigned_at_transition,
    case when prop.actual_ask_date between asst.start_date and nvl(asst.stop_date, sysdate) then 'Y' else 'N' end as assigned_at_ask,
    prop.active_ind as proposal_active,
    prop.target_ask_date, prop.target_ask_amt,
    prop.actual_ask_date, prop.actual_ask_amt,
    prop.commmit_turndown_date as commit_date,
    prop.commit_turndown_amt as commit_amt,
    prop.booked_date, prop.booked_amt, prop.balance_amt,
    prop.start_dt as proposal_start_date,
    case when prop.active_ind = 'Y'
    then sysdate
    else nvl(prop.commmit_turndown_date, sysdate)
    end as proposal_stop_date,
    asst.start_date as assignment_start_date,
    nvl(asst.stop_date, sysdate) as assignment_stop_date,
    asst.office_code, asst.assignment_entity_id,
    asst.assignment_type, asst.active_ind as asst_active
    from       cdw.f_proposal_summary_mv prop
    inner join cdw.f_proposal_stage_mv stg
        on prop.proposal_id = stg.proposal_id
    left join  cdw.f_assignment_mv asst
        on  prop.proposal_id = asst.proposal_id
"}
