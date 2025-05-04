extends Node

signal player_details_load(player_data: Player)
signal computers_load(computers_data: Array[Computer])
signal map_load(map_data: Array[MapObject])
signal web_pages_load(web_pages: Array[WebPage])
signal world_info_load(world_info: WorldInfo)

signal file_systems_load(file_systems: Array[FileSystemRoot])

var player: Player
var computers_metadata: Array[Computer]
var map_data: Array[MapObject]
var saved_password: Dictionary[String, String]
var web_pages: Array[WebPage]
var world_info: WorldInfo

func _ready() -> void:
	if ProjectSettings.get_setting("application/config/isDebug"):
		# Make sure to put your GreyHackDB.db inside the /data folder to load the data.
		var debug_save_path = ProjectSettings.get_setting("application/config/debugSaveFileLocation")
		if debug_save_path != "":
			SaveData.db_path = debug_save_path
		print("Debug mode on, Loading: " + SaveData.db_path)
		# Wait the components to be ready
		await get_tree().create_timer(1.0).timeout
		load_data()

func load_data() -> void:
	player = PlayerDB.load_player_details()
	player_details_load.emit(player)
	computers_metadata = ComputerDB.load_devices()
	computers_load.emit(computers_metadata)
	map_data = MapDB.load_map()
	map_load.emit(map_data)
	web_pages = WebPagesDB.load_web_pages()
	web_pages_load.emit(web_pages)
	world_info = InfoGenDB.load_info_gen_data()
	world_info_load.emit(world_info)
	var file_systems = ComputerDB.get_all_computers_file_system()
	file_systems_load.emit(file_systems)

func refresh_password():
	saved_password = PasswordsDB.get_password_dictionary()
