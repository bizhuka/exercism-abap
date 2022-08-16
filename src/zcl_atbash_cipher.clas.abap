CLASS zcl_atbash_cipher DEFINITION PUBLIC FINAL CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS decode
      IMPORTING
        cipher_text TYPE string
      RETURNING
        VALUE(plain_text)  TYPE string .
    METHODS encode
      IMPORTING
        plain_text        TYPE string
      RETURNING
        VALUE(cipher_text) TYPE string .
  PROTECTED SECTION.
  PRIVATE SECTION.
    TYPES: char1 TYPE c LENGTH 1.

    CONSTANTS: BEGIN OF ms_encode,
                 encode TYPE string VALUE `abcdefghijklmnopqrstuvwxyz`,
                 decode TYPE string VALUE `zyxwvutsrqponmlkjihgfedcba`,
               END OF ms_encode.

    METHODS _replace
      IMPORTING
                iv_char        TYPE char1
                iv_encode      TYPE abap_bool
      RETURNING VALUE(rv_char) TYPE char1.
ENDCLASS.



CLASS zcl_atbash_cipher IMPLEMENTATION.

  METHOD decode.
    DATA(lv_no_space) = replace( val  = to_lower( cipher_text )
                                 sub  = | |
                                 with = ||
                                 occ  = 0 ).
    DO strlen( lv_no_space ) TIMES.
      DATA(lv_offset) = sy-index - 1.
      DATA(lv_char)   = lv_no_space+lv_offset(1).

      plain_text = plain_text &&
                       _replace( iv_char   = CONV char1( lv_char )
                                 iv_encode = abap_false ).
    ENDDO.
  ENDMETHOD.

  METHOD encode.
    DATA(lv_no_space) = replace( val   = to_lower( plain_text )
                                 regex = |[^a-z0-9]+|
                                 with  = ||
                                 occ   = 0 ).

    DATA(lv_count) = 0.
    DO strlen( lv_no_space ) TIMES.
      DATA(lv_offset) = sy-index - 1.
      DATA(lv_char)   = lv_no_space+lv_offset(1).

      lv_count = ( lv_count + 1 ) MOD 5.
      DATA(lv_delimiter) = COND #( WHEN lv_count = 1 AND cipher_text IS NOT INITIAL THEN | | ELSE || ).

      cipher_text = cipher_text && lv_delimiter &&
                       _replace( iv_char   = CONV char1( lv_char )
                                 iv_encode = abap_true ).
    ENDDO.
  ENDMETHOD.

  METHOD _replace.
    rv_char = iv_char.

    FIND FIRST OCCURRENCE OF iv_char IN COND #( WHEN iv_encode = abap_true
                                                THEN ms_encode-encode
                                                ELSE ms_encode-decode )
         MATCH OFFSET DATA(lv_off).
    CHECK sy-subrc = 0.

    DATA(lv_replace) = COND #( WHEN iv_encode = abap_true
                               THEN ms_encode-decode
                               ELSE ms_encode-encode ).
    rv_char = lv_replace+lv_off(1).
  ENDMETHOD.

ENDCLASS.
