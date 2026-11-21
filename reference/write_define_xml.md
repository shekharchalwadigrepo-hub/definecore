# Write Define-XML from a metacore object

Generates a CDISC Define-XML (version 2.0 or 2.1) document from a
`metacore` metadata object. The output is an ODM-based XML file
containing dataset (ItemGroupDef), variable (ItemDef), codelist, and
derivation (MethodDef) metadata suitable as a starting point for
regulatory submissions.

## Usage

``` r
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
```

## Arguments

- meta:

  A `metacore` object (R6 class).

- file:

  Character string. Path to the output `define.xml` file.

- define_version:

  Character. `"2.0"` or `"2.1"`. Default `"2.1"`.

- study_oid:

  Character. ODM Study OID. Default generated.

- study_name:

  Character. Study name for GlobalVariables.

- study_description:

  Character. Study description.

- protocol_name:

  Character. Protocol name. Defaults to `study_name`.

- standard_name:

  Character. Name of the content standard (e.g., `"SDTM-IG"`,
  `"ADaM-IG"`). Used for Define-XML 2.1 `def:Standard`.

- standard_version:

  Character. Version of the content standard.

- file_oid:

  Character. ODM FileOID. Default generated.

- origin_default:

  Character. Default origin if missing (e.g., `"Derived"`).

- quiet:

  Logical. Suppress messages. Default `FALSE`.

## Value

Invisibly returns the path to the written file.

## Examples

``` r
# \donttest{
library(metacore)
#> Attaching package `metacore`
#> 
#> As of metacore 0.3.0 the `keep` variable in the `ds_vars` table has been renamed to `mandatory`. Please see release documentation for details.
load(metacore_example("pilot_ADaM.rda"))  # loads object named 'metacore'
tmp <- tempfile(fileext = ".xml")
write_define_xml(metacore, tmp, study_name = "CDISCPILOT01")
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> Warning: Unknown or uninitialised column: `mandatory`.
#> ✔ Define-XML 2.1 written to /tmp/RtmpBcLQXT/file1b0e25b3fb08.xml
#> ! This is a core generation. Review OIDs, value-level metadata, documents, and validate against CDISC schema before submission.
unlink(tmp)
# }
```
