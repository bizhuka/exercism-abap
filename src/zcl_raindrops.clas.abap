class ZCL_RAINDROPS definition
  public
  create public .

public section.

  methods CONSTRUCTOR .
  methods RAINDROPS
    importing
      !INPUT type I
    returning
      value(RESULT) type STRING .
  PRIVATE SECTION.
    TYPES:
      BEGIN OF ts_drop,
        num TYPE i,
        txt TYPE string,
      END OF ts_drop,
      tt_drop TYPE STANDARD TABLE OF ts_drop WITH DEFAULT KEY.
    DATA:
            mt_drop TYPE tt_drop.
ENDCLASS.



CLASS ZCL_RAINDROPS IMPLEMENTATION.


  METHOD constructor.
    mt_drop = VALUE #( ( num = 3 txt = |Pling| ) ( num = 5 txt = |Plang| ) ( num = 7 txt = |Plong| ) ).
  ENDMETHOD.


  METHOD raindrops.
    LOOP AT mt_drop ASSIGNING FIELD-SYMBOL(<ls_drop>).
      CHECK input MOD <ls_drop>-num = 0.
      result = |{ result }{ <ls_drop>-txt }|.
    ENDLOOP.

    IF result IS INITIAL.
      result = input.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
