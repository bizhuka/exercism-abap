CLASS zcl_high_scores DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES integertab TYPE STANDARD TABLE OF i WITH EMPTY KEY.
    METHODS constructor
      IMPORTING
        scores TYPE integertab.

    METHODS list_scores
      RETURNING
        VALUE(result) TYPE integertab.

    METHODS latest
      RETURNING
        VALUE(result) TYPE i.

    METHODS personalbest
      RETURNING
        VALUE(result) TYPE i.

    METHODS personaltopthree
      RETURNING
        VALUE(result) TYPE integertab.
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA scores_list TYPE integertab.

ENDCLASS.


CLASS zcl_high_scores IMPLEMENTATION.

  METHOD constructor.
    me->scores_list = scores.
  ENDMETHOD.

  METHOD list_scores.
    result = scores_list[].
  ENDMETHOD.

  METHOD latest.
    ASSIGN scores_list[ lines( scores_list ) ] TO FIELD-SYMBOL(<lv_last>).
    CHECK sy-subrc = 0.
    result = <lv_last>.
  ENDMETHOD.

  METHOD personalbest.
    result = REDUCE #( INIT r = 0
                       FOR <score> IN scores_list
                       NEXT r = COND #( WHEN r < <score> THEN <score> ELSE r ) ).
  ENDMETHOD.

  METHOD personaltopthree.
    result = scores_list[].
    SORT result BY table_line DESCENDING.
    DELETE result FROM 4.
  ENDMETHOD.


ENDCLASS.
