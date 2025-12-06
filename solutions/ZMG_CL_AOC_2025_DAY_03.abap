CLASS zmg_cl_aoc_2025_day_03 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES zmg_if_aoc_2025_day.

    TYPES ty_c_tab TYPE STANDARD TABLE OF c1 WITH EMPTY KEY.
    TYPES ty_i_tab TYPE STANDARD TABLE OF i WITH EMPTY KEY.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zmg_cl_aoc_2025_day_03 IMPLEMENTATION.
  METHOD zmg_if_aoc_2025_day~solve_part1.
    DATA(lv_joltsum) = 0.
    LOOP AT it_input INTO DATA(lv_str).
      CONDENSE lv_str NO-GAPS.
      DATA(lt_numbers) = VALUE ty_c_tab( ( '9' ) ( '8' ) ( '7' ) ( '6' ) ( '5' ) ( '4' ) ( '3' ) ( '2' ) ( '1' ) ).
      LOOP AT lt_numbers ASSIGNING FIELD-SYMBOL(<fs_number>).
        FIND ALL OCCURRENCES OF <fs_number> IN lv_str MATCH COUNT DATA(lv_matches) MATCH OFFSET DATA(lv_offset).
        IF lv_matches > 1.
          lv_joltsum += CONV i( |{ <fs_number> }{ <fs_number> }| ).
          EXIT.
        ELSEIF lv_matches = 1.
          IF lv_offset = strlen( lv_str ) - 1.
            DATA(lv_substr) = substring( val = lv_str
                                         len = lv_offset ).

            DATA(lt_chars) = VALUE ty_i_tab( FOR i = 0 WHILE i < strlen( lv_substr )
                                             ( CONV i( lv_substr+i(1) ) ) ).
            SELECT MAX( table_line ) FROM @lt_chars AS ch INTO @DATA(lv_maxnum).
            lv_joltsum += CONV i( |{ lv_maxnum }{ <fs_number> }| ).
            EXIT.
          ELSE.
            DATA(lv_substr1) = substring( val = lv_str
                                          off = lv_offset + 1 ).

            DATA(lt_chars1) = VALUE ty_i_tab( FOR i = 0 WHILE i < strlen( lv_substr1 )
                                              ( CONV i( lv_substr1+i(1) ) ) ).
            SELECT MAX( table_line ) FROM @lt_chars1 AS ch INTO @DATA(lv_maxnum1).
            lv_joltsum += CONV i( |{ <fs_number> }{ lv_maxnum1 }| ).
            EXIT.
          ENDIF.
          EXIT.
        ENDIF.
      ENDLOOP.
    ENDLOOP.
    rv_solution = lv_joltsum.
  ENDMETHOD.

  METHOD zmg_if_aoc_2025_day~solve_part2.
    DATA(lv_joltsum) = VALUE int8( ).
    LOOP AT it_input INTO DATA(lv_str).
      CONDENSE lv_str NO-GAPS.
      DATA(lv_len) = strlen( lv_str ).
      DATA(lv_to_remove) = lv_len - 12.
      DATA(lt_stack) = VALUE ty_c_tab( ).

      DO lv_len TIMES.
        DATA(lv_index) = sy-index - 1.
        DATA(lv_current) = lv_str+lv_index(1).
        WHILE lv_to_remove > 0 AND lines( lt_stack ) > 0.
          DATA(lv_top) = lt_stack[ lines( lt_stack ) ].
          IF lv_top < lv_current.
            WHILE lv_top < lv_current AND lv_to_remove > 0 AND lines( lt_stack ) > 0.
                DELETE lt_stack INDEX lines( lt_stack ).
                lv_to_remove -= 1.
                lv_top = COND #( when lines( lt_stack ) > 0 then lt_stack[ lines( lt_stack ) ]
                                 else 10 ).
            endWHILE.
          ELSE.
            EXIT.
          ENDIF.

        ENDWHILE.
        APPEND lv_current TO lt_stack.
      ENDDO.

      IF lv_to_remove > 0.
        DO lv_to_remove TIMES.
          DELETE lt_stack INDEX lines( lt_stack ).
        ENDDO.
      ENDIF.

      DATA(lv_result) = CONV int8( concat_lines_of( table = lt_stack ) ).
      lv_joltsum += lv_result.
    ENDLOOP.
    rv_solution = lv_joltsum.
  ENDMETHOD.


ENDCLASS.