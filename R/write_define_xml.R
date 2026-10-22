#' Write Define-XML from a metacore object
#'
#' Generates a CDISC Define-XML (version 2.0 or 2.1) document from a
#' \code{metacore} metadata object. The output is an ODM-based XML file
#' containing dataset (ItemGroupDef), variable (ItemDef), codelist, and
#' derivation (MethodDef) metadata suitable as a starting point for
#' regulatory submissions.
#'
#' @param meta A \code{metacore} object (R6 class).
#' @param file Character string. Path to the output \code{define.xml} file.
#' @param define_version Character. \code{"2.0"} or \code{"2.1"}. Default \code{"2.1"}.
#' @param study_oid Character. ODM Study OID. Default generated.
#' @param study_name Character. Study name for GlobalVariables.
#' @param study_description Character. Study description.
#' @param protocol_name Character. Protocol name. Defaults to \code{study_name}.
#' @param standard_name Character. Name of the content standard (e.g., \code{"SDTM-IG"}, \code{"ADaM-IG"}).
#'   Used for Define-XML 2.1 \code{def:Standard}.
#' @param standard_version Character. Version of the content standard.
#' @param file_oid Character. ODM FileOID. Default generated.
#' @param origin_default Character. Default origin if missing (e.g., \code{"Derived"}).
#' @param quiet Logical. Suppress messages. Default \code{FALSE}.
#'
#' @return Invisibly returns the path to the written file.
#'
#' @export
#' @importFrom xml2 xml_new_root xml_add_child xml_set_attr xml_add_sibling write_xml
#' @importFrom dplyr filter arrange pull mutate
#' @importFrom rlang abort inform .data
#' @importFrom cli cli_alert_success cli_alert_warning
#' @importFrom glue glue
#' @importFrom magrittr %>%
#' @importFrom metacore is_metacore
#'
#' @examples
#' \donttest{
#' library(metacore)
#' meta <- load_metacore(metacore_example("pilot_ADaM.rda"))
#' tmp <- tempfile(fileext = ".xml")
#' write_define_xml(meta, tmp, study_name = "CDISCPILOT01")
#' unlink(tmp)
#' }
write_define_xml <- function(
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
) {
  define_version <- match.arg(define_version)
  
  if (!is_metacore(meta)) {
    abort("`meta` must be a metacore object.")
  }
  
  if (is.null(file_oid)) {
    file_oid <- glue("define_{format(Sys.time(), '%Y%m%d%H%M%S')}")
  }
  if (is.null(study_oid)) {
    study_oid <- glue("ST.{toupper(study_name)}")
  }
  
  # Extract tables
  ds_spec <- meta$ds_spec
  ds_vars <- meta$ds_vars
  var_spec <- meta$var_spec
  value_spec <- meta$value_spec
  codelist <- meta$codelist
  derivations <- meta$derivations
  
  if (nrow(ds_spec) == 0) {
    abort("metacore object contains no datasets.")
  }
  
  # Namespaces
  odm_ns <- "http://www.cdisc.org/ns/odm/v1.3"
  def_ns <- if (define_version == "2.1") {
    "http://www.cdisc.org/ns/def/v2.1"
  } else {
    "http://www.cdisc.org/ns/def/v2.0"
  }
  xlink_ns <- "http://www.w3.org/1999/xlink"
  
  # Create root ODM
  doc <- xml_new_root(
    "ODM",
    xmlns = odm_ns,
    `xmlns:def` = def_ns,
    `xmlns:xlink` = xlink_ns,
    FileOID = file_oid,
    FileType = "Snapshot",
    CreationDateTime = format(Sys.time(), "%Y-%m-%dT%H:%M:%S"),
    ODMVersion = "1.3.2",
    Originator = "definecore",
    SourceSystem = "definecore R package",
    SourceSystemVersion = as.character(utils::packageVersion("definecore"))
  )
  
  # Add def:Context for 2.1
  if (define_version == "2.1") {
    xml_set_attr(doc, "def:Context", "Submission")
  }
  
  # Study
  study <- xml_add_child(doc, "Study", OID = study_oid)
  
  # GlobalVariables
  gv <- xml_add_child(study, "GlobalVariables")
  xml_add_child(gv, "StudyName", study_name)
  xml_add_child(gv, "StudyDescription", study_description)
  xml_add_child(gv, "ProtocolName", protocol_name)
  
  # MetaDataVersion
  mdv_oid <- "MDV.1"
  mdv <- xml_add_child(
    study, "MetaDataVersion",
    OID = mdv_oid,
    Name = "Data Definitions",
    Description = "Define-XML generated from metacore"
  )
  
  # def:Standards for 2.1
  if (define_version == "2.1" && !is.null(standard_name)) {
    standards <- xml_add_child(mdv, "def:Standards")
    std <- xml_add_child(
      standards, "def:Standard",
      OID = glue("STD.1"),
      Name = standard_name,
      Type = "IG",
      Status = "Final"
    )
    if (!is.null(standard_version)) {
      xml_set_attr(std, "Version", standard_version)
    }
  }
  
  # Build MethodDefs from derivations
  method_oids <- character()
  if (nrow(derivations) > 0) {
    for (i in seq_len(nrow(derivations))) {
      der <- derivations[i, ]
      method_oid <- glue("MT.{der$derivation_id}")
      method_oids <- c(method_oids, method_oid)
      
      method <- xml_add_child(
        mdv, "MethodDef",
        OID = method_oid,
        Name = der$derivation_id,
        Type = "Computation"
      )
      desc <- xml_add_child(method, "Description")
      xml_add_child(desc, "TranslatedText", der$derivation, `xml:lang` = "en")
    }
  }
  
  # Build CodeLists
  codelist_oids <- character()
  if (nrow(codelist) > 0) {
    for (i in seq_len(nrow(codelist))) {
      cl <- codelist[i, ]
      cl_oid <- glue("CL.{cl$code_id}")
      codelist_oids <- c(codelist_oids, cl_oid)
      
      cl_node <- xml_add_child(
        mdv, "CodeList",
        OID = cl_oid,
        Name = cl$name %||% cl$code_id,
        DataType = map_type(cl$type)
      )
      
      # codes is typically a list-column or nested
      codes <- cl$codes
      if (is.list(codes) && length(codes) > 0) {
        code_df <- codes[[1]]
        if (is.data.frame(code_df) && nrow(code_df) > 0) {
          for (j in seq_len(nrow(code_df))) {
            item <- code_df[j, ]
            if ("code" %in% names(item) && "decode" %in% names(item)) {
              cli_item <- xml_add_child(
                cl_node, "CodeListItem",
                CodedValue = as.character(item$code)
              )
              dec <- xml_add_child(cli_item, "Decode")
              xml_add_child(dec, "TranslatedText", as.character(item$decode), `xml:lang` = "en")
            } else if ("code" %in% names(item)) {
              xml_add_child(cl_node, "EnumeratedItem", CodedValue = as.character(item$code))
            }
          }
        }
      }
    }
  }
  
  # ItemGroupDefs (datasets)
  for (i in seq_len(nrow(ds_spec))) {
    ds <- ds_spec[i, ]
    ig_oid <- glue("IG.{ds$dataset}")
    
    ig <- xml_add_child(
      mdv, "ItemGroupDef",
      OID = ig_oid,
      Name = ds$dataset,
      Repeating = "Yes",
      IsReferenceData = "No",
      SASDatasetName = ds$dataset,
      Purpose = if (grepl("AD", ds$dataset, ignore.case = TRUE)) "Analysis" else "Tabulation",
      Structure = ds$structure %||% "One record per subject"
    )
    
    # Description
    if (!is.na(ds$label) && nzchar(ds$label)) {
      desc <- xml_add_child(ig, "Description")
      xml_add_child(desc, "TranslatedText", ds$label, `xml:lang` = "en")
    }
    
    # ItemRefs from ds_vars
    vars <- ds_vars %>% filter(.data$dataset == ds$dataset) %>% arrange(.data$order)
    for (j in seq_len(nrow(vars))) {
      v <- vars[j, ]
      item_oid <- glue("IT.{ds$dataset}.{v$variable}")
      
      itemref <- xml_add_child(
        ig, "ItemRef",
        ItemOID = item_oid,
        OrderNumber = as.integer(v$order %||% j),
        Mandatory = if (isTRUE(v$mandatory) || isTRUE(v$keep)) "Yes" else "No"
      )
      
      if (!is.na(v$key_seq) && v$key_seq > 0) {
        xml_set_attr(itemref, "KeySequence", as.integer(v$key_seq))
      }
      
      # Link method if derivation exists
      vs <- value_spec %>% filter(.data$dataset == ds$dataset, .data$variable == v$variable)
      if (nrow(vs) > 0 && !is.na(vs$derivation_id[1]) && nzchar(vs$derivation_id[1])) {
        method_oid <- glue("MT.{vs$derivation_id[1]}")
        xml_set_attr(itemref, "MethodOID", method_oid)
      }
    }
    
    # def:Class for 2.1 if available (from core or custom)
    # Placeholder
  }
  
  # ItemDefs (create one per dataset-variable combination to avoid OID conflicts)
  # This produces potentially duplicated ItemDefs if same variable appears in multiple datasets
  # with differing attributes; refine as needed for your study.
  for (i in seq_len(nrow(ds_vars))) {
    vrow <- ds_vars[i, ]
    ds_name <- vrow$dataset
    var_name <- vrow$variable
    
    # Find var_spec
    vs_row <- var_spec %>% filter(.data$variable == var_name)
    if (nrow(vs_row) == 0) next
    vspec <- vs_row[1, ]
    
    item_oid <- glue("IT.{ds_name}.{var_name}")
    
    # Skip if already added (simple check via existing nodes would require more, but for small studies ok)
    # In practice, collect unique OIDs first.
    
    data_type <- map_type(vspec$type)
    length_attr <- if (!is.na(vspec$length) && vspec$length > 0) as.integer(vspec$length) else NULL
    
    item <- xml_add_child(
      mdv, "ItemDef",
      OID = item_oid,
      Name = var_name,
      DataType = data_type,
      SASFieldName = var_name
    )
    
    if (!is.null(length_attr)) {
      xml_set_attr(item, "Length", length_attr)
    }
    
    # Description / Label
    if (!is.na(vspec$label) && nzchar(vspec$label)) {
      desc <- xml_add_child(item, "Description")
      xml_add_child(desc, "TranslatedText", vspec$label, `xml:lang` = "en")
    }
    
    # Origin from value_spec
    vs <- value_spec %>% 
      filter(.data$dataset == ds_name, .data$variable == var_name)
    origin <- if (nrow(vs) > 0 && !is.na(vs$origin[1]) && nzchar(vs$origin[1])) {
      vs$origin[1]
    } else {
      origin_default
    }
    if (nzchar(origin)) {
      xml_add_child(item, "def:Origin", Type = map_origin(origin))
    }
    
    # CodeListRef
    if (nrow(vs) > 0 && !is.na(vs$code_id[1]) && nzchar(vs$code_id[1])) {
      cl_oid <- glue("CL.{vs$code_id[1]}")
      xml_add_child(item, "CodeListRef", CodeListOID = cl_oid)
    }
  }
  
  # Write the file
  write_xml(doc, file, options = c("format", "as_xml"))
  
  if (!quiet) {
    cli_alert_success("Define-XML {define_version} written to {.file {file}}")
    cli_alert_warning("This is a core generation. Review OIDs, value-level metadata, documents, and validate against CDISC schema before submission.")
  }
  
  invisible(file)
}

# Helper: map metacore type to ODM DataType
map_type <- function(type) {
  type <- tolower(as.character(type))
  switch(
    type,
    "text" = "text",
    "character" = "text",
    "integer" = "integer",
    "float" = "float",
    "double" = "float",
    "numeric" = "float",
    "date" = "date",
    "datetime" = "datetime",
    "time" = "time",
    "boolean" = "boolean",
    "text"  # default
  )
}

# Helper: map origin text to def:Origin Type
map_origin <- function(origin) {
  origin <- tolower(as.character(origin))
  if (grepl("crf|collected|assigned", origin)) "Collected"
  else if (grepl("derived|computation|calculated", origin)) "Derived"
  else if (grepl("predecessor|assigned", origin)) "Predecessor"
  else if (grepl("protocol", origin)) "Protocol"
  else "Derived"
}

#' @keywords internal
`%||%` <- function(x, y) if (is.null(x) || length(x) == 0 || all(is.na(x))) y else x
