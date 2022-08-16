class ZCL_CUSTOM_SIGNS definition
  public
  final
  create public .

public section.

    "! Build a sign that includes both of the parameters.
  methods BUILD_SIGN
    importing
      !OCCASION type STRING
      !NAME type STRING
    returning
      value(RESULT) type STRING .
    "! Build a birthday sign that conditionally formats the return string.
  methods BUILD_BIRTHDAY_SIGN
    importing
      !AGE type I
    returning
      value(RESULT) type STRING .
    "! Build a graduation sign that includes multiple lines
  methods GRADUATION_FOR
    importing
      !NAME type STRING
      !YEAR type I
    returning
      value(RESULT) type STRING .
    "! Determine cost based on each character of sign parameter that builds
    "! the template string that includes the currency parameter.
  methods COST_OF
    importing
      !SIGN type STRING
      !CURRENCY type STRING
    returning
      value(RESULT) type STRING .
ENDCLASS.



CLASS ZCL_CUSTOM_SIGNS IMPLEMENTATION.


  METHOD build_birthday_sign.
    result = |Happy Birthday! What a { COND #( WHEN age < 50 THEN |young| ELSE |mature| ) } fellow you are.|.
  ENDMETHOD.


  METHOD build_sign.
    result = |Happy { occasion } { name }!|.
  ENDMETHOD.


  METHOD cost_of.
    result = |Your sign costs { 20 + strlen( sign ) * 2 DECIMALS = 2 } { currency }.|.
  ENDMETHOD.


  METHOD graduation_for.
    result = |Congratulations { name }!\nClass of { year }|.
  ENDMETHOD.
ENDCLASS.
