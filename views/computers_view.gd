# ------------------------------------------------
# Class Name: ComputersView
# Class Description:
# ------------------------------------------------
class_name ComputersView extends MarginContainer

const COMPUTER_DETAIL_TAB = preload("res://components/computers_view/computer_detail_tab.tscn")

@onready var computers_tree: Tree = %ComputersTree
@onready var computer_tab_container: TabContainer = %ComputerTabContainer

@onready var group_by_type_check_button: CheckButton = %GroupByTypeCheckButton
@onready var sort_by_ip_check_button: CheckButton = %SortByIpCheckButton

var computer_tree_item_dict: Dictionary[String, TreeItem]

func _ready() -> void:
	computers_tree.hide_root = true
	computers_tree.item_selected.connect(_on_computers_tree_item_selected)
	GreyHack.computers_load.connect(_on_computers_load)
	group_by_type_check_button.pressed.connect(func(): render_computer_list(GreyHack.computers_metadata))
	sort_by_ip_check_button.pressed.connect(func(): render_computer_list(GreyHack.computers_metadata))

func _on_computers_load(computers: Array[Computer]):
	# Clear all opened computer tabs
	render_computer_list(computers)

func render_computer_list(computers: Array[Computer]):
	for child in computer_tab_container.get_children():
		computer_tab_container.remove_child(child)
		child.queue_free()
	computers_tree.clear()
	computer_tree_item_dict.clear()
	var computers_clone: Array[Computer] = computers.duplicate(true)
	# 获取排序状态
	var sort_by_ip := sort_by_ip_check_button.button_pressed
	var group_by_type := group_by_type_check_button.button_pressed
	if group_by_type and sort_by_ip:
		# 先按类型分组，再在组内按 IP 排序
		computers_clone.sort_custom(func(a: Computer, b: Computer) -> bool:
			if a.type == b.type:
				return _ip_less_than(a, b)
			else:
				return a.type > b.type
		)
	elif group_by_type:
		# 仅按类型排序
		computers_clone.sort_custom(func(a: Computer, b: Computer) -> bool:
			return a.type > b.type
		)
	elif sort_by_ip:
		# 仅按 IP 排序
		computers_clone.sort_custom(func(a: Computer, b: Computer) -> bool:
			return _ip_less_than(a, b)
		)
	else:
		# 不排序，原样渲染
		_render_computer_list(computers)
		return
	_render_computer_list(computers_clone)

# IP 比较函数：比较 IP 字符串大小，按 IPv4 的数值顺序来排
func _ip_less_than(c1: Computer, c2: Computer) -> bool:
	var parts1 := c1.ip.split(".")
	var parts2 := c2.ip.split(".")
	# IPv4 要有 4 段，如果缺少就填 0
	while parts1.size() < 4:
		parts1.append("0")
	while parts2.size() < 4:
		parts2.append("0")
	for i in range(4):
		var n1 = int(parts1[i])
		var n2 = int(parts2[i])
		if n1 != n2:
			return n1 < n2
	# 如果 IP 相同，比较端口（从原始 computer_id 获取）
	var port1 = int(c1.local_id)
	var port2 = int(c2.local_id)
	return port1 < port2

func _render_computer_list(computers: Array[Computer]):
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
	
