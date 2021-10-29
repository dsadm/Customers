class zcl_cmd_vat definition
  public
  create protected.

  public section.
    class-methods: create_instance importing i_extension_id type guid_32
                                             i_vat          type ref to cvis_ei_vat_numbers
                                   returning value(r_vat)   type ref to zcl_cmd_vat.

    methods add_vat_number
      importing
        value(i_country) type land1_gp
        value(i_vat_no)  type stceg
      raising
        zcx_cmd_customer .
    methods change_vat_number
      importing
        value(i_country) type land1_gp
        value(i_vat_no)  type stceg
      raising
        zcx_cmd_customer .
    methods delete_vat_number
      importing
        value(i_country) type land1_gp
      raising
        zcx_cmd_customer .
    methods get_vat_number
      importing
        value(i_country) type land1_gp
      returning
        value(r_vat_no)  type stceg
      raising
        zcx_cmd_customer .
  protected section.
    data: ref_data type ref to cvis_ei_vat_numbers.
    methods constructor importing i_vat type ref to cvis_ei_vat_numbers.
private section.
ENDCLASS.



CLASS ZCL_CMD_VAT IMPLEMENTATION.


  method add_vat_number.

    assign ref_data->vat_numbers[ data_key-land1 = i_country ] to field-symbol(<vat>).
    if sy-subrc ne 0.
      insert value #( task = zcl_cmd_util=>mode-create
                      data_key-land1 = i_country
                      data-stceg = i_vat_no
                    ) into table ref_data->vat_numbers.
    else.
      raise exception type zcx_cmd_customer
        exporting
          no = 010
          v1 = conv #( i_country ).
    endif.

  endmethod.


  method change_vat_number.

    assign ref_data->vat_numbers[ data_key-land1 = i_country ] to field-symbol(<vat>).
    if sy-subrc eq 0.
      <vat>-task = zcl_cmd_util=>mode-change.
      <vat>-data-stceg = i_vat_no.
    else.
      raise exception type zcx_cmd_customer
        exporting
          no = 009
          v1 = conv #( i_country ).
    endif.

  endmethod.


  method constructor.
    ref_data = i_vat.
  endmethod.


  method create_instance.
    if i_extension_id is initial.
      r_vat = new #( i_vat = i_vat ).
    else.
      data: subclass type ref to object.
      try.
          data(sublcass_abs_name) = zcl_cmd_extensions=>get_extension_class_abs_name( id = i_extension_id type = zcl_cmd_extensions=>class_extension-vat ).
          create object subclass type (sublcass_abs_name)
           exporting
            i_vat       = i_vat.
          r_vat ?= subclass.
        catch zcx_cmd_no_extension.
          r_vat = new #( i_vat = i_vat ).
      endtry.
    endif.
  endmethod.


  method delete_vat_number.

    assign ref_data->vat_numbers[ data_key-land1 = i_country ] to field-symbol(<vat>).
    if sy-subrc eq 0.
      <vat>-task = zcl_cmd_util=>mode-delete.
    else.
      raise exception type zcx_cmd_customer
        exporting
          no = 009
          v1 = conv #( i_country ).
    endif.

  endmethod.


  method get_vat_number.

    assign ref_data->vat_numbers[ data_key-land1 = i_country ] to field-symbol(<vat>).
    if sy-subrc eq 0.
      r_vat_no = <vat>-data-stceg.
    else.
      raise exception type zcx_cmd_customer
        exporting
          no = 009
          v1 = conv #( i_country ).
    endif.

  endmethod.
ENDCLASS.
