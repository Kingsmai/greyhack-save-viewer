# ------------------------------------------------
# Class Name: BankView
# Class Description:
# ------------------------------------------------
class_name BankView extends MarginContainer

@onready var bank_account_tree: Tree = %BankAccountTree

@onready var account_line_edit: LineEdit = %AccountLineEdit
@onready var password_line_edit: LineEdit = %PasswordLineEdit
@onready var original_bank_domain_line_edit: LineEdit = %OriginalBankDomainLineEdit
@onready var original_bank_ip_line_edit: LineEdit = %OriginalBankIpLineEdit
@onready var money_line_edit: LineEdit = %MoneyLineEdit
@onready var is_player_check_box: CheckBox = %IsPlayerCheckBox

@onready var transactions_tree: Tree = %TransactionsTree

func _ready() -> void:
	GreyHack.bank_accounts_load.connect(_on_bank_accounts_load)
	bank_account_tree.hide_folding = true
	bank_account_tree.hide_root = true
	bank_account_tree.item_selected.connect(_on_bank_account_tree_item_selected)
	transactions_tree.hide_folding = true
	transactions_tree.hide_root = true
	transactions_tree.columns = 5
	transactions_tree.column_titles_visible = true
	transactions_tree.set_column_title(0, "Date")
	transactions_tree.set_column_title(1, "Description")
	transactions_tree.set_column_title(2, "Amount")
	transactions_tree.set_column_title(3, "Account")
	transactions_tree.set_column_title(4, "Is Success")

func _on_bank_accounts_load(bank_accounts: Array[BankAccount]):
	bank_account_tree.clear()
	var root = bank_account_tree.create_item()
	for bank_account in bank_accounts:
		var bank_account_entry = root.create_child()
		bank_account_entry.set_text(0, bank_account.account)

func _on_bank_account_tree_item_selected() -> void:
	var selected_bank_account_idx = bank_account_tree.get_selected().get_index()
	var selected_bank_account = GreyHack.bank_accounts[selected_bank_account_idx]
	account_line_edit.text = selected_bank_account.account
	password_line_edit.text = selected_bank_account.password
	original_bank_domain_line_edit.text = selected_bank_account.origin_bank_domain
	original_bank_ip_line_edit.text = selected_bank_account.origin_bank_ip
	money_line_edit.text = str(selected_bank_account.money)
	is_player_check_box.button_pressed = selected_bank_account.is_player
	transactions_tree.clear()
	var root = transactions_tree.create_item()
	for transaction: Transaction in selected_bank_account.transactions:
		var transaction_entry = root.create_child()
		transaction_entry.set_text(0, transaction.date)
		transaction_entry.set_text(1, transaction.reason)
		transaction_entry.set_text(2, str(transaction.amount))
		transaction_entry.set_text_alignment(2, HORIZONTAL_ALIGNMENT_CENTER)
		transaction_entry.set_text(3, transaction.account)
		transaction_entry.set_text(4, str(transaction.is_success))
		transaction_entry.set_text_alignment(4, HORIZONTAL_ALIGNMENT_CENTER)
