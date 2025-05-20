class_name PersonsView extends MarginContainer

@onready var person_tree: Tree = %PersonTree

@onready var mail_account_line_edit: LineEdit = %MailAccountLineEdit
@onready var mail_password_line_edit: LineEdit = %MailPasswordLineEdit
@onready var mail_enc_password_line_edit: LineEdit = %MailEncPasswordLineEdit

@onready var bank_account_line_edit: LineEdit = %BankAccountLineEdit
@onready var bank_password_line_edit: LineEdit = %BankPasswordLineEdit
@onready var bank_enc_password_line_edit: LineEdit = %BankEncPasswordLineEdit

@onready var open_npc_viewer_button: Button = %OpenNpcViewerButton

@onready var person_detail_container: VBoxContainer = %PersonDetailContainer

func _ready() -> void:
	person_tree.hide_folding = true
	person_tree.hide_root = true
	person_tree.item_selected.connect(_on_person_item_selected)
	for child in person_detail_container.get_children():
		if child is Control:
			child.hide()

func load_persons_data(persons: Array[Person]):
	person_tree.clear()
	var root = person_tree.create_item()
	for person in persons:
		var person_node = root.create_child()
		person_node.set_text(0, person.npc_info.fullname)
		person_node.set_metadata(0, person)

func render_person_data(data: Person):
	mail_account_line_edit.text = data.user_mail.account
	mail_password_line_edit.text = data.user_mail.password
	mail_enc_password_line_edit.text = data.user_mail.encrypted_password
	bank_account_line_edit.text = data.user_bank.user_name
	bank_password_line_edit.text = data.user_bank.password
	bank_enc_password_line_edit.text = data.user_bank.encrypted_password
	open_npc_viewer_button.pressed.connect(func(): NpcViewerWindow.open(data.npc_info))
	for child in person_detail_container.get_children():
		if child is Control:
			child.show()

func _on_person_item_selected() -> void:
	var selected_person: Person = person_tree.get_selected().get_metadata(0)
	render_person_data(selected_person)
