CLASS zmg_cl_aoc_2025_day_02 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES zmg_if_aoc_2025_day.

    TYPES ty_i_tab TYPE STANDARD TABLE OF int8 WITH EMPTY KEY.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zmg_cl_aoc_2025_day_02 IMPLEMENTATION.
  METHOD zmg_if_aoc_2025_day~solve_part1.
    DATA(lv_sum) = VALUE int8( ).
    LOOP AT it_input ASSIGNING FIELD-SYMBOL(<fs>).
      SPLIT <fs> AT ',' INTO TABLE DATA(it_ranges).
      LOOP AT it_ranges ASSIGNING FIELD-SYMBOL(<fs_range>).
        SPLIT <fs_range> AT '-' INTO TABLE DATA(lt_limits).
        DATA(lv_lowerbound) = CONV int8( lt_limits[ 1 ] ).
        DATA(lv_upperbound) = CONV int8( lt_limits[ 2 ] ).

        DATA(lt_numbers) = VALUE ty_i_tab( FOR i = lv_lowerbound THEN i + 1 UNTIL i > lv_upperbound
                                           ( i ) ).
        LOOP AT lt_numbers ASSIGNING FIELD-SYMBOL(<fs_number>).
          DATA(lv_stringnum) = CONV string( <fs_number> ).
          CONDENSE lv_stringnum NO-GAPS.
          DATA(lv_stringlen) = strlen( lv_stringnum ).
          IF lv_stringlen MOD 2 = 0.
            DATA(lv_part1) = substring( val = lv_stringnum
                                        len = lv_stringlen / 2 ).
            DATA(lv_part2) = substring( val = lv_stringnum
                                        off = lv_stringlen / 2 ).
            IF lv_part1 = lv_part2.
              lv_sum += <fs_number>.
            ENDIF.
          ENDIF.
        ENDLOOP.
      ENDLOOP.
    ENDLOOP.
    rv_solution = lv_sum.
  ENDMETHOD.

  METHOD zmg_if_aoc_2025_day~solve_part2.
    DATA(lv_sum) = VALUE int8( ).
    LOOP AT it_input ASSIGNING FIELD-SYMBOL(<fs>).
      SPLIT <fs> AT ',' INTO TABLE DATA(it_ranges).
      LOOP AT it_ranges ASSIGNING FIELD-SYMBOL(<fs_range>).
        SPLIT <fs_range> AT '-' INTO TABLE DATA(lt_limits).
        DATA(lv_lowerbound) = CONV int8( lt_limits[ 1 ] ).
        DATA(lv_upperbound) = CONV int8( lt_limits[ 2 ] ).

        DATA(lt_numbers) = VALUE ty_i_tab( FOR i = lv_lowerbound THEN i + 1 UNTIL i > lv_upperbound
                                           ( i ) ).
        LOOP AT lt_numbers ASSIGNING FIELD-SYMBOL(<fs_number>).
          DATA(lv_stringnum) = CONV string( <fs_number> ).
          CONDENSE lv_stringnum NO-GAPS.

          DATA lv_invalid TYPE abap_bool.
          FIND REGEX '^([0-9]+)\1+$' IN lv_stringnum MATCH COUNT DATA(mc).
          lv_invalid = xsdbool( mc > 0 ).

          IF lv_invalid = abap_true.
            lv_sum += <fs_number>.
          ENDIF.

        ENDLOOP.
      ENDLOOP.
    ENDLOOP.
    rv_solution = lv_sum.
  ENDMETHOD.

ENDCLASS.