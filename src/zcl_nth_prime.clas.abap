CLASS zcl_nth_prime DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS prime
      IMPORTING
        !input        TYPE i
      RETURNING
        VALUE(result) TYPE i
      RAISING
        cx_parameter_invalid .
  PROTECTED SECTION.
  PRIVATE SECTION.

    METHODS is_prime
      IMPORTING
        !iv_number   TYPE i
      RETURNING
        VALUE(rv_ok) TYPE abap_bool .
ENDCLASS.



CLASS zcl_nth_prime IMPLEMENTATION.


  METHOD is_prime.
    DO ( iv_number DIV 2 ) - 1 TIMES.
      DATA(lv_div) = sy-index + 1.
      IF iv_number MOD lv_div = 0.
        RETURN.
      ENDIF.
    ENDDO.

    rv_ok = abap_true.
  ENDMETHOD.


  METHOD prime.
    IF input <= 0.
      RAISE EXCEPTION TYPE cx_parameter_invalid.
    ENDIF.

    DATA lt_prime TYPE SORTED TABLE OF i WITH UNIQUE KEY table_line.
    DATA(lv_number) = 1.
    WHILE input > lines( lt_prime ).
      lv_number = lv_number + 1.

      CHECK is_prime( lv_number ) = abap_true.
      INSERT lv_number INTO TABLE lt_prime.
    ENDWHILE.

    ASSIGN lt_prime[ input ] TO FIELD-SYMBOL(<lv_prime>).
    CHECK sy-subrc = 0.
    result = <lv_prime>.
  ENDMETHOD.
ENDCLASS.
