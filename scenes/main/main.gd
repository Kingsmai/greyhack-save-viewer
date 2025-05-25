extends Control

@onready var decipher_window: DecipherWindow = %DecipherWindow

@onready var refresh_button: Button = %RefreshButton
@onready var password_decrypter_button: Button = %PasswordDecrypterButton
@onready var exploit_builder_button: Button = %ExploitBuilderButton

func _ready() -> void:
	get_window().files_dropped.connect(_on_file_dropped)
	refresh_button.pressed.connect(func(): GreyHack.load_data())
	password_decrypter_button.pressed.connect(func(): decipher_window.show())
	exploit_builder_button.pressed.connect(func(): ExploitBuilderWindow.show())
	var file = FileAccess.open("user://config", FileAccess.READ)
	if file != null:
		var file_and_dir_name = file.get_as_text()
		SaveData.db_path = file_and_dir_name
		GreyHack.load_data()

func _on_file_dropped(files: PackedStringArray) -> void:
	var file_and_dir_name = files[0]
	var ext = file_and_dir_name.get_extension()
	if ext != "db" and ext != "sqlite":
		return
	# Save file_and_dir_name to user://config
	var file = FileAccess.open("user://config", FileAccess.WRITE)
	file.store_string(file_and_dir_name)
	file.close()
	SaveData.db_path = file_and_dir_name
	GreyHack.load_data()
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("refresh"):
		GreyHack.load_data()
	if event.is_action_pressed("server_listener"):
		ServerListenerWindow.visible = !ServerListenerWindow.visible
	if event.is_action_pressed("exploit_builder"):
		ExploitBuilderWindow.visible = !ExploitBuilderWindow.visible
