# ------------------------------------------------
# Class Name: ComputersView
# Class Description:
# ------------------------------------------------
class_name ComputersView extends MarginContainer

const COMPUTER_DETAIL_TAB = preload("res://components/computers_view/computer_detail_tab.tscn")

@onready var computers_tree: Tree = %ComputersTree
@onready var computer_tab_container: TabContainer = %ComputerTabContainer

var computer_tree_item_dict: Dictionary[String, TreeItem]

func _ready() -> void:
	computers_tree.hide_root = true
	computers_tree.item_selected.connect(_on_computers_tree_item_selected)
	GreyHack.computers_load.connect(_on_computers_load)

func _on_computers_load(computers: Array[Computer]):
	# Clear all opened computer tabs
	for child in computer_tab_container.get_children():
		computer_tab_container.remove_child(child)
		child.queue_free()
	computers_tree.clear()
	computer_tree_item_dict.clear()
	var root = computers_tree.create_item()
	for computer in computers:
		if computer.ip not in computer_tree_item_dict:
			var ip_tree_item = root.create_child()
			ip_tree_item.set_text(0, computer.ip)
			ip_tree_item.set_selectable(0, false)
			ip_tree_item.set_collapsed_recursive(true)
			computer_tree_item_dict[computer.ip] = ip_tree_item
			if computer.is_unique:
				ip_tree_item.set_selectable(0, true)
				ip_tree_item.set_metadata(0, computer)
				continue
		var computer_tree_item = computer_tree_item_dict[computer.ip].create_child()
		if computer.type != WebTypeTranslator.Type.Unknown:
			var ip_tree_item = computer_tree_item_dict[computer.ip]
			ip_tree_item.set_icon_max_width(0, 16)
			ip_tree_item.set_icon(0, WebTypeTranslator.type_to_texture(computer.type))
		if computer.is_router:
			computer_tree_item.set_icon_max_width(0, 16)
			computer_tree_item.set_icon(0, preload("res://assets/router.svg"))
		computer_tree_item.set_text(0, computer.local_id)
		computer_tree_item.set_metadata(0, computer)

func _on_computers_tree_item_selected() -> void:
	var selected_computer: Computer = computers_tree.get_selected().get_metadata(0)
	# Open a new tab if not found in ComputerTabContainer
	var tab = computer_tab_container.get_children().find_custom(
		func(computer): return computer.name in selected_computer.computer_id
	)
	if tab == -1:
		var new_computer_tab = COMPUTER_DETAIL_TAB.instantiate()
		computer_tab_container.add_child(new_computer_tab)
		new_computer_tab.fetch_and_load_computer_data(selected_computer.computer_id)
		tab = computer_tab_container.get_children().size() - 1
	# Select the new tab
	computer_tab_container.set_tab_icon(tab, WebTypeTranslator.type_to_texture(selected_computer.type))
	computer_tab_container.set_tab_icon_max_width(tab, 16)
	computer_tab_container.set_current_tab(tab)
	
