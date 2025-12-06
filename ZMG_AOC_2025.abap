*&---------------------------------------------------------------------*
*& Report zmg_aoc_2025
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmg_aoc_2025.


CLASS lcl_report DEFINITION.
  PUBLIC SECTION.
    METHODS open_file_dialog
      RETURNING VALUE(rv_filename) TYPE string.
    METHODS open_class_dialog.
    METHODS get_input_text
      IMPORTING
        iv_fname      TYPE string
      RETURNING
        value(r_result) TYPE STRING_TABLE.
ENDCLASS.

CLASS lcl_report IMPLEMENTATION.
  METHOD open_file_dialog.

    DATA: lv_rc     TYPE i,
          lt_files  TYPE filetable,
          lv_action TYPE i.

    TRY.
        cl_gui_frontend_services=>file_open_dialog( EXPORTING
                                                      file_filter    = |{ cl_gui_frontend_services=>filetype_text }|
                                                      multiselection = abap_false
                                                    CHANGING
                                                      file_table  = lt_files
                                                      rc          = lv_rc
                                                      user_action = lv_action ).

        IF lv_action = cl_gui_frontend_services=>action_ok.
          IF lines( lt_files ) > 0.
            rv_filename = lt_files[ 1 ]-filename.
          ENDIF.
        ENDIF.

      CATCH cx_root INTO DATA(lo_exc).
    ENDTRY.

  ENDMETHOD.

  METHOD open_class_dialog.
    DATA lv_class TYPE seoclsname.

    cl_reca_gui_class_f4=>get_class_impl_for_intf( EXPORTING id_interface = 'ZMG_IF_AOC_2025_DAY'
                                                   CHANGING  cd_classname = lv_class ).
  ENDMETHOD.

  METHOD get_input_text.
    DATA(lt_file) = VALUE string_table( ).
    CALL FUNCTION 'GUI_UPLOAD'
      EXPORTING  filename        = iv_fname
                 filetype        = 'ASC'
      TABLES     data_tab        = lt_file
      EXCEPTIONS file_open_error = 1
                 file_read_error = 2
                 OTHERS          = 3.
    r_result = lt_file.
  ENDMETHOD.

ENDCLASS.

INITIALIZATION.
  DATA(lo_report) = NEW lcl_report( ).
  TYPE-POOLS vrm.
  DATA name         TYPE vrm_id.
  DATA list         TYPE vrm_values.
  DATA value        LIKE LINE OF list.
  DATA gv_filename  TYPE string.
  DATA gt_dynfields TYPE TABLE OF dynpread.

  PARAMETERS: pa_fname TYPE string OBLIGATORY,
              pa_class TYPE seoclsname AS LISTBOX VISIBLE LENGTH 40 OBLIGATORY.

AT SELECTION-SCREEN ON VALUE-REQUEST FOR pa_fname.
  pa_fname = lo_report->open_file_dialog( ).

AT SELECTION-SCREEN ON VALUE-REQUEST FOR pa_class.
  lo_report->open_class_dialog(  ).

START-OF-SELECTION.
  WRITE / pa_fname.

  DATA(lt_input) = lo_report->get_input_text( pa_fname ).

  DATA lo_obj TYPE REF TO object.
  CREATE OBJECT lo_obj TYPE (pa_class).
  DATA(lo_ref) = CAST zmg_if_aoc_2025_day( lo_obj ).

  WRITE / 'Solution Part 1:'.
  WRITE / lo_ref->solve_part1( it_input = lt_input ).

  WRITE / 'Solution Part 2:'.
  WRITE / lo_ref->solve_part2( it_input = lt_input ).