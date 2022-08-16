CLASS zcl_clock DEFINITION
  PUBLIC
  CREATE PUBLIC.

  PUBLIC SECTION.

    METHODS constructor
      IMPORTING
        !hours   TYPE i
        !minutes TYPE i DEFAULT 0.

    METHODS get
      RETURNING
        VALUE(result) TYPE string.
    METHODS add
      IMPORTING
        !minutes TYPE i.
    METHODS sub
      IMPORTING
        !minutes TYPE i.

  PRIVATE SECTION.
    types: num2 TYPE n LENGTH 2.

    DATA mv_minutes TYPE i.
ENDCLASS.

CLASS zcl_clock IMPLEMENTATION.

  METHOD constructor.
    mv_minutes = hours * 60 + minutes.
  ENDMETHOD.

  METHOD add.
    mv_minutes = mv_minutes + minutes.
  ENDMETHOD.

  METHOD sub.
    mv_minutes = mv_minutes - minutes.
  ENDMETHOD.

  METHOD get.
    result = |{ conv num2( mv_minutes div 60 mod 24 ) }:{
                conv num2( mv_minutes        mod 60 ) }|.
  ENDMETHOD.
ENDCLASS.

