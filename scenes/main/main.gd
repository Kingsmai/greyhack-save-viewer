extends Control

@onready var player_info: PlayerInfo = %Player
@onready var computer_info: ComputerInfo = %Computer
@onready var website_info: WebsiteInfo = %Website
@onready var bank_info: BankInfo = %Bank
@onready var mail_info: MailInfo = %Mail
@onready var map_info: MapInfo = %Map
@onready var decipher: DecipherView = %Decipher
@onready var brutal_bank_info: BrutalBankInfo = %BrutalBankInfo

@onready var refresh_button: Button = %RefreshButton

func _ready() -> void:
	get_window().files_dropped.connect(_on_file_dropped)
	refresh_button.pressed.connect(func(): load_data())
	if ProjectSettings.get_setting("application/config/isDebug"):
		# Make sure to put your GreyHackDB.db inside the /data folder to load the data.
		var debug_save_path = ProjectSettings.get_setting("application/config/debugSaveFileLocation")
		if debug_save_path != "":
			SaveData.db_path = debug_save_path
		load_data()

func _on_file_dropped(files: PackedStringArray) -> void:
	var file_and_dir_name = files[0]
	var ext = file_and_dir_name.get_extension()
	if ext != "db" and ext != "sqlite":
		return
	SaveData.db_path = file_and_dir_name
	load_data()

func load_data():
	player_info.load_player_info()
	computer_info.load_computer_info()
	website_info.load_website_info()
	bank_info.load_bank_info()
	mail_info.load_email_info()
	map_info.load_map_info()
	decipher.load_decipher_view()
	brutal_bank_info.load_brutal_bank_info()
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("refresh"):
		load_data()
