CLASS zcl_scrabble_score DEFINITION PUBLIC .

  PUBLIC SECTION.
    METHODS score
      IMPORTING
        input         TYPE string OPTIONAL
      RETURNING
        VALUE(result) TYPE i.
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.


CLASS zcl_scrabble_score IMPLEMENTATION.
  METHOD score.
    DO strlen( input ) TIMES.
      DATA(lv_index)  = sy-index - 1.
      DATA(lv_score) = SWITCH #( to_upper( input+lv_index(1) )
        WHEN 'A' OR 'E' OR 'I' OR 'O' OR 'U' OR 'L' OR 'N' OR 'R' OR 'S' OR 'T' THEN 1
        WHEN 'D' OR 'G'                                                         THEN 2
        WHEN 'B' OR 'C' OR 'M' OR 'P'                                           THEN 3
        WHEN 'F' OR 'H' OR 'V' OR 'W' OR 'Y'                                    THEN 4
        WHEN 'K'                                                                THEN 5
        WHEN 'J' OR 'X'                                                         THEN 8
        WHEN 'Q' OR 'Z'                                                         THEN 10 ).
      result = result + lv_score.
    ENDDO.
  ENDMETHOD.
ENDCLASS.
