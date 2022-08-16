class ZCL_RLE definition
  public
  final
  create public .

public section.

  methods ENCODE
    importing
      !INPUT type STRING
    returning
      value(RESULT) type STRING .
  methods DECODE
    importing
      !INPUT type STRING
    returning
      value(RESULT) type STRING .
ENDCLASS.



CLASS ZCL_RLE IMPLEMENTATION.


  METHOD decode.
    CHECK input IS NOT INITIAL.

    DATA(lv_whole_num) = ||.
    DATA(lv_repeat)    = 1.

    DO strlen( input ) TIMES.
      DATA(lv_index) = sy-index - 1.
      DATA(lv_cur_char) = input+lv_index(1).
      lv_whole_num = |{ lv_whole_num }{ lv_cur_char }|.

      IF lv_whole_num CO '0123456789'.
        lv_repeat = lv_whole_num.
        CONTINUE.
      ENDIF.

      DATA(lv_len) = strlen( lv_whole_num ) - 1.
      lv_whole_num = lv_whole_num(lv_len).

      result = |{ result }{
                       COND #( WHEN NOT lv_whole_num CO '0123456789'
                               THEN lv_cur_char
                               ELSE repeat( val = lv_cur_char occ = lv_repeat ) ) }|.
      lv_whole_num = ||.
      lv_repeat    = 1.
    ENDDO.
  ENDMETHOD.


  METHOD encode.
    CHECK input IS NOT INITIAL.

    DATA(lv_prev_char) = input+0(1).
    DATA(lv_count)     = 1.

    DO strlen( input ) TIMES.
      IF strlen( input ) > sy-index.
        DATA(lv_cur_char) = input+sy-index(1).

        IF lv_prev_char = lv_cur_char.
          lv_count = lv_count + 1.
          CONTINUE.
        ENDIF.
      ENDIF.

      result = |{ result }{
                       COND #( WHEN lv_count = 1 THEN || ELSE |{ lv_count }| ) }{
                       lv_prev_char }|.

      lv_prev_char = lv_cur_char.
      lv_count     = 1.
    ENDDO.

  ENDMETHOD.
ENDCLASS.
