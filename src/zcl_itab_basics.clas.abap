CLASS zcl_itab_basics DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    TYPES:
      group TYPE c LENGTH 1 .
    TYPES:
      BEGIN OF initial_type,
        group       TYPE group,
        number      TYPE i,
        description TYPE string,
      END OF initial_type .
    TYPES:
      itab_data_type TYPE STANDARD TABLE OF initial_type WITH EMPTY KEY .

    METHODS fill_itab
      RETURNING
        VALUE(initial_data) TYPE itab_data_type .
    METHODS add_to_itab
      IMPORTING
        !initial_data       TYPE itab_data_type
      RETURNING
        VALUE(updated_data) TYPE itab_data_type .
    METHODS sort_itab
      IMPORTING
        !initial_data       TYPE itab_data_type
      RETURNING
        VALUE(updated_data) TYPE itab_data_type .
    METHODS search_itab
      IMPORTING
        !initial_data       TYPE itab_data_type
      RETURNING
        VALUE(result_index) TYPE i .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_itab_basics IMPLEMENTATION.


  METHOD add_to_itab.
    updated_data[] = initial_data[].
    INSERT VALUE #( group = 'A' number = 19  description = 'Group A-4' ) INTO TABLE updated_data[].
  ENDMETHOD.


  METHOD fill_itab.
    initial_data = VALUE #(
          ( group = 'A' number = 10  description = 'Group A-2' )
          ( group = 'B' number = 5   description = 'Group B' )
          ( group = 'A' number = 6   description = 'Group A-1' )
          ( group = 'C' number = 22  description = 'Group C-1' )
          ( group = 'A' number = 13  description = 'Group A-3' )
          ( group = 'C' number = 500 description = 'Group C-2' )
          ).
  ENDMETHOD.


  METHOD search_itab.
    DATA(temp_data) = initial_data[].

    ASSIGN temp_data[ number = 6 ] TO FIELD-SYMBOL(<ls_result>).
    CHECK <ls_result> IS ASSIGNED.

    result_index = sy-tabix.
  ENDMETHOD.


  METHOD sort_itab.
    updated_data = initial_data.
    SORT updated_data BY group  "AS TEXT
                         number DESCENDING.
  ENDMETHOD.
ENDCLASS.
