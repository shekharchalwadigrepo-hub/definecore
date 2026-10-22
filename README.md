# definecore

Generate submission-ready CDISC Define-XML 2.0 / 2.1 documents from [metacore](https://cran.r-project.org/package=metacore) objects.

## Installation

```r
# Once on CRAN
install.packages("definecore")

# Development version
# remotes::install_github("shekharchalwadigrepo-hub/definecore")
```

## Usage

```r
library(definecore)
library(metacore)

# Load example metacore object
load(metacore_example("pilot_ADaM.rda"))  # loads object named 'metacore'

# Or from define.xml
# meta <- define_to_metacore("path/to/define.xml")

# Generate Define-XML 2.1
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

## Features

- Consumes metacore R6 objects (ds_spec, ds_vars, var_spec, value_spec, codelist, derivations)
- Generates ODM / Define-XML structure
- Supports Define-XML 2.0 and 2.1 (with def:Standards)
- Maps datasets to ItemGroupDef, variables to ItemDef + ItemRef
- Handles codelists, derivations (MethodDef), origins
- Designed for pharmaverse integration

## Limitations (v0.1.0)

This is an initial release focused on core metadata mapping. Full production use for regulatory submissions may require:

- Complete value-level metadata (WhereClauseDef, ValueListDef)
- Document leaves / Annotated CRF / Supplemental Docs
- Analysis Results Metadata (ARM)
- Full schema validation against CDISC XSDs
- Custom OID conventions
- HTML transformation (define.html)

Contributions welcome to expand coverage.

## Related Packages

- [metacore](https://cran.r-project.org/package=metacore): Metadata container
- [metatools](https://cran.r-project.org/package=metatools): Dataset building & checks
- [defineR](https://cran.r-project.org/package=defineR): Spreadsheet-driven Define-XML (experimental)

## License

MIT
