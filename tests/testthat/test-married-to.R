context("married_to")

test_that("married_to correctly gets spouses", {
    expect_equivalent(get_cdw(married_to(727565)), data.frame(entity_id = 727558))
})

# cnr_degreeholder = has_degree_from(NR)
# cnr_donor = gave_to_area(CNR, at_least = 5000)
#
# library(tidyverse)
#
# old_version <- display(cnr_donor %but_not% cnr_degreeholder)
#
#
# new_version <- display(
#     cnr_donor %but_not%
#         (cnr_degreeholder %or% married_to(cnr_degreeholder))
# )
#
# setdiff(old_version, new_version) # just spouses, as expected
# setdiff(new_version, old_version) # no results (as expected)

