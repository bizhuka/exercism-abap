class ZCL_PRIME_FACTORS definition
  public
  final
  create public .

public section.

  types:
    integertab TYPE STANDARD TABLE OF i WITH EMPTY KEY .

  methods FACTORS
    importing
      !INPUT type INT8
    returning
      value(RESULT) type INTEGERTAB .
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.



CLASS ZCL_PRIME_FACTORS IMPLEMENTATION.


  METHOD factors.
    CHECK input > 1.

    DATA(lv_input) = input.
    DATA(lv_div)   = 2.

    WHILE lv_input > 1.

      WHILE lv_input MOD lv_div = 0.
        lv_input = lv_input DIV lv_div.
        APPEND lv_div TO result.
      ENDWHILE.

      lv_div = lv_div + 1.
    ENDWHILE.
  ENDMETHOD.
ENDCLASS.
