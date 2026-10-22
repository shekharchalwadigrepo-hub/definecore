# definecore 0.1.1

* Fixed examples: replaced `\dontrun{}` with `\donttest{}` as requested by CRAN.
* Corrected example to use `load()` on the metacore `.rda` example file.
* Example now writes to a temporary file and cleans up afterward.

# definecore 0.1.0

* Initial release.
* Core function `write_define_xml()` to generate Define-XML 2.0/2.1 from metacore objects.
* Support for datasets, variables, codelists, and basic derivations.
* Designed for integration with pharmaverse metacore ecosystem.
