class ZCL_MATRIX definition
  public
  final
  create public .

public section.

  types:
    integertab TYPE STANDARD TABLE OF i WITH EMPTY KEY .

  methods MATRIX_ROW
    importing
      !STRING type STRING
      !INDEX type I
    returning
      value(RESULT) type INTEGERTAB .
  methods MATRIX_COLUMN
    importing
      !STRING type STRING
      !INDEX type I
    returning
      value(RESULT) type INTEGERTAB .
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.



CLASS ZCL_MATRIX IMPLEMENTATION.


  METHOD matrix_column.
    SPLIT string AT '\n' INTO TABLE DATA(lt_rows).

    LOOP AT lt_rows ASSIGNING FIELD-SYMBOL(<lv_row>).
      DATA(lt_row) = matrix_row( string = <lv_row>
                                 index  = 1 ).

      ASSIGN lt_row[ index ] TO FIELD-SYMBOL(<lv_val>).
      CHECK sy-subrc = 0.
      APPEND <lv_val> TO result.
    ENDLOOP.
  ENDMETHOD.


  METHOD matrix_row.
    SPLIT string AT '\n' INTO TABLE DATA(lt_rows).

    ASSIGN lt_rows[ index ] TO FIELD-SYMBOL(<lv_row>).
    CHECK sy-subrc = 0.

    SPLIT <lv_row> AT space INTO TABLE DATA(lt_row).
    result = VALUE #( FOR lv_val IN lt_row ( CONV #( lv_val ) ) ).
  ENDMETHOD.
ENDCLASS.
