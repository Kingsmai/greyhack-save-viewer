# ------------------------------------------------
# Class Name: MetadataView
# Class Description:
# ------------------------------------------------
class_name MetadataView extends MarginContainer

@onready var pc_name_line_edit: LineEdit = %PcNameLineEdit
@onready var router_password_line_edit: LineEdit = %RouterPasswordLineEdit
@onready var public_ip_line_edit: LineEdit = %PublicIpLineEdit
@onready var local_ip_line_edit: LineEdit = %LocalIpLineEdit
@onready var orig_public_ip_line_edit: LineEdit = %OrigPublicIpLineEdit
@onready var last_reboot_line_edit: LineEdit = %LastRebootLineEdit
@onready var active_net_card_line_edit: LineEdit = %ActiveNetCardLineEdit

@onready var is_home_network_check_box: CheckBox = %IsHomeNetworkCheckBox
@onready var is_rented_check_box: CheckBox = %IsRentedCheckBox
@onready var saved_check_box: CheckBox = %SavedCheckBox
@onready var override_settings_check_box: CheckBox = %OverrideSettingsCheckBox
@onready var override_used_check_box: CheckBox = %OverrideUsedCheckBox

@onready var ports_tree: Tree = %PortsTree

func _ready() -> void:
	ports_tree.hide_folding = true
	ports_tree.hide_root = true
	ports_tree.columns = 4
	ports_tree.select_mode = Tree.SELECT_ROW
	ports_tree.column_titles_visible = true
	ports_tree.set_column_title(0, "External Port")
	ports_tree.set_column_title(1, "Internal Port")
	ports_tree.set_column_title(2, "STATUS")
	ports_tree.set_column_title(3, "LAN IP")

func set_config_os_metadata(data: ConfigOS) -> void:
	pc_name_line_edit.text = data.pc_name
	router_password_line_edit.text = data.router_password
	public_ip_line_edit.text = data.public_ip
	local_ip_line_edit.text = data.local_ip
	orig_public_ip_line_edit.text = data.original_public_ip
	last_reboot_line_edit.text = data.last_reboot
	active_net_card_line_edit.text = str(data.active_net_card)
	is_home_network_check_box.button_pressed = data.is_home_network
	is_rented_check_box.button_pressed = data.is_rented
	saved_check_box.button_pressed = data.saved
	override_settings_check_box.button_pressed = data.override_settings
	override_used_check_box.button_pressed = data.override_used
	var port_root = ports_tree.create_item()
	for port in data.all_ports:
		var port_node = port_root.create_child()
		var bg_color = (Color.DARK_GREEN if port.is_visible else Color.DARK_RED).darkened(0.5)
		for i in range(4):
			port_node.set_custom_bg_color(i, bg_color)
			port_node.set_text_alignment(i, HORIZONTAL_ALIGNMENT_CENTER)
		port_node.set_text(0, str(port.external_port))
		port_node.set_text(1, str(port.internal_port))
		port_node.set_text(2, "CLOSED" if port.is_closed else "OPEN")
		port_node.set_text(3, port.lan_ip)
