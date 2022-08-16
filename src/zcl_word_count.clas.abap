class ZCL_WORD_COUNT definition
  public
  final
  create public .

public section.

  types:
    BEGIN OF return_structure,
        word  TYPE string,
        count TYPE i,
      END OF return_structure .
  types:
    return_table TYPE STANDARD TABLE OF return_structure WITH KEY word .

  methods COUNT_WORDS
    importing
      !PHRASE type STRING
    returning
      value(RESULT) type RETURN_TABLE .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_WORD_COUNT IMPLEMENTATION.


  METHOD count_words.
    DATA(lv_lower) = replace( val   = to_lower( phrase )
                              regex = |[':/.!&@$%^&]|
                              with  = ||
                              occ   = 0  ).
    DATA(lv_delimeted) = replace( val    = lv_lower
                                  regex  = |[ ,\n\t]|
                                  with   = | |
                                  occ    = 0  ).
    REPLACE ALL OCCURRENCES OF '\n' IN lv_delimeted WITH | |.

    SPLIT lv_delimeted AT space INTO TABLE DATA(lt_words).
    SORT lt_words.

    LOOP AT lt_words ASSIGNING FIELD-SYMBOL(<lv_word>).
      CONDENSE <lv_word> NO-GAPS.
      CHECK <lv_word> IS NOT INITIAL.

      DATA(ls_collect) = VALUE return_structure( word  = <lv_word> count = 1 ).
      COLLECT ls_collect INTO result.
    ENDLOOP.

  ENDMETHOD.
ENDCLASS.
