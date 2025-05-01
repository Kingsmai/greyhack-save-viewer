# ------------------------------------------------
# Class Name: DecipherWindow
# Class Description:
# ------------------------------------------------
class_name DecipherWindow extends Window

@onready var reload_button: Button = %ReloadButton
@onready var encrypted_text_code_edit: CodeEdit = %EncryptedTextCodeEdit
@onready var decrypt_button: Button = %DecryptButton
@onready var plain_text_container: VBoxContainer = %PlainTextContainer

func _ready() -> void:
	reload_button.pressed.connect(func(): GreyHack.refresh_password())
	decrypt_button.pressed.connect(_on_decrypt_button_pressed)

func _on_decrypt_button_pressed() -> void:
	var enc_content = encrypted_text_code_edit.text
	var dec_content: String = ""
	for child in plain_text_container.get_children():
		plain_text_container.remove_child(child)
		child.queue_free()
	if enc_content.strip_edges().is_empty():
		return
	var encrypted_texts = enc_content.split("\n")
	for encrypted_text in encrypted_texts:
		var identity: String = "Unknown"
		var base64password: String
		var plain_password: String
		if ":" in encrypted_text:
			identity = encrypted_text.split(":")[0]
			base64password = encrypted_text.split(":")[1]
		else:
			base64password = encrypted_text
		if base64password.strip_edges().is_empty():
			continue
		if base64password in GreyHack.saved_password:
			plain_password = GreyHack.saved_password[base64password]
		else:
			plain_password = base64password
		dec_content += "%s:%s\n" % [identity, plain_password]
		_create_plain_entry(identity, plain_password)

func _create_plain_entry(identity: String, plain_password: String) -> void:
	var entry_row = HBoxContainer.new()
	var identity_line_edit = LineEdit.new()
	identity_line_edit.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	identity_line_edit.text = identity
	entry_row.add_child(identity_line_edit)
	var plain_password_line_edit = LineEdit.new()
	plain_password_line_edit.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	plain_password_line_edit.text = plain_password
	entry_row.add_child(plain_password_line_edit)
	plain_text_container.add_child(entry_row)

func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		hide()
