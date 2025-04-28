# ------------------------------------------------
# Class Name: BrutalBankInfo
# Class Description:
# ------------------------------------------------
class_name BrutalBankInfo extends MarginContainer

@onready var bank_entry_list: VBoxContainer = %BankEntryList

func load_brutal_bank_info():
	for child in bank_entry_list.get_children():
		bank_entry_list.remove_child(child)
		child.queue_free()
	var file_systems = ComputerRepository.get_computer_all_file_system()
	for file_system in file_systems:
		# Go inside /home/username(not guest)/Config/Bank.txt
		# / folder
		var root_folders = file_system["FileSystem"]["folders"]
		for system_folder in root_folders:
			if system_folder["nombre"] == "home":
				# system_folder = /home folder dict
				for home_folder in system_folder["folders"]:
					if home_folder["nombre"] == "guest":
						# Skip if meet /home/guest folder
						continue
					for user_folder in home_folder["folders"]:
						if user_folder["nombre"] == "Config":
							# user_folder = /home/<user>/Config folder dict
							for config_file in user_folder["files"]:
								if config_file["nombre"] == "Bank.txt":
									var content = FilesRepository.get_file_content_by_id(config_file["ID"])
									var account = content.split(":")[0]
									var enc_password = content.split(":")[1]
									var plain_password = PasswordsRepository.get_password_dictionary()[enc_password]
									create_entry(account, enc_password, plain_password)

func create_entry(account: String, enc_password: String, plain_password: String) -> void:
	var entry_row = HBoxContainer.new()
	var account_line_edit = LineEdit.new()
	account_line_edit.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	account_line_edit.text = account
	entry_row.add_child(account_line_edit)
	var enc_password_line_edit = LineEdit.new()
	enc_password_line_edit.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	enc_password_line_edit.text = enc_password
	entry_row.add_child(enc_password_line_edit)
	var plain_password_line_edit = LineEdit.new()
	plain_password_line_edit.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	plain_password_line_edit.text = plain_password
	entry_row.add_child(plain_password_line_edit)
	bank_entry_list.add_child(entry_row)
	pass
