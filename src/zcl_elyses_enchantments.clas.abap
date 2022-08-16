class ZCL_ELYSES_ENCHANTMENTS definition
  public
  final
  create public .

public section.

  types:
    ty_stack TYPE STANDARD TABLE OF i WITH EMPTY KEY .

    "! Get card at position
  methods GET_ITEM
    importing
      !STACK type TY_STACK
      !POSITION type I
    returning
      value(RESULT) type I .
    "! Replace card at position
  methods SET_ITEM
    importing
      !STACK type TY_STACK
      !POSITION type I
      !REPLACEMENT type I
    returning
      value(RESULT) type TY_STACK .
    "Add card to stack
  methods INSERT_ITEM_AT_TOP
    importing
      !STACK type TY_STACK
      !NEW_CARD type I
    returning
      value(RESULT) type TY_STACK .
    "! Remove card at position
  methods REMOVE_ITEM
    importing
      !STACK type TY_STACK
      !POSITION type I
    returning
      value(RESULT) type TY_STACK .
    "! Remove top card (last row)
  methods REMOVE_ITEM_FROM_TOP
    importing
      !STACK type TY_STACK
    returning
      value(RESULT) type TY_STACK .
    "! Add card to bottom of stack (first row)
  methods INSERT_ITEM_AT_BOTTOM
    importing
      !STACK type TY_STACK
      !NEW_CARD type I
    returning
      value(RESULT) type TY_STACK .
    "! Remove bottom card (delete first row)
  methods REMOVE_ITEM_FROM_BOTTOM
    importing
      !STACK type TY_STACK
    returning
      value(RESULT) type TY_STACK .
    "! Count cards
  methods GET_SIZE_OF_STACK
    importing
      !STACK type TY_STACK
    returning
      value(RESULT) type I .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_ELYSES_ENCHANTMENTS IMPLEMENTATION.


  METHOD get_item.
    READ TABLE stack INDEX position INTO result.
  ENDMETHOD.


  METHOD get_size_of_stack.
    result = lines( stack ).
  ENDMETHOD.


  METHOD insert_item_at_bottom.
    result[] = stack[].
    INSERT new_card INTO result INDEX 1.
  ENDMETHOD.


  METHOD insert_item_at_top.
    result[] = stack[].
    INSERT new_card INTO TABLE result.
  ENDMETHOD.


  METHOD remove_item.
    result[] = stack[].
    DELETE result INDEX position.
  ENDMETHOD.


  METHOD remove_item_from_bottom.
    result[] = stack[].
    DELETE result INDEX 1.
  ENDMETHOD.


  METHOD remove_item_from_top.
    result[] = stack[].
    DELETE result INDEX lines( result ).
  ENDMETHOD.


  METHOD set_item.
    result[] = stack[].
    READ TABLE result INDEX position ASSIGNING FIELD-SYMBOL(<ls_value>).
    CHECK sy-subrc = 0.

    <ls_value> = replacement.
  ENDMETHOD.
ENDCLASS.
