CLASS zcl_leap DEFINITION PUBLIC.
  PUBLIC SECTION.
    METHODS leap
      IMPORTING
        year          TYPE i
      RETURNING
        VALUE(result) TYPE abap_bool.
ENDCLASS.

CLASS zcl_leap IMPLEMENTATION.

  METHOD leap.
    result = COND #( WHEN year MOD 100 = 0 THEN xsdbool( year MOD 400 = 0 )
                                           ELSE xsdbool( year MOD 4   = 0  ) ).
  ENDMETHOD.

ENDCLASS.
