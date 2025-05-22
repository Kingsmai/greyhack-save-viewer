# ------------------------------------------------
# Class Name: MapView
# Class Description:
# ------------------------------------------------
class_name MapInfoView extends MarginContainer

@onready var map_selector_list: Tree = %MapSelectorList

@onready var pos_x_line_edit: LineEdit = %PosXLineEdit
@onready var pos_y_line_edit: LineEdit = %PosYLineEdit
@onready var bssid_line_edit: LineEdit = %BssidLineEdit
@onready var essid_line_edit: LineEdit = %EssidLineEdit

@onready var ip_line_edit: LineEdit = %IpLineEdit
@onready var web_address_line_edit: LineEdit = %WebAddressLineEdit
@onready var web_type_line_edit: LineEdit = %WebTypeLineEdit

@onready var generateds_item_list: ItemList = %GeneratedsItemList
@onready var mission_npc_names_tree: Tree = %MissionNpcNamesTree

@onready var random_seed_line_edit: LineEdit = %RandomSeedLineEdit

func _ready() -> void:
	GreyHack.map_load.connect(_on_map_load)
	map_selector_list.hide_folding = true
	map_selector_list.hide_root = true
	map_selector_list.item_selected.connect(_on_map_selector_list_item_selected)
	mission_npc_names_tree.hide_root = true

func _on_map_load(map_data: Array[MapObject]):
	_clear_all_fields()
	if map_data.size() == 0:
		return
	var root = map_selector_list.create_item()
	for map_obj in map_data:
		var map_entry = root.create_child()
		map_entry.set_text(0, map_obj.ip_address)
		map_entry.set_icon(0, WebTypeTranslator.type_to_texture(map_obj.web_type))
		map_entry.set_icon_max_width(0, 16)

func _on_map_selector_list_item_selected():
	var selected_idx = map_selector_list.get_selected().get_index()
	var selected_map_obj = GreyHack.map_data[selected_idx]
	ip_line_edit.text = selected_map_obj.id
	pos_x_line_edit.text = str(selected_map_obj.position.x)
	pos_y_line_edit.text = str(selected_map_obj.position.y)
	bssid_line_edit.text = selected_map_obj.bssid
	essid_line_edit.text = selected_map_obj.essid
	web_address_line_edit.text = selected_map_obj.web_address
	web_type_line_edit.text = WebTypeTranslator.type_translator(selected_map_obj.web_type)
	generateds_item_list.clear()
	for generated_item in selected_map_obj.generateds:
		generateds_item_list.add_item(generated_item)
	mission_npc_names_tree.clear()
	var root = mission_npc_names_tree.create_item()
	for mission_npc_name in selected_map_obj.mission_npc_names:
		var mission_npc_name_entry = root.create_child()
		mission_npc_name_entry.set_text(0, mission_npc_name)
		mission_npc_name_entry.set_selectable(0, false)
		for npc_name in selected_map_obj.mission_npc_names[mission_npc_name]:
			var npc_name_entry = mission_npc_name_entry.create_child()
			npc_name_entry.set_text(0, npc_name)
			npc_name_entry.set_selectable(0, false)
	random_seed_line_edit.text = str(selected_map_obj.rnd_seed)

func _clear_all_fields():
	map_selector_list.clear()
	generateds_item_list.clear()
	mission_npc_names_tree.clear()
	pos_x_line_edit.text = ""
	pos_y_line_edit.text = ""
	bssid_line_edit.text = ""
	essid_line_edit.text = ""
	ip_line_edit.text = ""
	web_address_line_edit.text = ""
	web_type_line_edit.text = ""
	random_seed_line_edit.text = ""
