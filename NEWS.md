### new widgets
* `lives_in_foreign_country` and `works_in_foreign_country` for international prospecting (# 35, thanks to BC) 
* `has_engineering_score` for the new engineering model (thanks to LC). 
* `fund_type` and `gave_to_fund_type` (see #37, thanks to AM/EK/LC)
* `minored_in` (see #38, thanks to AM)
* `age_between` (see #39, thanks to LC)

### features
* `display` method for `listbuilder::report`s. This allows PD to easily extend the disco engine with custom reporting, for example see `discoappend` (https://github.com/cwolfsonseeley/discoappend/).

### bugfixes and or implementation changes
* `household` now uses the `household_entity_id` rather than `hh_corp_entity_id` #34 (thanks to AM for noticing the problem)
* `matrix_bot` was not returning any results, thanks to DT for catching the error
* address-based widgets (like `lives_in_*` and `works_in_*`) changed their default behavior. For example, it used to be that `lives_in_msa` when used without any arguments would pull anyone with a home address, but now it will only pull anyone with a home address that has an MSA. 
* updated to keep pace with the new `dplyr` setup, specifically updated functions to rely on exports from `dbplyr` instead of `dplyr`. 

# discoveryengine 0.1.8
Showing all changes since version 0.1.6:

### new widgets
* add predictive model widgets for CNR and HSB scores (`has_cnr_score` and `has_haas_score`)
* added `entities` and `funds`, two widgets for working with hand-curated lists (see #15, also requested by ML and VF)
* added `job_title_like` widget for doing text search on job titles (BC)
* added `rated_by` widget to search by researcher(s) or research date (LC)
* Added `has_position` widget (B.C.)
* Added `lives_near` and `works_near` widgets (#22, @datalover916)

### new bots
* the `matrix_bot` allows you to do broader, more open-ended prospecting (see https://tarakc02.github.io/discodocs/matrix-bot.html). If `brainstorm_bot` is like looking up a book in the card catalog, `matrix_bot` is like walking into the stacks and looking at all the books nearby the one you're picking up.

### features
* Publishing is now possible. See `publish`, `list_singles`, `show_singles`, and `find_singles`. This is a convenient way to share your disco-code with colleagues, especially useful if there are standard definitions we should all be using. Thanks to TK and ML.
* make it possible to do synonym search in `related_to`
* added `include_inactive` option to `has_interest` widget (thanks to VF and AM)
* added daterange options to `majored_in` and `has_degree_from` (thanks to AM and LC)

### bug-fixes and/or changes in implementation
* fixed two bugs in `in_suspect_pool`: was not creating the correct definition in general, also failed when used without arguments (now default is to pull anyone in any suspect pool)
* Fixed bug in `works_in_industry` and `has_occupation` where defaults (ie using without arguments) caused ` invalid relational operator` errors
* Synonym tables are now created on-the-fly. This means that they will always reflect the current status of the TMS tables, but also that specific synonyms may change unexpectedly (when AIM changes TMS descriptions). There are still hard-coded synonyms for common uses (eg: "business" or "natural_resources")

# discoveryengine 0.1.6

* Added widget `in_suspect_pool` and associated viewer `show_suspect_pools` (#20, @datalover916)
* Implemented caching in `brainstorm_bot` to improve speed

# discoveryengine 0.1.5

* Added a `NEWS.md` file to track changes to the package.

## Bugs

* Add error-checking on argument names: @datalover916 noticed that `in_development_officer_portfolio(1234, include_inactive = TRUE, include_active = FALSE)` did not result in an error (but also did not result in what you would expect if you typed that). All widgets now check argument names to make sure there aren't any (#21). 

## New Widgets:
* `fund_department`
* `contact_unit`
* `has_gift_planning_score` (#17, @datalover916)
* `in_development_officer_portfolio` (#19, L.C.)
* `works_in_industry` (I.Z.)
* `has_occupation` (I.Z.)
* `has_record_type` (tarakc02/getcdw#8, @datalover916)

## brainstorm_bot
`brainstorm_bot` now searches MSAs. This may slow down its performance.

