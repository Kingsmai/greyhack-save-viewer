# ------------------------------------------------
# Class Name: ConfigOsView
# Class Description:
# ------------------------------------------------
class_name ConfigOsView extends MarginContainer

@onready var config_os_code_edit: CodeEdit = %ConfigOsCodeEdit
@onready var network_lan_code_edit: CodeEdit = %NetworkLanCodeEdit

@onready var metadata_view: MetadataView = %Metadata
@onready var persons_view: PersonsView = %Persons

func set_config_os_data(data: ConfigOS):
	config_os_code_edit.text = JSON.stringify(data.raw_data, "\t", false)
	metadata_view.set_config_os_metadata(data)
	network_lan_code_edit.text = JSON.stringify(data.network_lan, "\t", false)
	persons_view.load_persons_data(data.person)
