## Test environments
* Local Windows 11, R 4.4.1
* R CMD check --as-cran

## R CMD check results
There were no ERRORs or WARNINGs.

One NOTE may appear:
- checking for future file timestamps: unable to verify current time
  (common on some Windows systems; not related to package content)

## Downstream dependencies
None.

## Notes to CRAN
- Initial release.
- Package generates Define-XML 2.0/2.1 from metacore objects.
- Complements the spreadsheet-based defineR package by integrating with the
  metacore metadata format used in the pharmaverse.
- Output is intended as a solid starting point; users should validate against
  the official CDISC schema and review value-level metadata before regulatory use.
