# ------------------------------------------------
# Class Name: CredentialsView
# Class Description:
# ------------------------------------------------
class_name CredentialsView extends MarginContainer

@onready var bank_credential_tree: Tree = %BankCredentialTree
var bank_credential_tree_root: TreeItem
@onready var mail_credential_tree: Tree = %MailCredentialTree
var mail_credential_tree_root: TreeItem

func _ready() -> void:
	GreyHack.file_systems_load.connect(_on_file_systems_loaded)
	bank_credential_tree.columns = 3
	bank_credential_tree.column_titles_visible = true
	bank_credential_tree.hide_folding = true
	bank_credential_tree.hide_root = true
	bank_credential_tree.set_column_title(0, "Account")
	bank_credential_tree.set_column_title(1, "Plain Password")
	bank_credential_tree.set_column_title(2, "Encrypted Password")
	bank_credential_tree.item_selected.connect(_on_bank_credential_tree_item_selected)
	mail_credential_tree.columns = 3
	mail_credential_tree.column_titles_visible = true
	mail_credential_tree.hide_folding = true
	mail_credential_tree.hide_root = true
	mail_credential_tree.set_column_title(0, "Account")
	mail_credential_tree.set_column_title(1, "Plain Password")
	mail_credential_tree.set_column_title(2, "Encrypted Password")
	mail_credential_tree.item_selected.connect(_on_mail_credential_tree_item_selected)

func _on_file_systems_loaded(file_systems: Array[FileSystemRoot]):
	_clear_all_fields()
	if file_systems.size() == 0:
		return
	var password_list = PasswordsDB.get_password_dictionary()
	bank_credential_tree_root = bank_credential_tree.create_item()
	mail_credential_tree_root = mail_credential_tree.create_item()
	for file_system in file_systems:
		var home_folder = file_system.find_folder_by_path("home")
		for folder in home_folder.folders:
			if folder.name == "guest":
				continue
			var bank_credential_file: FileSystemRoot.FileEntry = folder.find_file_by_path("Config/Bank.txt")
			var mail_credential_file: FileSystemRoot.FileEntry = folder.find_file_by_path("Config/Mail.txt")
			if bank_credential_file != null:
				var bank_cred_file_content = FilesDB.get_file_content_by_id(bank_credential_file.id)
				# Fix weird Out of bounds get index '1' (on base: 'PackedStringArray')
				var bank_cred_file_content_arr = bank_cred_file_content.split(":")
				var enc_password = ""
				var plain_password = ""
				var account = bank_cred_file_content_arr[0]
				if bank_cred_file_content_arr.size() >= 2:
					enc_password = bank_cred_file_content_arr[1]
					plain_password = password_list.get(enc_password, enc_password)
				_create_bank_entry(account, enc_password, plain_password)
			if mail_credential_file != null:
				var mail_cred_file_content = FilesDB.get_file_content_by_id(mail_credential_file.id)
				var mail_cred_file_content_arr = mail_cred_file_content.split(":")
				var enc_password = ""
				var plain_password = ""
				var account = mail_cred_file_content_arr[0]
				if mail_cred_file_content_arr.size() >= 2:
					enc_password = mail_cred_file_content_arr[1]
					plain_password = password_list.get(enc_password, enc_password)
				_create_mail_entry(account, enc_password, plain_password)

func _create_bank_entry(account: String, enc_password: String, plain_password: String) -> void:
	var bank_entry = bank_credential_tree_root.create_child()
	bank_entry.set_text(0, account)
	bank_entry.set_editable(0, true)
	bank_entry.set_text(1, plain_password)
	bank_entry.set_editable(1, true)
	bank_entry.set_text(2, enc_password)

func _create_mail_entry(account: String, enc_password: String, plain_password: String) -> void:
	var mail_entry = mail_credential_tree_root.create_child()
	mail_entry.set_text(0, account)
	mail_entry.set_editable(0, true)
	mail_entry.set_text(1, plain_password)
	mail_entry.set_editable(1, true)
	mail_entry.set_text(2, enc_password)

func _on_bank_credential_tree_item_selected() -> void:
	var column_idx = bank_credential_tree.get_selected_column()
	var current_selected_cell = bank_credential_tree.get_selected().get_text(column_idx)
	print(current_selected_cell)
	DisplayServer.clipboard_set(current_selected_cell)

func _on_mail_credential_tree_item_selected() -> void:
	var column_idx = mail_credential_tree.get_selected_column()
	var current_selected_cell = mail_credential_tree.get_selected().get_text(column_idx)
	print(current_selected_cell)
	DisplayServer.clipboard_set(current_selected_cell)

func _clear_all_fields():
	bank_credential_tree.clear()
	mail_credential_tree.clear()
