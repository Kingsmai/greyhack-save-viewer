# ------------------------------------------------
# Class Name: ConfigOsView
# Class Description:
# ------------------------------------------------
class_name ConfigOsView extends MarginContainer

@onready var config_os_code_edit: CodeEdit = %ConfigOsCodeEdit

func set_config_os_data(data: Dictionary):
	config_os_code_edit.text = JSON.stringify(data, "\t", false)
