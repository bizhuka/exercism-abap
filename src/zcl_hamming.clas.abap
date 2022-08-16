CLASS zcl_hamming DEFINITION PUBLIC.
  PUBLIC SECTION.
    METHODS hamming_distance
      IMPORTING
        first_strand  TYPE string
        second_strand TYPE string
      RETURNING
        VALUE(result) TYPE i
      RAISING
        cx_parameter_invalid.
ENDCLASS.

CLASS zcl_hamming IMPLEMENTATION.

  METHOD hamming_distance.
    DATA(lv_first_count) = strlen( first_strand ).
    IF lv_first_count <> strlen( second_strand ).
      RAISE EXCEPTION TYPE cx_parameter_invalid.
    ENDIF.

    DO lv_first_count TIMES.
      DATA(lv_index) = sy-index - 1.

      DATA(l_char1) = first_strand+lv_index(1).
      DATA(l_char2) = second_strand+lv_index(1).

      CHECK l_char1 <> l_char2.
      result = result + 1.
    ENDDO.
  ENDMETHOD.

ENDCLASS.
