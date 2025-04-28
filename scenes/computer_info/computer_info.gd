# ------------------------------------------------
# Class Name: ComputerInfo
# Class Description:
# ------------------------------------------------
class_name ComputerInfo extends MarginContainer

@onready var computer_selector_list: Tree = %ComputerSelectorList

@onready var computer_id_line_edit: LineEdit = %ComputerIdLineEdit

@onready var is_router_check_box: CheckBox = %IsRouterCheckBox
@onready var is_player_check_box: CheckBox = %IsPlayerCheckBox
@onready var is_rented_check_box: CheckBox = %IsRentedCheckBox
@onready var is_ctf_check_box: CheckBox = %IsCtfCheckBox

@onready var file_system: MarginContainer = %FileSystem
@onready var config_os: ConfigOs = %ConfigOS
@onready var computer_users: ComputerUsers = %ComputerUsers

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	computer_selector_list.hide_root = true
	computer_selector_list.item_selected.connect(_on_computer_selected)

func load_computer_info() -> void:
	# Reset all data
	file_system.reset()
	config_os.reset()
	_reset_computer_details()
	computer_selector_list.clear()
	var root = computer_selector_list.create_item()
	var last_parent_ip = ""
	var last_parent: TreeItem = null
	
	var recorded_ip_with_types = MapRepository.get_map_ip_with_type()

	for computer in ComputerRepository.get_computer_list():
		if ":" in computer["ID"]:
			var ip_parts = computer["ID"].split(":")
			var ip = ip_parts[0]
			var unique_id = ip_parts[1]
			# 如果和上一个 parent 相同 IP，直接创建子项
			if ip == last_parent_ip and last_parent != null:
				var entry = last_parent.create_child()
				entry.set_text(0, unique_id)
				if computer["IsRouter"] == 1:
					entry.set_icon(0, preload("res://assets/router.svg"))
					entry.set_icon_max_width(0, 16)
				entry.set_metadata(0, computer)
			else:
				# 创建新的 IP 分组
				last_parent = root.create_child()
				last_parent_ip = ip
				last_parent.set_selectable(0, false)
				last_parent.collapsed = true
				last_parent.set_text(0, ip)
				if ip in recorded_ip_with_types:
					var type = recorded_ip_with_types[ip]
					var type_texture = WebTypeTranslator.type_to_texture(type)
					var type_str = WebTypeTranslator.type_translator(type)
					last_parent.set_icon(0, type_texture)
					last_parent.set_icon_max_width(0, 16)
					last_parent.set_tooltip_text(0, type_str)
				var entry = last_parent.create_child()
				entry.set_text(0, unique_id)
				if computer["IsRouter"] == 1:
					entry.set_icon(0, preload("res://assets/router.svg"))
					entry.set_icon_max_width(0, 16)
				entry.set_metadata(0, computer)
		elif "-" in computer["ID"]:
			var uuid_parts = computer["ID"].split("-")
			var entry = root.create_child()
			entry.set_text(0, uuid_parts[0]) # 显示 UUID 的前缀
			entry.set_metadata(0, computer)

func _on_computer_selected() -> void:
	var computer = computer_selector_list.get_selected().get_metadata(0)
	# DisplayServer.clipboard_set(JSON.stringify(computer, "", false))
	_set_computer_details(computer)
	file_system.populate_file_system(computer["FileSystem"])
	config_os.set_config_os_data(computer["ConfigOS"])
	computer_users.populate_computer_users(computer["Users"])

func _set_computer_details(computer: Dictionary) -> void:
	computer_id_line_edit.text = computer["ID"]
	is_router_check_box.button_pressed = computer["IsRouter"]
	is_player_check_box.button_pressed = computer["IsPlayer"]
	is_rented_check_box.button_pressed = computer["IsRented"]
	is_ctf_check_box.button_pressed = computer["IsCTF"]

func _reset_computer_details() -> void:
	computer_id_line_edit.text = ""
	is_router_check_box.button_pressed = false
	is_player_check_box.button_pressed = false
	is_rented_check_box.button_pressed = false
	is_ctf_check_box.button_pressed = false
