# ------------------------------------------------
# Class Name: MailInfo
# Class Description:
# ------------------------------------------------
class_name MailInfo extends MarginContainer

@onready var email_address_selector_list: Tree = %EmailAddressSelectorList
@onready var address_line_edit: LineEdit = %AddressLineEdit
@onready var password_line_edit: LineEdit = %PasswordLineEdit
@onready var enc_password_line_edit: LineEdit = %EncPasswordLineEdit
@onready var spam_filter_line_edit: LineEdit = %SpamFilterLineEdit

@onready var email_selector_list: Tree = %EmailSelectorList

@onready var other_email_line_edit: LineEdit = %OtherEmailLineEdit
@onready var is_protected_check_box: CheckBox = %IsProtectedCheckBox

@onready var messages_code_edit: CodeEdit = %MessagesCodeEdit

@onready var mission_id_line_edit: LineEdit = %MissionIdLineEdit
@onready var email_id_line_edit: LineEdit = %EmailIdLineEdit

func _ready() -> void:
	email_address_selector_list.item_selected.connect(_on_email_address_selected)
	email_address_selector_list.hide_root = true
	email_selector_list.item_selected.connect(_on_email_selected)
	email_selector_list.hide_root = true

func load_email_info() -> void:
	reset_all_details()
	var root = email_address_selector_list.create_item()
	for email_address in EmailAccountsRepository.get_mail_account_list():
		var email_address_entry = root.create_child()
		email_address_entry.set_text(0, email_address["User"])
		email_address_entry.set_metadata(0, email_address)

func _on_email_address_selected() -> void:
	var current_email_address = email_address_selector_list.get_selected().get_metadata(0)
	var current_mail = current_email_address["Mails"]
	address_line_edit.text = current_mail["address"]
	password_line_edit.text = current_mail["plainPassword"]
	enc_password_line_edit.text = current_mail["encPassword"]
	spam_filter_line_edit.text = str(current_mail["spamFilter"])
	# Populate email selector list
	email_selector_list.clear()
	var root = email_selector_list.create_item()
	for email in current_mail["emails"]:
		var email_entry = root.create_child()
		email_entry.set_text(0, email["messages"][0]["titulo"])
		email_entry.set_metadata(0, email)

func _on_email_selected() -> void:
	var current_email = email_selector_list.get_selected().get_metadata(0)
	other_email_line_edit.text = current_email["otherMail"]
	is_protected_check_box.button_pressed = current_email["isProtected"]
	email_id_line_edit.text = current_email["ID"]
	mission_id_line_edit.text = current_email["idMission"]
	messages_code_edit.text = JSON.stringify(current_email["messages"], "\t", false)

func reset_all_details() -> void:
	email_address_selector_list.clear()
	address_line_edit.text = ""
	password_line_edit.text = ""
	enc_password_line_edit.text = ""
	spam_filter_line_edit.text = ""
	email_selector_list.clear()
	other_email_line_edit.text = ""
	is_protected_check_box.button_pressed = false
	messages_code_edit.text = ""
	email_id_line_edit.text = ""
	mission_id_line_edit.text = ""
