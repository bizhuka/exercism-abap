CLASS zcl_two_fer DEFINITION PUBLIC.
  PUBLIC SECTION.
    METHODS two_fer
      IMPORTING
        input         TYPE string OPTIONAL
      RETURNING
        VALUE(result) TYPE string.
ENDCLASS.

CLASS zcl_two_fer IMPLEMENTATION.

  METHOD two_fer.
    result = |One for { COND #( WHEN input IS NOT INITIAL THEN input ELSE 'you' ) }, one for me.|.
  ENDMETHOD.

ENDCLASS.
