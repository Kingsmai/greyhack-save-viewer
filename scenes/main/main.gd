extends Control

@onready var refresh_button: Button = %RefreshButton

func _ready() -> void:
	get_window().files_dropped.connect(_on_file_dropped)
	refresh_button.pressed.connect(func(): GreyHack.load_data())

func _on_file_dropped(files: PackedStringArray) -> void:
	var file_and_dir_name = files[0]
	var ext = file_and_dir_name.get_extension()
	if ext != "db" and ext != "sqlite":
		return
	SaveData.db_path = file_and_dir_name
	GreyHack.load_data()
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("refresh"):
		GreyHack.load_data()
