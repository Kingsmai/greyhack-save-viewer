# ------------------------------------------------
# Class Name: MailView
# Class Description:
# ------------------------------------------------
class_name MailView extends MarginContainer

const MESSAGE_CONTAINER = preload("res://components/mail_view/message_container.tscn")

@onready var mail_account_tree: Tree = %MailAccountTree
@onready var account_line_edit: LineEdit = %AccountLineEdit
@onready var password_line_edit: LineEdit = %PasswordLineEdit
@onready var encrypted_password_line_edit: LineEdit = %EncryptedPasswordLineEdit
@onready var spam_filter_line_edit: LineEdit = %SpamFilterLineEdit
@onready var player_pc_id_line_edit: LineEdit = %PlayerPcIdLineEdit

@onready var email_tree: Tree = %EmailTree

@onready var other_mail_line_edit: LineEdit = %OtherMailLineEdit
@onready var messages_container: VBoxContainer = %MessagesContainer
@onready var email_id_line_edit: LineEdit = %EmailIdLineEdit
@onready var mission_id_line_edit: LineEdit = %MissionIdLineEdit

func _ready() -> void:
	GreyHack.mail_accounts_load.connect(_on_mail_accounts_loaded)
	mail_account_tree.hide_folding = true
	mail_account_tree.hide_root = true
	mail_account_tree.item_selected.connect(_on_mail_account_tree_item_selected)
	email_tree.hide_folding = true
	email_tree.hide_root = true
	email_tree.item_selected.connect(_on_email_tree_item_selected)

func _on_mail_accounts_loaded(mail_accounts: Array[MailAccount]) -> void:
	mail_account_tree.clear()
	var root = mail_account_tree.create_item()
	for mail_account in mail_accounts:
		var mail_account_entry = root.create_child()
		mail_account_entry.set_text(0, mail_account.account)

func _on_mail_account_tree_item_selected() -> void:
	var selected_mail_account_idx = mail_account_tree.get_selected().get_index()
	var selected_mail_account = GreyHack.mail_accounts[selected_mail_account_idx]
	account_line_edit.text = selected_mail_account.account
	password_line_edit.text = selected_mail_account.password
	encrypted_password_line_edit.text = selected_mail_account.encrypted_password
	spam_filter_line_edit.text = str(selected_mail_account.spam_filter)
	player_pc_id_line_edit.text = selected_mail_account.player_pc_id
	email_tree.clear()
	var root = email_tree.create_item()
	for email: Email in selected_mail_account.emails:
		var email_entry = root.create_child()
		if email.is_unread:
			email_entry.set_text(0, "🔴" + email.messages[0].title)
		else:
			email_entry.set_text(0, "🟢" + email.messages[0].title)
		email_entry.set_metadata(0, email)

func _on_email_tree_item_selected() -> void:
	var email: Email = email_tree.get_selected().get_metadata(0)
	other_mail_line_edit.text = email.other_mail
	email_id_line_edit.text = email.id
	mission_id_line_edit.text = email.id_mission
	for child in messages_container.get_children():
		messages_container.remove_child(child)
		child.queue_free()
	for message in email.messages:
		var message_container = MESSAGE_CONTAINER.instantiate()
		messages_container.add_child(message_container)
		message_container.set_message(message)
