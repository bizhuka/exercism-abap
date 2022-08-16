class ZCL_GRAINS definition
  public
  final
  create public .

public section.

  types:
    type_result TYPE p LENGTH 16 DECIMALS 0 .

  methods SQUARE
    importing
      !INPUT type I
      !IV_CHECK type ABAP_BOOL default ABAP_TRUE
    returning
      value(RESULT) type TYPE_RESULT
    raising
      CX_PARAMETER_INVALID .
  methods TOTAL
    returning
      value(RESULT) type TYPE_RESULT
    raising
      CX_PARAMETER_INVALID .
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.



CLASS ZCL_GRAINS IMPLEMENTATION.


  METHOD square.
    IF iv_check = abap_true AND NOT input BETWEEN 1 AND 64.
      RAISE EXCEPTION TYPE cx_parameter_invalid.
    ENDIF.

    result = CONV decfloat34(  2 ** ( input - 1 ) ).
  ENDMETHOD.


  METHOD total.
    result = square( input    = 65
                     iv_check = abap_false ) - 1.
  ENDMETHOD.
ENDCLASS.
