\name{write_define_xml}
\alias{write_define_xml}
\title{Write Define-XML from a metacore object}
\usage{
write_define_xml(
  meta,
  file,
  define_version = c("2.1", "2.0"),
  study_oid = NULL,
  study_name = "STUDY",
  study_description = "Study Description",
  protocol_name = study_name,
  standard_name = NULL,
  standard_version = NULL,
  file_oid = NULL,
  origin_default = "Derived",
  quiet = FALSE
)
}
\arguments{
\item{meta}{A \code{metacore} object (R6 class).}

\item{file}{Character string. Path to the output \code{define.xml} file.}

\item{define_version}{Character. \code{"2.0"} or \code{"2.1"}. Default \code{"2.1"}.}

\item{study_oid}{Character. ODM Study OID. Default generated.}

\item{study_name}{Character. Study name for GlobalVariables.}

\item{study_description}{Character. Study description.}

\item{protocol_name}{Character. Protocol name. Defaults to \code{study_name}.}

\item{standard_name}{Character. Name of the content standard (e.g., \code{"SDTM-IG"}, \code{"ADaM-IG"}).
Used for Define-XML 2.1 \code{def:Standard}.}

\item{standard_version}{Character. Version of the content standard.}

\item{file_oid}{Character. ODM FileOID. Default generated.}

\item{origin_default}{Character. Default origin if missing (e.g., \code{"Derived"}).}

\item{quiet}{Logical. Suppress messages. Default \code{FALSE}.}
}
\value{
Invisibly returns the path to the written file.
}
\description{
Generates a CDISC Define-XML (version 2.0 or 2.1) document from a
\code{metacore} metadata object. The output is an ODM-based XML file
containing dataset (ItemGroupDef), variable (ItemDef), codelist, and
derivation (MethodDef) metadata suitable as a starting point for
regulatory submissions.
}
\examples{
\donttest{
library(metacore)
meta <- load_metacore(metacore_example("pilot_ADaM.rda"))
tmp <- tempfile(fileext = ".xml")
write_define_xml(meta, tmp, study_name = "CDISCPILOT01")
unlink(tmp)
}
}
