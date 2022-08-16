class ZCL_ISOGRAM definition
  public
  create public .

public section.

  methods IS_ISOGRAM
    importing
      value(PHRASE) type STRING
    returning
      value(RESULT) type ABAP_BOOL .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_ISOGRAM IMPLEMENTATION.


  METHOD is_isogram.
    DATA(lv_char_only) = replace( val   = phrase
                                  regex = |[^A-Za-z]|
                                  with  = `` ).
    lv_char_only = to_lower( lv_char_only ).

    TYPES char1 TYPE c LENGTH 1.
    DATA lt_unq TYPE SORTED TABLE OF char1 WITH UNIQUE KEY table_line.

    DO strlen( lv_char_only ) TIMES.
      DATA(lv_index) = sy-index - 1.
      DATA(lv_char)  = CONV char1( lv_char_only+lv_index(1) ).

      INSERT lv_char INTO TABLE lt_unq.
      IF sy-subrc <> 0.
        RETURN.
      ENDIF.
    ENDDO.

    result = abap_true.
  ENDMETHOD.
ENDCLASS.
