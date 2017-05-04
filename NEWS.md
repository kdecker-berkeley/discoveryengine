### bugfixes
* `household` now uses the `household_entity_id` rather than `hh_corp_entity_id` #34 (thanks to AM for noticing the problem)
* `matrix_bot` was not returning any results, thanks to DT for catching the error

# discoveryengine 0.1.8
Showing all changes since version 0.1.6:

### new widgets
* add predictive model widgets for CNR and HSB scores (`has_cnr_score` and `has_haas_score`)
* added `entities` and `funds`, two widgets for working with hand-curated lists (see #15, also requested by ML and VF)
* added `job_title_like` widget for doing text search on job titles (BC)
* added `rated_by` widget to search by researcher(s) or research date
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

