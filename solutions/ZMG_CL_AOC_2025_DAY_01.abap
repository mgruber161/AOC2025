CLASS zmg_cl_aoc_2025_day_01 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES:
      zmg_if_aoc_2025_day.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zmg_cl_aoc_2025_day_01 IMPLEMENTATION.
  METHOD zmg_if_aoc_2025_day~solve_part1.
    DATA(lv_counter) = 0.
    DATA(lv_dial_position) = 50.
    LOOP AT it_input ASSIGNING FIELD-SYMBOL(<fs>).
      DATA(lv_direction) = substring( val = <fs>
                                      len = 1 ).
      DATA(lv_rotation) = CONV i( substring( val = <fs>
                                             off = 1 ) ).

      DO lv_rotation TIMES.
        IF lv_direction = 'R'.
          IF lv_dial_position = 99.
            lv_dial_position = 0.
          ELSE.
            lv_dial_position += 1.
          ENDIF.
        ELSEIF lv_direction = 'L'.
          IF lv_dial_position = 0.
            lv_dial_position = 99.
          ELSE.
            lv_dial_position -= 1.
          ENDIF.
        ENDIF.

      ENDDO.

      IF lv_dial_position = 0.
        lv_counter += 1.
      ENDIF.
    ENDLOOP.
    rv_solution = lv_counter.
  ENDMETHOD.

  METHOD zmg_if_aoc_2025_day~solve_part2.
    DATA(lv_counter) = 0.
    DATA(lv_dial_position) = 50.
    LOOP AT it_input ASSIGNING FIELD-SYMBOL(<fs>).
      DATA(lv_direction) = substring( val = <fs>
                                      len = 1 ).
      DATA(lv_rotation) = CONV i( substring( val = <fs>
                                             off = 1 ) ).

      DO lv_rotation TIMES.
        IF lv_direction = 'R'.
          IF lv_dial_position = 99.
            lv_dial_position = 0.
          ELSE.
            lv_dial_position += 1.
          ENDIF.
        ELSEIF lv_direction = 'L'.
          IF lv_dial_position = 0.
            lv_dial_position = 99.
          ELSE.
            lv_dial_position -= 1.
          ENDIF.
        ENDIF.
        IF lv_dial_position = 0.
          lv_counter += 1.
        ENDIF.
      ENDDO.

    ENDLOOP.
    rv_solution = lv_counter.
  ENDMETHOD.

ENDCLASS.