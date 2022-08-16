class ZCL_ANAGRAM definition
  public
  final
  create public .

public section.

  methods ANAGRAM
    importing
      !INPUT type STRING
      !CANDIDATES type STRING_TABLE
    returning
      value(RESULT) type STRING_TABLE .
  PROTECTED SECTION.
  PRIVATE SECTION.
    METHODS:
      _get_sorted IMPORTING iv_text        TYPE string
                  RETURNING VALUE(rv_text) TYPE string.
ENDCLASS.



CLASS ZCL_ANAGRAM IMPLEMENTATION.


  METHOD anagram.
    DATA(lv_input_l) = to_lower( input ).
    LOOP AT candidates INTO DATA(lv_candidate).
      DATA(lv_candidate_l) = to_lower( lv_candidate ).

      CHECK lv_candidate_l <> lv_input_l
        AND strlen( lv_candidate_l ) = strlen( lv_input_l ).

      CHECK lv_input_l     CO lv_candidate_l
        AND lv_candidate_l CO lv_input_l.

      CHECK _get_sorted( lv_input_l ) = _get_sorted( lv_candidate_l ).

      APPEND lv_candidate TO result.
    ENDLOOP.
  ENDMETHOD.


  METHOD _get_sorted.
    TYPES: char1    TYPE c LENGTH 1,
           tt_char1 TYPE STANDARD TABLE OF char1 WITH DEFAULT KEY.

    DATA(lt_letter) = VALUE tt_char1( ).
    DO strlen( iv_text ) TIMES.
      DATA(lv_index) = sy-index - 1.
      APPEND iv_text+lv_index(1) TO lt_letter.
    ENDDO.

    SORT lt_letter.
    rv_text = concat_lines_of( table = lt_letter ).
  ENDMETHOD.
ENDCLASS.
