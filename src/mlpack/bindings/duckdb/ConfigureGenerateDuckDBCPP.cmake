# ConfigureDuckDBCPP.cmake: generate an mlpack .cpp generator for a DuckDB binding
# given input arguments.
#
# This file depends on the following variables being set:
#
#  * PROGRAM_NAME: name of the binding
#  * PROGRAM_MAIN_FILE: the file containing the mlpackMain() function.
#  * DUCKDB_CPP_IN: path of the generate_duckdb.cpp.in file.
#  * DUCKDB_CPP_OUT: name of the output .cpp file.
#

# Compute an UpperCamelCase version of PROGRAM_NAME (e.g. random_forest_train
# -> RandomForestTrain) so it can be passed on to PrintDuckDB() and used to
# form the table-function name.
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

configure_file("${DUCKDB_CPP_IN}" "${DUCKDB_CPP_OUT}")