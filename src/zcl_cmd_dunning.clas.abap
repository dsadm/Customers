class zcl_cmd_dunning definition
  public
  create protected .

  public section.
    class-methods: create_instance importing i_extension_id   type guid_32
                                             i_dunning        type ref to cmds_ei_dunning_s
                                   returning value(r_dunning) type ref to zcl_cmd_dunning.
    methods:
      get_data returning value(r_result) type ref to cmds_ei_dunning_s,
      set_mahna importing value(i_mahna) type mahna value(i_maber) type maber,
      set_mansp importing value(i_mansp) type mansp value(i_maber) type maber,
      set_madat importing value(i_madat) type madat value(i_maber) type maber,
      set_mahns importing value(i_mahns) type mahns value(i_maber) type maber,
      set_knrma importing value(i_knrma) type knrma value(i_maber) type maber,
      set_gmvdt importing value(i_gmvdt) type gmvdt value(i_maber) type maber,
      set_busab importing value(i_busab) type busab value(i_maber) type maber.
  protected section.
    data: ref_data type ref to cmds_ei_dunning_s.
    methods:
      constructor
        importing
          i_dunning type ref to cmds_ei_dunning_s.

  private section.
ENDCLASS.



CLASS ZCL_CMD_DUNNING IMPLEMENTATION.


  method constructor.
    ref_data = i_dunning.
  endmethod.


  method create_instance.
    if i_extension_id is initial.
      r_dunning = new #( i_dunning = i_dunning ).
    else.
      data: subclass type ref to object.
      try.
          data(sublcass_abs_name) = zcl_cmd_extensions=>get_extension_class_abs_name( id = i_extension_id type = zcl_cmd_extensions=>class_extension-dunning ).
          create object subclass type (sublcass_abs_name)
           exporting
            i_vat       = i_dunning.
          r_dunning ?= subclass.
        catch zcx_cmd_no_extension.
          r_dunning = new #( i_dunning = i_dunning ).
      endtry.
    endif.

  endmethod.


  method get_data.
    r_result = me->ref_data.
  endmethod.


  method set_busab.
    assign ref_data->dunning[ data_key-maber = i_maber ] to field-symbol(<dunning>).
    if sy-subrc = 0.
      <dunning>-data-busab = i_busab.
      <dunning>-datax-busab = abap_true.
      <dunning>-task = zcl_cmd_util=>mode-modify.
    endif.
  endmethod.


  method set_gmvdt.
    assign ref_data->dunning[ data_key-maber = i_maber ] to field-symbol(<dunning>).
    if sy-subrc = 0.
      <dunning>-data-gmvdt = i_gmvdt.
      <dunning>-datax-gmvdt = abap_true.
      <dunning>-task = zcl_cmd_util=>mode-modify.
    endif.
  endmethod.


  method set_knrma.
    assign ref_data->dunning[ data_key-maber = i_maber ] to field-symbol(<dunning>).
    if sy-subrc = 0.
      <dunning>-data-knrma = i_knrma.
      <dunning>-datax-knrma = abap_true.
      <dunning>-task = zcl_cmd_util=>mode-modify.
    endif.
  endmethod.


  method set_madat.
    assign ref_data->dunning[ data_key-maber = i_maber ] to field-symbol(<dunning>).
    if sy-subrc = 0.
      <dunning>-data-madat = i_madat.
      <dunning>-datax-madat = abap_true.
      <dunning>-task = zcl_cmd_util=>mode-modify.
    endif.
  endmethod.


  method set_mahna.
    assign ref_data->dunning[ data_key = i_maber ] to field-symbol(<dunning>).
    if sy-subrc <> 0.
      insert value #( task        = zcl_cmd_util=>mode-create
                      data-mahna  = i_mahna
                      datax-mahna = abap_true
                     ) into table ref_data->dunning assigning <dunning>.
    else.
      <dunning>-data-mahna  = i_mahna.
      <dunning>-datax-mahna = abap_true.
      <dunning>-task        = zcl_cmd_util=>mode-modify.
    endif.
  endmethod.


  method set_mahns.
    assign ref_data->dunning[ data_key-maber = i_maber ] to field-symbol(<dunning>).
    if sy-subrc = 0.
      <dunning>-data-mahns = i_mahns.
      <dunning>-datax-mahns = abap_true.
      <dunning>-task = zcl_cmd_util=>mode-modify.
    endif.
  endmethod.


  method set_mansp.
    assign ref_data->dunning[ data_key-maber = i_maber ] to field-symbol(<dunning>).
    if sy-subrc = 0.
      <dunning>-data-mansp = i_mansp.
      <dunning>-datax-mansp = abap_true.
      <dunning>-task = zcl_cmd_util=>mode-modify.
    endif.
  endmethod.
ENDCLASS.
