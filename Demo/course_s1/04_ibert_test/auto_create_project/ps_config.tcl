proc set_ps_config {bd_cell_name} {
set_property -dict [list \
    CONFIG.DESIGN_MODE {0} \
    CONFIG.PS_PMC_CONFIG { \
      DESIGN_MODE {0} \
      PS_BOARD_INTERFACE {Custom} \
      SMON_ALARMS {Set_Alarms_On} \
      SMON_ENABLE_TEMP_AVERAGING {0} \
      SMON_TEMP_AVERAGING_SAMPLES {0} \
    } \
  ] [get_bd_cells $bd_cell_name]
}