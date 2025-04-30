# ------------------------------------------------
# Class Name: PlayerView
# Class Description:
# ------------------------------------------------
class_name PlayerView extends MarginContainer

@onready var player_id_line_edit: LineEdit = %PlayerIdLineEdit
@onready var nickname_line_edit: LineEdit = %NicknameLineEdit
@onready var player_location_x_line_edit: LineEdit = %PlayerLocationXLineEdit
@onready var player_location_y_line_edit: LineEdit = %PlayerLocationYLineEdit
@onready var game_over_count_line_edit: LineEdit = %GameOverCountLineEdit
@onready var last_seen_line_edit: LineEdit = %LastSeenLineEdit
@onready var bank_account_line_edit: LineEdit = %BankAccountLineEdit
@onready var email_address_line_edit: LineEdit = %EmailAddressLineEdit
@onready var wallet_id_line_edit: LineEdit = %WalletIdLineEdit
@onready var wallet_password_line_edit: LineEdit = %WalletPasswordLineEdit
@onready var login_data_code_edit: CodeEdit = %LoginDataCodeEdit

@onready var owned_devices_tree: Tree = %OwnedDevicesTree
@onready var storage_type_container: HBoxContainer = %StorageTypeContainer
@onready var current_selected_type_label: Label = %CurrentSelectedTypeLabel
@onready var storage_item_tree: Tree = %StorageItemTree
@onready var storage_item_detail_container: VBoxContainer = %StorageItemDetailContainer

@onready var custom_shop_seed_line_edit: LineEdit = %CustomShopSeedLineEdit
@onready var selling_item_tree: Tree = %SellingItemTree
@onready var selling_item_detail_container: VBoxContainer = %SellingItemDetailContainer

func _ready() -> void:
	GreyHack.player_details_load.connect(_on_player_details_load)
	_set_storage_type_buttons_event_listener()
	owned_devices_tree.hide_root = true
	owned_devices_tree.hide_folding = true
	owned_devices_tree.item_selected.connect(_on_owned_devices_tree_item_selected)
	owned_devices_tree.item_activated.connect(_on_owned_devices_tree_item_activated)
	storage_item_tree.hide_root = true
	storage_item_tree.hide_folding = true
	storage_item_tree.item_selected.connect(_on_storage_item_tree_item_selected)
	selling_item_tree.hide_root = true
	selling_item_tree.hide_folding = true
	selling_item_tree.item_selected.connect(_on_selling_item_tree_item_selected)

func _set_storage_type_buttons_event_listener() -> void:
	# Default press the first one:
	var first_button: Button = storage_type_container.get_child(0)
	first_button.button_pressed = true
	current_selected_type_label.text = first_button.text
	for btn: Button in storage_type_container.get_children():
		btn.pressed.connect(func(): _on_storage_type_button_pressed(btn))

func _create_detail_entry(parent: Node, key: String, value: Variant):
	var row = HBoxContainer.new()
	var label = Label.new()
	label.text = key
	label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	label.size_flags_stretch_ratio = 0.5
	label.text_overrun_behavior = TextServer.OVERRUN_TRIM_ELLIPSIS
	row.add_child(label)
	var line_edit = LineEdit.new()
	line_edit.text = str(value)
	line_edit.editable = false
	line_edit.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	row.add_child(line_edit)
	parent.add_child(row)
	pass

func _clear_control_childrens(control: Node):
	for child in control.get_children():
		control.remove_child(child)
		child.queue_free()

func _on_player_details_load(player: Player) -> void:
	player_id_line_edit.text = str(player.player_id)
	nickname_line_edit.text = player.nickname
	player_location_x_line_edit.text = str(player.location.x)
	player_location_y_line_edit.text = str(player.location.y)
	game_over_count_line_edit.text = str(player.game_over_count)
	last_seen_line_edit.text = str(player.last_connection)
	bank_account_line_edit.text = str(player.bank_account)
	email_address_line_edit.text = player.email_address
	wallet_id_line_edit.text = player.wallet_id
	wallet_password_line_edit.text = player.wallet_password
	login_data_code_edit.text = player.login_data
	owned_devices_tree.clear()
	var root = owned_devices_tree.create_item()
	for device in player.owned_devices:
		var device_item = root.create_child()
		device_item.set_text(0, device)
	custom_shop_seed_line_edit.text = str(player.player_shop["customShopSeed"])
	selling_item_tree.clear()
	var selling_item_tree_root = selling_item_tree.create_item()
	for device in player.player_shop["devices"]:
		var device_item = selling_item_tree_root.create_child()
		device_item.set_text(0, device)
		device_item.set_metadata(0, player.player_shop["devices"][device])

func _fetch_and_render_storage_items() -> void:
	var selected_device = owned_devices_tree.get_selected()
	if selected_device == null:
		return
	var device_id = selected_device.get_text(0)
	var item_type = ""
	for btn: Button in storage_type_container.get_children():
		if btn.button_pressed:
			item_type = btn.name.to_lower()
			break
	var item_list = GreyHack.player.get_player_storage(device_id, item_type)
	storage_item_tree.clear()
	_clear_control_childrens(storage_item_detail_container)
	var root = storage_item_tree.create_item()
	for item in item_list:
		var item_entry = root.create_child()
		item_entry.set_text(0, item.name)
		item_entry.set_metadata(0, item)

func _on_owned_devices_tree_item_activated() -> void:
	var item = owned_devices_tree.get_selected().get_text(0)
	# TODO: open device view
	print_debug("Item double clicked: " + item + ", need to open device view later")

func _on_owned_devices_tree_item_selected() -> void:
	_fetch_and_render_storage_items()

func _on_storage_type_button_pressed(btn: Button) -> void:
	for b: Button in storage_type_container.get_children():
		# Act like a tab, Prevent user deselect
		if b == btn:
			current_selected_type_label.text = b.text
			b.button_pressed = true
		else:
			b.button_pressed = false
	_fetch_and_render_storage_items()

func _on_storage_item_tree_item_selected() -> void:
	var item_details: Dictionary = storage_item_tree.get_selected().get_metadata(0)
	_clear_control_childrens(storage_item_detail_container)
	for detail_key in item_details:
		_create_detail_entry(
			storage_item_detail_container, 
			detail_key, 
			item_details[detail_key]
		)

func _on_selling_item_tree_item_selected() -> void:
	var item_details: Dictionary = selling_item_tree.get_selected().get_metadata(0)
	_clear_control_childrens(selling_item_detail_container)
	for detail_key in item_details:
		_create_detail_entry(
			selling_item_detail_container, 
			detail_key, 
			item_details[detail_key]
		)
