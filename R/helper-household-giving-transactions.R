household_giving_transactions <- function()
"
select
  e.entity_id,
hh.* from (
select
household_entity_id,
cads_giving_receipt_nbr,
giving_record_dt,
allocation_cd,
alloc_school_code,
alloc_dept_code,
max(pledged_basis_flg) as pledged_basis_flg,
max(benefit_aog_credited_amt) as benefit_aog_credited_amt,
max(benefit_dept_credited_amt) as benefit_dept_credited_amt,
max(transaction_amt) as transaction_amt
from (
select
(select household_entity_id from cdw.d_entity_mv ent where ent.entity_id = tx.donor_entity_id_nbr) as household_entity_id,
tx.donor_entity_id_nbr,
tx.cads_giving_receipt_nbr,
tx.giving_record_dt,
tx.allocation_cd,
tx.alloc_school_code,
tx.alloc_dept_code,
max(tx.pledged_basis_flg) as pledged_basis_flg,
sum(tx.benefit_aog_credited_amt) as benefit_aog_credited_amt,
sum(tx.benefit_dept_credited_amt) as benefit_dept_credited_amt,
max(tx.transaction_amt) as transaction_amt
from
cdw.f_transaction_detail_mv tx
inner join cdw.d_entity_mv ent on tx.donor_entity_id_nbr = ent.entity_id
group by
tx.donor_entity_id_nbr,
tx.cads_giving_receipt_nbr,
tx.giving_record_dt,
tx.allocation_cd,
tx.alloc_school_code,
tx.alloc_dept_code
) group by
household_entity_id,
cads_giving_receipt_nbr,
giving_record_dt,
allocation_cd,
alloc_school_code,
alloc_dept_code)
hh inner join cdw.d_entity_mv e on hh.household_entity_id = e.household_entity_id
"
