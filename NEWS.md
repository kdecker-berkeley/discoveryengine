# discoveryengine 0.1.7.9006
* added `entities` and `funds`, two widgets for working with hand-curated lists

# discoveryengine 0.1.7.9005
* added `rated_by` widget to search by researcher(s) or research date

# discoveryengine 0.1.7.9004

* Publishing is now possible. See `publish`, `list_singles`, `show_singles`, and `find_singles`. This is a convenient way to share your disco-code with colleagues, especially useful if there are standard definitions we should all be using. Thanks to TK and ML.
* Fixed a bug in `in_suspect_pool` where using it without arguments (just typing `in_suspect_pool()` with nothing in the parentheses) resulted in a malformed disco definition. Consistent with almost every other widget, there is now a default for when no arguments are entered -- any entity in any suspect pool will be returned.

# discoveryengine 0.1.7.9003

* Synonym tables are now created on-the-fly. This means that they will always reflect the current status of the TMS tables, but also that specific synonyms may change unexpectedly (when AIM changes TMS descriptions). There are still hard-coded synonyms for common uses (eg: "business" or "natural_resources")

# discoveryengine 0.1.7.9002

* Added `has_position` widget (B.C.)
* Fixed bug in `works_in_industry` and `has_occupation` where defaults caused ` invalid relational operator` errors

# discoveryengine 0.1.7.9001

* Added `lives_near` and `works_near` widgets (#22, @datalover916)

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

