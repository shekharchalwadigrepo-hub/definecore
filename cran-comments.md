## Test environments
* Local Windows 11, R 4.4.1
* R CMD check --as-cran

## R CMD check results
There were no ERRORs or WARNINGs.

NOTES:
- checking CRAN incoming feasibility: New submission
- checking for future file timestamps: unable to verify current time
  (common on some Windows systems; not related to package content)

## Notes to CRAN
- Initial release.
- Package generates Define-XML 2.0/2.1 from metacore objects.
- Complements the spreadsheet-based defineR package.
- Examples use \donttest{} as requested in previous review.
- Output is a solid starting point; users should validate against the official CDISC schema before regulatory use.
