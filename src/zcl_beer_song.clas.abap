class ZCL_BEER_SONG definition
  public
  final
  create public .

public section.

  methods RECITE
    importing
      !INITIAL_BOTTLES_COUNT type I
      !TAKE_DOWN_COUNT type I
    returning
      value(RESULT) type STRING_TABLE .
  PROTECTED SECTION.
  PRIVATE SECTION.
    METHODS _get_bottle_text
      IMPORTING
        iv_bottles_count TYPE i
        iv_upper         TYPE abap_bool OPTIONAL
      RETURNING
        VALUE(rv_result) TYPE string.
    METHODS _second_verse
      IMPORTING
        iv_bottles_count TYPE any
      RETURNING
        value(rv_result)    TYPE string.
ENDCLASS.



CLASS ZCL_BEER_SONG IMPLEMENTATION.


  METHOD recite.
    DO take_down_count TIMES.
      DATA(lv_bottles_count) = initial_bottles_count - sy-index + 1.
      IF sy-index > 1.
        APPEND || TO result.
      ENDIF.

      APPEND |{ _get_bottle_text( iv_bottles_count = lv_bottles_count
                                  iv_upper         = abap_true ) } of beer on the wall, {
                _get_bottle_text( lv_bottles_count ) } of beer.|  TO result.
      APPEND |{ _second_verse( lv_bottles_count ) }, {
                _get_bottle_text( lv_bottles_count - 1 ) } of beer on the wall.|  TO result.
    ENDDO.
  ENDMETHOD.


  METHOD _get_bottle_text.

    DATA(lv_bottles_count) = iv_bottles_count mod 100.
    rv_result =
     COND #( WHEN lv_bottles_count = 0 THEN |{ COND #( WHEN iv_upper = abap_true THEN |No| ELSE |no| ) } more bottles|
             WHEN lv_bottles_count = 1 THEN |{ 1 } bottle|
                                       ELSE |{ lv_bottles_count } bottles| ).
  ENDMETHOD.


  METHOD _second_verse.
    rv_result = COND #( WHEN iv_bottles_count = 0
                        THEN |Go to the store and buy some more|
                        ELSE |Take { COND #( WHEN iv_bottles_count = 1 THEN |it| ELSE |one| ) } down and pass it around| ).
  ENDMETHOD.
ENDCLASS.
