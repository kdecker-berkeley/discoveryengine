% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/widget-has-external-degree-from.R
\name{non-uc-academic}
\alias{non-uc-academic}
\alias{has_external_degree_from}
\title{Non-UC academic widgets}
\usage{
has_external_degree_from(
  ...,
  undergraduates = TRUE,
  graduates = TRUE,
  attendees = FALSE,
  current_students = FALSE,
  degreeholders = TRUE,
  from = NULL,
  to = NULL
)
}
\arguments{
\item{...}{Institutions}

\item{undergraduates}{TRUE/FALSE: should include undergraduates? Default is TRUE}

\item{graduates}{TRUE/FALSE: should include graduates? Default is TRUE}

\item{attendees}{TRUE/FALSE: should include attendees? Default is FALSE}

\item{current_students}{TRUE/FALSE: should include current students? Default is FALSE}

\item{degreeholders}{TRUE/FALSE: should include degreeholders? Default is TRUE}

\item{from}{(optional) date range: look only for those who graduated between
these dates. Enter as an integer of the form YYYYMMDD (see details)}

\item{to}{(optional) date range: look only for those who graduated between
these dates. Enter as an integer of the form YYYYMMDD (see details)

When using the daterange (\code{from} and/or \code{to}), the dates will be
based on the GRAD DATE for degreeholders and the STOP DATE for attendees
(who have no GRAD DATE). Both dates are visible in the Degrees screen in
Advance. An alum's "class year" is based on the GRAD DATE. For degreeholders,
the two dates are often the same, though they can differ. See examples below.
Date options are ignored when looking for current students}
}
\value{
A definition of type \code{entity_id}
}
\description{
Find entities who graduated from a particular institution. By default, attendees are not included, use \code{attendees = TRUE}
to include attendees.
}
\examples{
## graduated from University of Michigan Ann Arbor between 01/01/2001 and 12/31/2004
## since attendees are not included by default, this only pulls
## (undergrad and grad) degreeholders. Those with a GRAD DATE in the
## daterange will be included
has_external_degree_from(001839, from = 20010101, to = 20041231)

## just grad degree holders from University of Michigan Ann Arbor
has_external_degree_from(001839, undergraduates = FALSE)

}
\seealso{
\code{\link{academic}}
}
