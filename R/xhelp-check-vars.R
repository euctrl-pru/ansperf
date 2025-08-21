#' @title Helper functions to check and validate user input
#'
#' @description A set of functions that checks and validate user inputs.
#'
#' @param data - input data frame / tibble
#' @param mapping - the detected mapping between defaults and user names
#' @param defaults - the expected default variable names for the calculation of the metric
#' @param user_args - the user defined argument names
#' @param types - the required types
#'
#' @name checkvars
NULL

#' @rdname checkvars
#'
#' @param defaults - the expected default variable names for the calculation of the metric
#' @param user_args - any non-standard user-specific naming conventions
#'
#' @export
# merge_var_mappings <- function(defaults, user_args = list()) {
#   for (arg_name in names(user_args)) {
#     if (!is.null(user_args[[arg_name]])) {
#       defaults[[arg_name]] <- user_args[[arg_name]]
#     }
#   }
#   defaults
# }

merge_var_mappings <- function(defaults, user_args = list()) {
  for (arg_name in names(user_args)) {
    if (!is.null(user_args[[arg_name]])) {
      # ensure we store the evaluated string, not quosure
      defaults[[arg_name]] <- rlang::as_name(user_args[[arg_name]])
    }
  }
  defaults
}


#' @rdname checkvars
#'
#' @param data - input data frame / tibble
#' @param mapping - the detected mapping between defaults and user names
#'
#' @export
# --- 2. Check required columns exist ---
check_required_columns <- function(data, mapping) {
  missing <- setdiff(unname(mapping), names(data))
  if (length(missing) > 0) {
    rlang::abort(
      message = paste("Missing required columns:", paste(missing, collapse = ", ")),
      class = "missing_columns_error"
    )
  }
  invisible(TRUE)
}

#' @rdname checkvars
#'
#' @param data - input data frame / tibble
#' @param mapping - the detected mapping between defaults and user names
#' @param types - the required types
#'
#' @export
# --- 3. Check column types ---
# check_column_types <- function(data, mapping, types) {
#   for (var in names(mapping)) {
#     colname <- mapping[[var]]
#     col <- data[[colname]]
#     expected <- types[[var]]
#
#     if (!is.null(expected) && !any(vapply(expected, inherits, logical(1), x = col))) {
#       rlang::abort(
#         message = sprintf(
#           "Column '%s' (mapped from '%s') must be of type %s (found %s)",
#           colname, var, paste(expected, collapse = " or "), class(col)[1]
#         ),
#         class = "column_type_error"
#       )
#     }
#   }
#   invisible(TRUE)
# }

check_column_types <- function(data, mapping, types) {
  for (var in names(mapping)) {
    colname <- mapping[[var]]
    col <- data[[colname]]
    expected <- types[[var]]

    if (!is.null(expected)) {
      ok <- any(vapply(expected, inherits, logical(1), x = col))
      if (!ok) {
        rlang::abort(
          message = sprintf(
            "Column '%s' (mapped from '%s') must be of type %s (found %s)",
            colname, var,
            paste(expected, collapse = " or "),
            class(col)[1]
          ),
          class = "column_type_error"
        )
      }
    }
  }
  invisible(TRUE)
}


#' @rdname checkvars
#'
#' @param data - input data frame / tibble
#' @param defaults - the expected default variable names for the calculation of the metric
#' @param user_args - the user defined argument names
#' @param types - the required types
#'
#' @export
# validate_input_vars <- function(data, defaults, user_args = list(), types = NULL) {
#   mapping <- merge_var_mappings(defaults, user_args)
#   check_required_columns(data, mapping)
#   if (!is.null(types)) {
#     check_column_types(data, mapping, types)
#   }
#   mapping
# }

validate_input_vars <- function(data, defaults, user_args = list(), types = NULL) {
  # 1. Merge defaults with user args
  mapping <- merge_var_mappings(defaults, user_args)

  # 2. Check existence
  missing <- setdiff(unname(mapping), names(data))
  if (length(missing) > 0) {
    rlang::abort(
      message = paste("Missing required columns:", paste(missing, collapse = ", ")),
      class = "column_missing_error"
    )
  }

  # 3. Check types if requested
  if (!is.null(types)) {
    check_column_types(data, mapping, types)
  }

  return(mapping)  # resolved mapping (semantic name → actual col name)
}

