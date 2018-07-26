context("fec specifications")
source("helpers.R")
library(magrittr)

test_that("fec widgets meet specifications on standard input", {

    checker <- function(lb, expected_sql) {
        test_sql <- stringr::str_replace_all(to_sql(lb), "\\s+", " ")
        expected_sql <- stringr::str_replace_all(
            expected_sql, "\\s+", " "
        )
        expect_identical(test_sql, expected_sql)
    }




    test_comm <- fec_gave_to_committee(C00639591)
    checker(test_comm,
            "select distinct entity_id from (
            select fec.entity_id as entity_id from rdata.fec
            where cmte_id IN ('C00639591')
            group by fec.entity_id having sum(transaction_amt) >= 0.01
            )")

    test_cand <- fec_gave_to_candidate(H6CA22125)
    checker(test_cand,
            "select distinct entity_id from (
            select fec.entity_id as entity_id from rdata.fec
            where cmte_id in (
            select fec_ccl.cmte_id as cmte_id
            from rdata.fec_ccl
            where cand_id IN ('H6CA22125')
            )
            group by fec.entity_id having sum(transaction_amt) >= 0.01
    )")

    test_pty <- fec_gave_to_party(DEM)
    checker(test_pty,
            "select distinct entity_id from (
            select fec.entity_id as entity_id from rdata.fec
            where cmte_id in (
            select fec_committees.cmte_id as cmte_id
            from rdata.fec_committees
            where cmte_pty_affiliation IN ('DEM')
            )
            group by fec.entity_id having sum(transaction_amt) >= 0.01
    )")

    test_cat <- fec_gave_to_category(JE300)
    checker(test_cat,
            "select distinct entity_id from (
            select fec.entity_id as entity_id from rdata.fec
            where cmte_id in (
            select fec_cmte_category.cmte_id as cmte_id
            from rdata.fec_cmte_category
            where cmte_code IN ('JE300')
            )
            group by fec.entity_id having sum(transaction_amt) >= 0.01
    )")
})
