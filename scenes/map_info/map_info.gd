# ------------------------------------------------
# Class Name: MapInfo
# Class Description:
# ------------------------------------------------
class_name MapInfo extends MarginContainer

@onready var map_selector_list: Tree = %MapSelectorList

@onready var pos_x_line_edit: LineEdit = %PosXLineEdit
@onready var pos_y_line_edit: LineEdit = %PosYLineEdit
@onready var bssid_line_edit: LineEdit = %BssidLineEdit
@onready var essid_line_edit: LineEdit = %EssidLineEdit
@onready var ip_line_edit: LineEdit = %IpLineEdit
@onready var web_address_line_edit: LineEdit = %WebAddressLineEdit
@onready var web_type_line_edit: LineEdit = %WebTypeLineEdit

@onready var other_detail_code_edit: CodeEdit = %OtherDetailCodeEdit

func _ready() -> void:
	map_selector_list.item_selected.connect(_on_map_selected)
	map_selector_list.hide_root = true

func load_map_info() -> void:
	reset_all_details()
	var root = map_selector_list.create_item()
	for map in MapRepository.get_map_list():
		var map_entry = root.create_child()
		map_entry.set_text(0, map["ID"])
		map_entry.set_icon(0, WebTypeTranslator.type_to_texture(map["TipoRed"]))
		map_entry.set_icon_max_width(0, 16)
		map_entry.set_tooltip_text(0, WebTypeTranslator.type_translator(map["TipoRed"]))
		map_entry.set_metadata(0, map)

func _on_map_selected() -> void:
	var current_selected_map = map_selector_list.get_selected().get_metadata(0)
	pos_x_line_edit.text = str(current_selected_map["posX"])
	pos_y_line_edit.text = str(current_selected_map["posY"])
	bssid_line_edit.text = current_selected_map["Bssid"]
	essid_line_edit.text = current_selected_map["Essid"]
	ip_line_edit.text = current_selected_map["IpAddress"]
	web_address_line_edit.text = current_selected_map["WebAddress"]
	web_type_line_edit.text = WebTypeTranslator.type_translator(current_selected_map["TipoRed"])
	other_detail_code_edit.text = JSON.stringify({
		"Seed": current_selected_map["Seed"],
		"Mission": current_selected_map["Mission"],
		"AccessType": current_selected_map["AccessType"],
		"LibVersions": current_selected_map["LibVersions"],
		"generateds": current_selected_map["generateds"],
		"MissionNpcNames": current_selected_map["MissionNpcNames"],
		"Date": current_selected_map["Date"],
	}, "\t", false)

func reset_all_details() -> void:
	map_selector_list.clear()
	pos_x_line_edit.text = ""
	pos_y_line_edit.text = ""
	bssid_line_edit.text = ""
	essid_line_edit.text = ""
	ip_line_edit.text = ""
	web_address_line_edit.text = ""
	web_type_line_edit.text = ""
	other_detail_code_edit.text = ""
