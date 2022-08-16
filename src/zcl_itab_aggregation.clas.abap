CLASS zcl_itab_aggregation DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES group TYPE c LENGTH 1.
    TYPES: BEGIN OF initial_numbers_type,
             group  TYPE group,
             number TYPE i,
           END OF initial_numbers_type,
           initial_numbers TYPE STANDARD TABLE OF initial_numbers_type WITH EMPTY KEY.

    TYPES: BEGIN OF aggregated_data_type,
             group   TYPE group,
             count   TYPE i,
             sum     TYPE i,
             min     TYPE i,
             max     TYPE i,
             average TYPE f,
           END OF aggregated_data_type,
           aggregated_data TYPE STANDARD TABLE OF aggregated_data_type WITH EMPTY KEY.

    METHODS perform_aggregation
      IMPORTING
        initial_numbers        TYPE initial_numbers
      RETURNING
        VALUE(aggregated_data) TYPE aggregated_data.
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.



CLASS zcl_itab_aggregation IMPLEMENTATION.
  METHOD perform_aggregation.
    LOOP AT initial_numbers ASSIGNING FIELD-SYMBOL(<ls_line>).
      ASSIGN aggregated_data[ group = <ls_line>-group ] TO FIELD-SYMBOL(<ls_result>).
      IF sy-subrc <> 0.
        APPEND VALUE #( group = <ls_line>-group
                        min   = 2147483647
                        max   = -2147483648 ) TO aggregated_data ASSIGNING <ls_result>.
      ENDIF.

      <ls_result>-min = COND #( WHEN <ls_result>-min > <ls_line>-number THEN <ls_line>-number ELSE <ls_result>-min ).
      <ls_result>-max = COND #( WHEN <ls_result>-max < <ls_line>-number THEN <ls_line>-number ELSE <ls_result>-max ).

      ADD: 1               TO <ls_result>-count,
          <ls_line>-number TO <ls_result>-sum.
      <ls_result>-average = <ls_result>-sum / <ls_result>-count.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.
