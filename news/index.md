# Changelog

## definecore 0.1.1

CRAN release: 2026-11-04

- Fixed examples: replaced `\dontrun{}` with `\donttest{}` as requested
  by CRAN.
- Corrected example to use [`load()`](https://rdrr.io/r/base/load.html)
  on the metacore `.rda` example file.
- Example now writes to a temporary file and cleans up afterward.

## definecore 0.1.0

- Initial release.
- Core function
  [`write_define_xml()`](https://shekharchalwadigrepo-hub.github.io/definecore/reference/write_define_xml.md)
  to generate Define-XML 2.0/2.1 from metacore objects.
- Support for datasets, variables, codelists, and basic derivations.
- Designed for integration with pharmaverse metacore ecosystem.
