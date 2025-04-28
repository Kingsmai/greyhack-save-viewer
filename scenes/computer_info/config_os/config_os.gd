# ------------------------------------------------
# Class Name: ConfigOs
# Class Description:
# ------------------------------------------------
class_name ConfigOs extends MarginContainer

@onready var debug_code_edit: CodeEdit = $DebugCodeEdit

func reset() -> void:
	debug_code_edit.text = ""

func set_config_os_data(config_os_data: Dictionary) -> void:
	debug_code_edit.text = JSON.stringify(config_os_data, "\t", false)
