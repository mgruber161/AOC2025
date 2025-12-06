INTERFACE zmg_if_aoc_2025_day
  PUBLIC.
  METHODS solve_part1 IMPORTING it_input           TYPE string_table
                      RETURNING VALUE(rv_solution) TYPE string.

  METHODS solve_part2 IMPORTING it_input           TYPE string_table
                      RETURNING VALUE(rv_solution) TYPE string.
ENDINTERFACE.