# ------------------------------------------------
# Class Name: WebisteView
# Class Description:
# ------------------------------------------------
class_name WebisteView extends MarginContainer

@onready var domain_selector_list: Tree = %DomainSelectorList

@onready var address_line_edit: LineEdit = %AddressLineEdit
@onready var public_ip_line_edit: LineEdit = %PublicIpLineEdit
@onready var port_line_edit: LineEdit = %PortLineEdit
@onready var local_ip_line_edit: LineEdit = %LocalIpLineEdit
@onready var type_net_line_edit: LineEdit = %TypeNetLineEdit
@onready var web_code_edit: CodeEdit = %WebCodeEdit

func _ready() -> void:
	GreyHack.web_pages_load.connect(_on_web_pages_loaded)
	domain_selector_list.hide_folding = true
	domain_selector_list.hide_root = true
	domain_selector_list.item_selected.connect(_on_domain_selector_item_selected)

func _on_web_pages_loaded(data: Array[WebPage]):
	_clear_all_fields()
	if data.size() == 0:
		return
	var root = domain_selector_list.create_item()
	for webpage in data:
		var webpage_entry = root.create_child()
		webpage_entry.set_text(0, webpage.address)
		webpage_entry.set_icon_max_width(0, 16)
		webpage_entry.set_icon(0, WebTypeTranslator.type_to_texture(webpage.type_net))

func _on_domain_selector_item_selected():
	var selected_item_idx = domain_selector_list.get_selected().get_index()
	var selected_webpage = GreyHack.web_pages[selected_item_idx]
	address_line_edit.text = selected_webpage.address
	public_ip_line_edit.text = selected_webpage.public_ip
	port_line_edit.text = str(selected_webpage.external_port)
	local_ip_line_edit.text = selected_webpage.local_ip
	type_net_line_edit.text = WebTypeTranslator.type_translator(selected_webpage.type_net)
	web_code_edit.text = selected_webpage.web_content

func _clear_all_fields():
	domain_selector_list.clear()
	address_line_edit.text = ""
	public_ip_line_edit.text = ""
	port_line_edit.text = ""
	local_ip_line_edit.text = ""
	type_net_line_edit.text = ""
	web_code_edit.text = ""
