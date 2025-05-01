extends Node

signal player_details_load(player_data: Player)

signal computers_load(computers_data: Array[Computer])

signal map_load(map_data: Array[MapObject])

var player: Player
var computers_metadata: Array[Computer]
var map_data: Array[MapObject]

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
