# ------------------------------------------------
# Class Name: BankInfo
# Class Description:
# ------------------------------------------------
class_name BankInfo extends MarginContainer

@onready var bank_account_selector_list: Tree = %BankAccountSelectorList

@onready var username_line_edit: LineEdit = %UsernameLineEdit
@onready var password_line_edit: LineEdit = %PasswordLineEdit
@onready var credits_line_edit: LineEdit = %CreditsLineEdit
@onready var is_player_check_box: CheckBox = %IsPlayerCheckBox

func _ready() -> void:
	bank_account_selector_list.item_selected.connect(_on_bank_account_selected)
	bank_account_selector_list.hide_root = true

func load_bank_info() -> void:
	bank_account_selector_list.clear()
	reset_all_details()
	var root = bank_account_selector_list.create_item()
	for bank_account in BankAccountsRepository.get_bank_account_list():
		var bank_account_entry = root.create_child(0)
		bank_account_entry.set_text(0, bank_account["User"])
		bank_account_entry.set_metadata(0, bank_account)

func _on_bank_account_selected() -> void:
	var current_selected_bank_account = bank_account_selector_list.get_selected().get_metadata(0)
	var current_transaction = current_selected_bank_account["Transactions"]
	username_line_edit.text = current_transaction["account"]
	password_line_edit.text = current_transaction["password"]
	is_player_check_box.button_pressed = current_transaction["isPlayer"]
	credits_line_edit.text = str(current_transaction["dinero"])

func reset_all_details() -> void:
	username_line_edit.text = ""
	password_line_edit.text = ""
	is_player_check_box.button_pressed = false
	credits_line_edit.text = ""
