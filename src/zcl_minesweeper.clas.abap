class ZCL_MINESWEEPER definition
  public
  final
  create public .

public section.

  methods CONSTRUCTOR .
  methods ANNOTATE
    importing
      !INPUT type STRING_TABLE
    returning
      value(RESULT) type STRING_TABLE .
  PRIVATE SECTION.
    TYPES: BEGIN OF ts_cell,
             row  TYPE i,
             col  TYPE i,
             mine TYPE abap_bool,
             num  TYPE i,
           END OF ts_cell,
           tt_cell TYPE SORTED TABLE OF ts_cell WITH UNIQUE KEY row col,

           BEGIN OF ts_dx,
             dx_row TYPE i,
             dx_col TYPE i,
           END OF ts_dx,
           tt_dx TYPE STANDARD TABLE OF ts_dx WITH DEFAULT KEY.
    DATA mt_dx TYPE tt_dx.

    METHODS _to_cells
      IMPORTING
        it_input         TYPE string_table
      RETURNING
        VALUE(rt_result) TYPE tt_cell.

    METHODS _from_cells
      IMPORTING
        it_cell          TYPE zcl_minesweeper=>tt_cell
      RETURNING
        VALUE(rt_result) TYPE string_table.
ENDCLASS.



CLASS ZCL_MINESWEEPER IMPLEMENTATION.


  METHOD annotate.
    DATA(lt_cell) = _to_cells( input ).

    LOOP AT lt_cell ASSIGNING FIELD-SYMBOL(<ls_cell>) WHERE mine <> abap_true.
      LOOP AT mt_dx ASSIGNING FIELD-SYMBOL(<ls_dx>).
        READ TABLE lt_cell ASSIGNING FIELD-SYMBOL(<ls_near_cell>)
         WITH TABLE KEY row = <ls_cell>-row + <ls_dx>-dx_row
                        col = <ls_cell>-col + <ls_dx>-dx_col.

        CHECK sy-subrc = 0.
        CHECK <ls_near_cell>-mine = abap_true.
        <ls_cell>-num = <ls_cell>-num + 1.
      ENDLOOP.
    ENDLOOP.

    result = _from_cells( lt_cell ).
  ENDMETHOD.


  METHOD constructor.
    TYPES int_tab TYPE STANDARD TABLE OF i WITH DEFAULT KEY.
    DATA(lt_int) = VALUE int_tab( ( -1 ) ( 0 ) ( 1 ) ).

    DATA: lv_row_dx TYPE i, lv_col_dx TYPE i.
    LOOP AT lt_int INTO lv_row_dx.
      LOOP AT lt_int INTO lv_col_dx.
        CHECK lv_row_dx <> 0 OR lv_col_dx <> 0.
        INSERT VALUE #( dx_row = lv_row_dx
                        dx_col = lv_col_dx ) INTO TABLE mt_dx.
      ENDLOOP.
    ENDLOOP.
  ENDMETHOD.


  METHOD _from_cells.
    DATA(lv_row) = ||.
    LOOP AT it_cell ASSIGNING FIELD-SYMBOL(<ls_cell>).
      DATA(lv_tabix) = sy-tabix.
      lv_row = lv_row && |{ COND #( WHEN <ls_cell>-mine = abap_undefined THEN ||
                                    WHEN <ls_cell>-mine = abap_true      THEN |*|
                                    WHEN <ls_cell>-num  = 0              THEN | |
                                    ELSE |{ <ls_cell>-num }| ) }|.

      READ TABLE it_cell INDEX lv_tabix + 1 ASSIGNING FIELD-SYMBOL(<ls_next_cell>).
      CHECK sy-subrc <> 0 OR <ls_cell>-row <> <ls_next_cell>-row.

      APPEND lv_row TO rt_result.
      CLEAR lv_row.
    ENDLOOP.
  ENDMETHOD.


  METHOD _to_cells.
    LOOP AT it_input ASSIGNING FIELD-SYMBOL(<lv_str_row>).
      DATA(lv_row) = sy-tabix.

      IF <lv_str_row> IS INITIAL.
        INSERT VALUE #( row  = lv_row
                        mine = abap_undefined ) INTO TABLE rt_result.
      ENDIF.

      DO strlen( <lv_str_row> ) TIMES.
        DATA(lv_col)   = sy-index.
        DATA(lv_index) = sy-index - 1.

        INSERT VALUE #( row  = lv_row
                        col  = lv_col
                        mine = xsdbool( <lv_str_row>+lv_index(1) = '*' ) ) INTO TABLE rt_result.
      ENDDO.
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.
