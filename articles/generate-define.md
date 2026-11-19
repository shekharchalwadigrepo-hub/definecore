# Generating Define-XML from metacore

``` r

library(definecore)
library(metacore)
#> Attaching package `metacore`
#> 
#> As of metacore 0.3.0 the `keep` variable in the `ds_vars` table has been renamed to `mandatory`. Please see release documentation for details.
```

## Introduction

The `definecore` package provides a direct path from a `metacore` object
to a CDISC Define-XML document. This complements the existing `defineR`
package (spreadsheet-driven) by leveraging the standardized metacore
structure used across the pharmaverse.

## Example

``` r

load(metacore_example("pilot_ADaM.rda"))  # loads object named 'metacore'

write_define_xml(
  metacore,
  file = "define.xml",
  define_version = "2.1",
  study_name = "CDISCPILOT01",
  study_description = "CDISC Pilot Study",
  standard_name = "ADaM-IG",
  standard_version = "1.1"
)
```

## Next Steps

Review the generated XML, add any missing value-level metadata
(WhereClauses), document leaves, and validate against the official CDISC
Define-XML schema before use in a regulatory submission.
