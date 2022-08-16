class ZCL_PHONE_NUMBER definition
  public
  final
  create public .

public section.

  methods CLEAN
    importing
      !NUMBER type STRING
    returning
      value(RESULT) type STRING
    raising
      CX_PARAMETER_INVALID .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_PHONE_NUMBER IMPLEMENTATION.


  METHOD clean.
    result = replace( val   = number
                      regex = |[^0-9]|
                      with  = ``
                      occ   = 0 ).
    IF strlen( result ) = 11 AND result+0(1) = '1'.
      result = result+1.
    ENDIF.

    IF strlen( result ) <> 10.
        RAISE EXCEPTION TYPE cx_parameter_invalid.
    ENDIF.

    IF result+0(1) <= '1' OR result+3(1) <= '1'.
        RAISE EXCEPTION TYPE cx_parameter_invalid.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
