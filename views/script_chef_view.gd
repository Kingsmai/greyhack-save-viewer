# ------------------------------------------------
# Class Name: ScriptChefView
# Class Description:
# ------------------------------------------------
class_name ScriptChefView extends MarginContainer

@onready var library_option_button: OptionButton = %LibraryOptionButton
@onready var library_detail_tree: Tree = %LibraryDetailTree
@onready var bake_button: Button = %BakeButton

@onready var decipher_passwd_check_box: CheckBox = %DecipherPasswdCheckBox
@onready var folder_content_check_box: CheckBox = %FolderContentCheckBox

var computer_hack_button_group: ButtonGroup
var folder_hack_button_group: ButtonGroup
@onready var password_reset_line_edit: LineEdit = %PasswordResetLineEdit

@onready var output_code_edit: CodeEdit = %OutputCodeEdit
@onready var suggest_name_line_edit: LineEdit = %SuggestNameLineEdit

func _ready() -> void:
	GreyHack.world_info_load.connect(_on_world_info_loaded)
	library_option_button.allow_reselect = true
	library_option_button.item_selected.connect(_on_library_option_button_selected)
	library_option_button.gui_input.connect(_on_library_option_gui_input)
	library_detail_tree.item_selected.connect(_on_library_detail_tree_item_selected)
	bake_button.pressed.connect(_on_bake_button_pressed)
	_init_tree_columns()
	computer_hack_button_group = decipher_passwd_check_box.button_group
	folder_hack_button_group = folder_content_check_box.button_group
	computer_hack_button_group.get_buttons()[0].button_pressed = true
	folder_hack_button_group.get_buttons()[0].button_pressed = true
	_set_user_controls_states(null)
	output_code_edit.editable = false
	output_code_edit.focus_entered.connect(func(): DisplayServer.clipboard_set(output_code_edit.text))
	suggest_name_line_edit.editable = false
	suggest_name_line_edit.focus_entered.connect(func(): DisplayServer.clipboard_set(suggest_name_line_edit.text))

func _init_tree_columns() -> void:
	library_detail_tree.hide_root = true
	library_detail_tree.hide_folding = true
	library_detail_tree.column_titles_visible = true
	library_detail_tree.select_mode = Tree.SELECT_ROW
	var titles = [
		"Memory Zone", "Unsec Value", "Hack Type", "Permissions",
		"Path Exists", "Reg User", "Port Fwd", "Gw Conn", "Lib Req", "Active User"
	]
	library_detail_tree.columns = titles.size()
	for i in titles.size():
		library_detail_tree.set_column_title(i, titles[i])
	library_detail_tree.set_column_custom_minimum_width(1, 200)
	library_detail_tree.set_column_custom_minimum_width(2, 150)
	library_detail_tree.set_column_custom_minimum_width(8, 150)
	library_detail_tree.set_column_expand(5, false)
	library_detail_tree.set_column_expand(6, false)
	library_detail_tree.set_column_expand(7, false)

func _on_world_info_loaded(world_info: WorldInfo) -> void:
	_populate_library_option(world_info.all_libs)

func _populate_library_option(all_libs: Dictionary) -> void:
	library_option_button.clear()
	for lib in all_libs:
		library_option_button.add_item(lib)
	library_option_button.item_selected.emit(0)

func _on_library_option_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_up") or event.is_action_pressed("ui_down"):
		_navigate_library_options(event)
		accept_event()

func _navigate_library_options(event: InputEvent) -> void:
	var current = library_option_button.get_selected_id()
	var count = library_option_button.item_count
	var next = (current + (1 if event.is_action_pressed("ui_down") else -1) + count) % count
	library_option_button.select(next)
	library_option_button.item_selected.emit(next)

func _on_library_option_button_selected(idx: int) -> void:
	var lib_name = library_option_button.get_item_text(idx)
	var lib_ids = GreyHack.world_info.all_libs[lib_name]
	_populate_library_details(lib_ids)

func _populate_library_details(lib_ids: Array) -> void:
	library_detail_tree.clear()
	var root = library_detail_tree.create_item()
	for id in lib_ids:
		var content = FilesDB.get_file_details_by_id(id)["Content"]
		if content == null or typeof(content) == TYPE_STRING:
			continue
		var lib = Lib.from_dict(content)
		_add_library_version_entry(root, lib)

func _add_library_version_entry(root: TreeItem, lib: Lib) -> void:
	var version_item = root.create_child()
	version_item.set_text(0, lib.version.version_str)
	version_item.set_selectable(0, false)
	for zone_key in lib.memory_zone_list:
		var zone: MemoryZone = lib.memory_zone_list[zone_key]
		for vuln in zone.vulnerabilities:
			_add_exploit_entry(version_item, lib, zone, vuln)

func _add_exploit_entry(parent: TreeItem, lib: Lib, zone: MemoryZone, vuln: Vulnerability) -> void:
	var item = parent.create_child()
	item.set_metadata(0, lib)
	item.set_metadata(1, zone)
	item.set_metadata(2, vuln)
	item.set_text(0, zone.address)
	item.set_editable(0, true)
	var result = vuln.helper_hack_result
	item.set_text(1, vuln.unsec_value)
	item.set_editable(1, true)
	_set_remote_local_colors(item, vuln)
	item.set_text(2, HackResultType.translate(result.hack_result))
	item.set_text(3, result.user)
	item.set_text(4, result.path_exist)
	item.set_text(5, str(result.num_register_users))
	item.set_text(6, str(result.num_port_forward))
	item.set_text(7, str(result.num_conn_gateway))
	item.set_text_alignment(5, HORIZONTAL_ALIGNMENT_CENTER)
	item.set_text_alignment(6, HORIZONTAL_ALIGNMENT_CENTER)
	item.set_text_alignment(7, HORIZONTAL_ALIGNMENT_CENTER)
	_set_required_action_colors(item, vuln.required_actions)
	item.set_text(8, _get_required_library(vuln.required_actions, LibraryType.translate(vuln.required_lib), vuln.req_lib_version))
	item.set_text(9, ", ".join(_get_active_users(vuln.required_actions)))
	item.set_custom_color(2, _get_result_color(result.hack_result))
	item.set_custom_color(3, _get_user_color(result.user))

func _set_remote_local_colors(item: TreeItem, vuln: Vulnerability) -> void:
	if vuln.is_remote:
		item.set_custom_color(0, Color.CYAN)
		item.set_custom_color(1, Color.CYAN)
	else:
		item.set_custom_color(0, Color.YELLOW)
		item.set_custom_color(1, Color.YELLOW)

func _set_required_action_colors(item: TreeItem, actions: Array) -> void:
	var highlight = Color.CYAN
	var dim = Color.WHITE
	dim.a = 0.2
	item.set_custom_color(4, highlight if HackRequiredType.Type.PATH_EXIST in actions else dim)
	item.set_custom_color(5, highlight if HackRequiredType.Type.NUMBER_USERS_REGISTER in actions else dim)
	item.set_custom_color(6, highlight if HackRequiredType.Type.PORT_FORWARD in actions else dim)
	item.set_custom_color(7, highlight if HackRequiredType.Type.CONN_GATEWAY in actions else dim)
	if HackRequiredType.Type.ROOT_ACTIVE_USER in actions or \
	HackRequiredType.Type.GUEST_ACTIVE_USER in actions or \
	HackRequiredType.Type.ANY_ACTIVE_USER in actions:
		item.set_custom_color(9, highlight)
	else:
		item.set_custom_color(9, dim)

func _get_active_users(actions: Array) -> PackedStringArray:
	var users: PackedStringArray = []
	for action in actions:
		match action:
			HackRequiredType.Type.ROOT_ACTIVE_USER: users.append("Root")
			HackRequiredType.Type.GUEST_ACTIVE_USER: users.append("Guest")
			HackRequiredType.Type.ANY_ACTIVE_USER: users.append("Any")
	return users

func _get_required_library(actions: Array, lib: String, ver: String) -> String:
	var required_library = ""
	if HackRequiredType.Type.LIBRARY in actions:
		required_library = "%s v%s" % [lib, ver]
	return required_library

func _get_result_color(result_type: int) -> Color:
	match result_type:
		HackResultType.Type.SHELL: return Color.GREEN
		HackResultType.Type.RANDOM_FOLDER: return Color.YELLOW_GREEN
		HackResultType.Type.CHANGE_PASS: return Color.YELLOW
		HackResultType.Type.COMPUTER: return Color.ORANGE
		HackResultType.Type.FIREWALL_DISABLE: return Color.ORANGE_RED
		HackResultType.Type.OVERRIDE_SETTINGS: return Color.RED
		HackResultType.Type.TRAFFIC_LIGHT_CONTROL: return Color.CRIMSON
		_: return Color.WHITE

func _get_user_color(user: String) -> Color:
	match user:
		"root": return Color.GREEN
		"normal_user": return Color.YELLOW
		"guest": return Color.RED
		_: return Color.WHITE

func _set_user_controls_states(helper_hack_result: HelperHackResult) -> void:
	var mode = helper_hack_result.hack_result if helper_hack_result != null else HackResultType.Type.SHELL
	for btn in folder_hack_button_group.get_buttons():
		folder_content_check_box.text = "Print %s Contents" % helper_hack_result.random_path if helper_hack_result != null else ""
		btn.disabled = mode != HackResultType.Type.RANDOM_FOLDER
	for btn in computer_hack_button_group.get_buttons():
		btn.disabled = mode != HackResultType.Type.COMPUTER
	password_reset_line_edit.editable = mode == HackResultType.Type.CHANGE_PASS

func _on_library_detail_tree_item_selected() -> void:
	output_code_edit.text = ""
	suggest_name_line_edit.text = ""
	var current_selected = library_detail_tree.get_selected()
	var vuln: Vulnerability = current_selected.get_metadata(2)
	if vuln == null: return
	_set_user_controls_states(vuln.helper_hack_result)
	if vuln.helper_hack_result.hack_result not in [
		HackResultType.Type.RANDOM_FOLDER,
		HackResultType.Type.CHANGE_PASS,
		HackResultType.Type.COMPUTER
	]:
		_bake_script()

func _on_bake_button_pressed() -> void:
	_bake_script()

func _bake_script() -> void:
	var current_selected = library_detail_tree.get_selected()
	if current_selected == null:
		return
	var lib: Lib = current_selected.get_metadata(0)
	var zone: MemoryZone = current_selected.get_metadata(1)
	var vuln: Vulnerability = current_selected.get_metadata(2)
	var selected_computer_hack = computer_hack_button_group.get_pressed_button().get_index() - 1
	var selected_folder_hack = folder_hack_button_group.get_pressed_button().get_index() - 1
	var new_password = password_reset_line_edit.text
	var source_code = ExploitBuilder.build_exploit(lib, zone, vuln, selected_computer_hack, selected_folder_hack, new_password)
	output_code_edit.text = source_code
	var hack_result_str: String
	match  vuln.helper_hack_result.hack_result:
		HackResultType.Type.RANDOM_FOLDER:
			match selected_folder_hack:
				0: hack_result_str = "folder_contents"
				1: hack_result_str = "folder_etc_passwd"
				2: hack_result_str = "folder_mail_passwd"
		HackResultType.Type.COMPUTER:
			match selected_computer_hack:
				0: hack_result_str = "computer_dec_passwd"
				1: hack_result_str = "computer_dec_bank"
		_: hack_result_str = HackResultType.translate(vuln.helper_hack_result.hack_result).replace(" ", "").to_lower()
			
	var suggested_name = "%s-%s-%s-%s" % [
		LibraryType.translate(lib.id_lib).replace("_", "").replace(".so", ""),
		"".join(lib.version.version),
		hack_result_str,
		vuln.helper_hack_result.user[0]
	]
	suggest_name_line_edit.text = suggested_name
