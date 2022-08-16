class ZCL_DARTS definition
  public
  final
  create public .

public section.

  methods SCORE
    importing
      !X type F
      !Y type F
    returning
      value(RESULT) type I .
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.



CLASS ZCL_DARTS IMPLEMENTATION.


  METHOD score.
    DATA(lv_dist) = sqrt( x ** 2 + y ** 2 ).
    result = COND #( WHEN lv_dist <= 1  THEN 10
                     WHEN lv_dist <= 5  THEN 5
                     WHEN lv_dist <= 10 THEN 1
                     ELSE 0 ).
  ENDMETHOD.
ENDCLASS.
