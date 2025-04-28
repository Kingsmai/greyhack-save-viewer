# ------------------------------------------------
# Class Name: WebsiteInfo
# Class Description:
# ------------------------------------------------
class_name WebsiteInfo extends MarginContainer

@onready var domain_selector_list: Tree = %DomainSelectorList

@onready var address_line_edit: LineEdit = %AddressLineEdit
@onready var public_ip_line_edit: LineEdit = %PublicIpLineEdit
@onready var port_line_edit: LineEdit = %PortLineEdit
@onready var local_ip_line_edit: LineEdit = %LocalIpLineEdit
@onready var type_net_line_edit: LineEdit = %TypeNetLineEdit

@onready var web_code_edit: CodeEdit = %WebCodeEdit

func _ready() -> void:
	domain_selector_list.hide_root = true
	domain_selector_list.item_selected.connect(_on_domain_selected)

func load_website_info() -> void:
	domain_selector_list.clear()
	reset_all_details()
	var root = domain_selector_list.create_item()
	var web_pages = WebPagesRepository.get_web_pages()
	for web_page in web_pages:
		var web_entry = root.create_child()
		web_entry.set_text(0, web_page["Address"])
		web_entry.set_metadata(0, web_page)
		web_entry.set_icon(0, WebTypeTranslator.type_to_texture(web_page["TypeNet"]))
		web_entry.set_tooltip_text(0, WebTypeTranslator.type_translator(web_page["TypeNet"]))
		web_entry.set_icon_max_width(0, 16)

func reset_all_details() -> void:
	address_line_edit.text = ""
	public_ip_line_edit.text = ""
	port_line_edit.text = ""
	local_ip_line_edit.text = ""
	type_net_line_edit.text = ""
	web_code_edit.text = ""

func _on_domain_selected() -> void:
	var selected_web = domain_selector_list.get_selected().get_metadata(0)
	address_line_edit.text = str(selected_web["Address"])
	public_ip_line_edit.text = str(selected_web["PublicIp"])
	port_line_edit.text = str(selected_web["ExternalPort"])
	local_ip_line_edit.text = str(selected_web["LocalIp"])
	type_net_line_edit.text = WebTypeTranslator.type_translator(selected_web["TypeNet"])
	web_code_edit.text = str(selected_web["Web"])
