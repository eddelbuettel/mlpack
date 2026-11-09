# ConfigureDuckDBHPP.cmake: generate an mlpack .hpp file for a DuckDB binding
# given input arguments.
#
# This file depends on the following variables being set:
#
#  * PROGRAM_NAME: name of the binding
#  * PROGRAM_MAIN_FILE: the file containing the mlpackMain() function.
#  * DUCKDB_HPP_IN: path of the mlpack_method.hpp.in file.
#  * DUCKDB_HPP_OUT: name of the output .hpp file.
#

# Compute an UpperCamelCase version of PROGRAM_NAME (e.g. random_forest_train
# -> RandomForestTrain) so the generated function name matches the convention
# used by duckdb-mlpack (Mlpack...TableFunction).
set(PROGRAM_NAME_CAMEL "")
string(REPLACE "_" ";" _name_parts "${PROGRAM_NAME}")
foreach(_part ${_name_parts})
  if(_part STREQUAL "")
    continue()
  endif()
  string(SUBSTRING "${_part}" 0 1 _first)
  string(TOUPPER "${_first}" _first_upper)
  string(LENGTH "${_part}" _len)
  if(_len GREATER 1)
    string(SUBSTRING "${_part}" 1 -1 _rest)
  else()
    set(_rest "")
  endif()
  string(APPEND PROGRAM_NAME_CAMEL "${_first_upper}${_rest}")
endforeach()

configure_file("${DUCKDB_HPP_IN}" "${DUCKDB_HPP_OUT}")
