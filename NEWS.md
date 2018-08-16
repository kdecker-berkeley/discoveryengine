# discoveryengine 0.3.0
### new widgets
* `fec_gave_to_party` for pulling FEC-reported political contributions by political party. 
* `lives_in_state` and `works_in_state`, see #81, thanks to VF for making the request.

## implementation changes
* `attended_event` now includes participants with attendance code `IS` ("Industry Specialist"), see #79. 
* all academic widgets (such as `has_degree_from`, `majored_in`, `minored_in`, and `has_degree`) now include degree information from "UC Berkeley Academic Non Degree Programs" such as Haas's Exec Development Program. This makes it easier to pull people who did postdoctoral work at Berkeley, among other things.
* academic widgets now include an option called `advisor`, to pull based on the entity ID of the faculty advisor. See #78, thanks to LC for making the request.
* `has_degree` no longer has options for `graduates` or `undergraduates`, because those levels depend on the degree type (e.g. MBAs are always graduates, etc.)
* `related_to` now includes a `comment` option, enabling search based on the comment field of the relationship record
* more informative error messages from `lives_near` and `works_near` when there are geocoding problems, see #84. Thanks to VF for opening the issue.

# discoveryengine 0.2.1
### implementation changes
* `research_miner` now includes an option to specify the entity ID of the author of the research note, to make it possible to find bios and research notes written by specific researchers
* `sec_filed` now includes a `verified` option. By default, all matches are included. If `verified = TRUE`, then only those matches verified by Prospect Discovery are included. If `verified = FALSE` then only those matches that have not been verified by Prospect Discovery are included.

# discoveryengine 0.2.0
### new widgets
* `in_savedlist` allows you to pull entities based on membership in a savedlist created in CADS. Use `show_savedlists()` to see all available savedlists, and use the `savedlist_id` in the widget

### implementation changes
* Pipeline prospects are now included in the suspect pool tools. Use `show_suspect_pools()` to see a list of all suspect pools. Pipeline prospects are distinguished by the combination of Unit + Year, whereas other types of suspect pools are identified via Unit + comment. `in_suspect_pool` works as before, but now there are identifiers for the individual pipeline prospects groups. 

# discoveryengine 0.1.30
### bugfixes
* Updated the calculation of the `pool_id` that is used to identify suspect pools -- the original ID field was too short, which could result in distinct pools having the same ID. See issue #73. Also note that the next update will include new widgets to work with Pipeline Prospects, which are not handled well by the suspect pool widgets.

# discoveryengine 0.1.29
### new widgets
* `sec_filed` for pulling entities based on SEC form 3/4/5 filings. See `?sec_filed` for details.

### bugfixes
* certain widgets were not erroring when users entered an invalid argument (e.g. `contact_credit(1234, from = 20150101)`). Now they do, thanks to LC for noticing and reporting the issue

# discoveryengine 0.1.28
### new widgets
* `attended_hs` for finding students/alums based on the high school they attended (useful for parent prospecting). See issue #70, thanks to LR for the suggestion.

# discoveryengine 0.1.27
### new names for old functions
* `bot_brainstorm`, `bot_matrix`, and `bot_as_code` are new aliases for the corresponding bot functions. The old names will continue to work, the new aliases are easier to discover via autocomplete.

### implementation changes
* `display` now returns a data.frame, even when the `file` argument is not null (in which case a CSV is written to disk and then a data.frame is returned).
* `attended_event(..., include_nonattendees = TRUE)` will now include records with attendance code `RU` ("Registered - Attendance Unknown"). 

# discoveryengine 0.1.26
### features
* results from `brainstorm_bot` and `matrix_bot` can now be output as valid disco engine code, using `as_code`. For instance:

```
neuro_bb = brainstorm_bot("neuroscience")
as_code(neuro_bb)
```
(or just: `as_code(brainstorm_bot("neuroscience"))`)

you can then copy/paste the code and modify it if necessary before running it. 

### implementation changes
* `matrix_bot` results now include giving to candidate campaigns in California statewide elections. They do not currently include giving to ballot initative campaigns, because the default for `ca_gave_to_proposition` includes both supporters and opponents of a given proposition (see `?ca_gave_to_proposition` for info on using `support = TRUE` or `support = FALSE`). A future update may split out those two groups into separate widgets.

# discoveryengine 0.1.25
### new widgets
* `citizen_of` and `has_visa`. See #60. Thanks to VF for the request

### implementation changes
* `lives_in_foreign_country` and `works_in_foreign_country` now support an optional `city` argument to search for specific cities. For instance, `lives_in_foreign_country(KORER, city = "Seoul")`. See #63. Thanks to LR and VF for the suggestions. 
* code validation: All codes entered in widgets are now checked against code tables. If you enter a non-existent code (e.g.: `contact_purpose(VISIT)`), you'll now receive an error message. See #64. Thanks to LR for bringing up the issue.
* Defunct codes now appear in synonym search. Previously, they were excluded. Now they appear in a separate section of the search results, labeled "Defunct codes and synonyms," and the associated synonyms all begin with a period to make clear that they are defunct.
* `attended_event` now includes participation type `OL` (for "Online Participant"), based on announcement from AIM.

# discoveryengine 0.1.24
### new widgets
* `ca_gave`, `ca_gave_to_candidate`, `ca_gave_to_proposition` for searching through donors in California election campaigns

### bugfixes
* `lives_near` and `works_near` were having errors around caching of geocodes. Caching was determined to be unnecessary, the widgets are back to working as normal. Thanks to Anthony M. for the report. 

# discoveryengine 0.1.23
### bugfixes
* `gave_to_purpose` wasn't working, it's been fixed

# discoveryengine 0.1.22
### implementation changes
* all academic/degree widgets (e.g. `has_degree_from`, `majored_in`, `minored_in`, `has_degree`) now have options to specify `degreeholders`, `current_students`, or `attendees`

# discoveryengine 0.1.21
### new widgets
* `fund_purpose` and `gave_to_purpose`, see #56

### implementation changes
* `lives_near` and `works_near` now use [Nominatim](https://wiki.openstreetmap.org/wiki/Nominatim) for geocoding, RIP to Mapzen which was a wonderful service. See #58
* Improved error messages, including in the `matrix_bot`. See #59 and thanks to AM for identifying the problem.

# discoveryengine 0.1.20
### bugfixes
* `lives_near` and `works_near` were not working, now they are. See issue #62, thanks to VF for reporting the problem.

# discoveryengine 0.1.19
### new widgets
* `married_to` (relieves some cnfusion around householding, see discusson on #57)

## implementation changes
* Address-based widgets no longer require you to enter address type codes. Instead they have options such as `include_alternate`, `include_past`, `include_seasonal`, etc. which can be `TRUE` or `FALSE`. See the documentation for more explanation and examples.

# discoveryengine 0.1.18

### implementation changes
* all giving-related widgets now use householded, not individual, giving. 

# discoveryengine 0.1.17

### new widgets
* `contact_credit` (thanks to LC, see #48)
* `has_degree` (thanks to IZ, see #51)

### bugfixes or implmenetation changes
* fixed a bug in the way that various forms of allocation code definitions were being processed, which occasionally led to errors when using widgets such as `gave_to_fund`. Now you can specify the arguments to `gave_to_fund` using the output of other widgets (such as `fund_text_contains`), literal allocation codes (e.g. `gave_to_fund(FW373737)`), character vectors of allocation codes (copied and pasted from `discovcr` or imported from a file), or any combination of these
* fixed a bug whereby affiliations (and committees) with a status code other than Current (C) or Former (F) were being lost, thanks to LC for reporting. See #49

# discoveryengine 0.1.16

* added FEC widgets: `fec_gave_to_candidate`, `fec_gave_to_committee`, and `fec_gave_to_category`
* The matrix bot now also includes fec candidates and categories in its results

# discoveryengine 0.1.15

* added date-range option to `attended_event`, see #47 (thanks to ML).

# discoveryengine 0.1.14

### bugfixes and or implementation changes
* some `brainstorm_bot` results were not able to be translated to SQL, breaking the usual ability to use the results in larger expressions. That issue has been fixed. See issue #46. 
* some clearer documentation and help. see #44 and #45, thanks to AM and ML

# discoveryengine 0.1.13

### new widgets
* `has_philanthropic_interest` (#43, thanks to LC, AM, and ML)

### features
* the following widgets now have an optional `comment` argument enabling text 
search within the comment field (for example, `has_interest(health, comment = "cancer")`. #42, thanks to ML):
    - `attended_event`
    - `has_affiliation`
    - `has_interest`
    - `has_philanthropic_affinity`
    - `has_philanthropic_interest`
    - `on_committee`
    - `rated_by`
    - `received_award`

# discoveryengine 0.1.12
Showing all changes since version 0.1.8

### new widgets
* `lives_in_foreign_country` and `works_in_foreign_country` for international prospecting (# 35, thanks to BC) 
* `has_engineering_score` for the new engineering model (thanks to LC). 
* `fund_type` and `gave_to_fund_type` (see #37, thanks to AM/EK/LC)
* `minored_in` (see #38, thanks to AM)
* `age_between` (see #39, thanks to LC)
* `works_at` (see #40, thanks to BC)
* `corp_parent` and `corp_subsidiary`, (also related to #40)
* `contact_date` (thanks to ML)
* `contact_purpose`, `contact_outcome`, and `contact_type`: in all, we now have a full suite of contact report widgets: those three, plus `contact_date`, `contact_unit`, and `contact_text_contains`. And `contacted_entity_of` to get back to individual entities.

### features
* `display` method for `listbuilder::report`s. This allows PD to easily extend the disco engine with custom reporting, for example see `discoappend` (https://github.com/cwolfsonseeley/discoappend/).
* `matrix_bot` now looks at even more areas! Awards, occupation, industry, 
philanthropic affinities, and events were added to `matrix_bot`. This makes the bot slower, but more powerful. We'll continue to look for ways to speed it up.

### bugfixes and or implementation changes
* `household` now uses the `household_entity_id` rather than `hh_corp_entity_id` #34 (thanks to AM for noticing the problem)
* `matrix_bot` was not returning any results, thanks to DT for catching the error
* address-based widgets (like `lives_in_*` and `works_in_*`) changed their default behavior. For example, it used to be that `lives_in_msa` when used without any arguments would pull anyone with a home address, but now it will only pull anyone with a home address that has an MSA. 
* updated to keep pace with the new `dplyr` setup, specifically updated functions to rely on exports from `dbplyr` instead of `dplyr`. 
* Most higher-order widgets can now accept plain IDs as input (for example: `gave_to_fund(FW6644000))`. They still accept definitions, so all code written 
in earlier versions will continue to work, this just adds flexibility,

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
* Fixed bug in `works_in_industry` and `has_occupation` where defaults (ie using without arguments) caused `invalid relational operator` errors
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

