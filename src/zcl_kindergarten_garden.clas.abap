CLASS zcl_kindergarten_garden DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS constructor.
    METHODS plants
      IMPORTING
        diagram        TYPE string
        student        TYPE string
      RETURNING
        VALUE(results) TYPE string_table.

  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA students TYPE string_table.

ENDCLASS.


CLASS zcl_kindergarten_garden IMPLEMENTATION.
  METHOD constructor.
    students = VALUE #(
    ( |Alice| )
    ( |Bob| )
    ( |Charlie| )
    ( |David| )
    ( |Eve| )
    ( |Fred| )
    ( |Ginny| )
    ( |Harriet| )
    ( |Ileana| )
    ( |Joseph| )
    ( |Kincaid| )
    ( |Larry| )
    ).
    SORT students BY table_line.
  ENDMETHOD.

  METHOD plants.
    READ TABLE students TRANSPORTING NO FIELDS BINARY SEARCH
     WITH KEY table_line = student.
    CHECK sy-subrc = 0.
    DATA(lv_index_base) = ( sy-tabix - 1 ) * 2.

    SPLIT diagram AT '\n' INTO TABLE DATA(lt_diagram_part).
    LOOP AT lt_diagram_part INTO DATA(lv_diagram_part).
      DATA(lv_index_from) = lv_index_base - 1.
      DO 2 TIMES.
        lv_index_from = lv_index_from + 1.
        DATA(lv_letter) = to_upper( lv_diagram_part+lv_index_from(1) ).
        DATA(lv_to_grow) = SWITCH #( lv_letter WHEN 'G' THEN |grass|
                                               WHEN 'C' THEN |clover|
                                               WHEN 'R' THEN |radishes|
                                               WHEN 'V' THEN |violets| ).
        CHECK lv_to_grow IS NOT INITIAL.
        APPEND lv_to_grow TO results.
      ENDDO.
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.
