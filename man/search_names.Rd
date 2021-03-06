\name{search_names}
\alias{search_names}
\title{Lookup of taxonomic names}
\usage{
search_names(taxa = c(), vernacular = FALSE, guids_only = FALSE,
  output_format = "simple")
}
\arguments{
  \item{taxa}{string: a single name or vector of names}

  \item{vernacular}{logical: if TRUE, match on common names
  as well as scientific names, otherwise match only on
  scientific names}

  \item{guids_only}{logical: if TRUE, a named list of GUIDs
  will be returned. Otherwise, a data frame with more
  comprehensive information for each name will be
  returned.}

  \item{output_format}{string: controls the print method
  for the returned object (only applicable when guids_only
  is FALSE). Either "complete" (the complete data structure
  is displayed), or "simple" (a simplified version is
  displayed). Note that the complete data structure exists
  in both cases: this option only controls what is
  displayed when the object is printed to the console. The
  default output format is "simple"}
}
\value{
A data frame of results, or named list of GUIDs if
\code{guids_only} is TRUE
}
\description{
Provides GUID, taxonomic classification, and other
information for a list of names. Case-insensitive but
otherwise exact matches are used.
}
\examples{
s1=search_names(c("Grevillea humilis","Grevillea humilis subsp. maritima","Macropus","Thisisnot aname"))
str(s1)
s2=search_names(c("Grevillea humilis","Grevillea humilis subsp. maritima","Macropus","Thisisnot aname"),guids_only=TRUE)
str(s2)
ss=search_names("Grevillea",vernacular=FALSE) ## should return the genus Grevillea
str(ss)
sv=search_names("Grevillea",vernacular=TRUE) ## should return the species Grevillea banksii, because it has the common name ``Grevillea"
str(sv) ## see the complete data structure
}
\author{
Atlas of Living Australia \email{support@ala.org.au}
}
\references{
\url{http://api.ala.org.au/}
}

