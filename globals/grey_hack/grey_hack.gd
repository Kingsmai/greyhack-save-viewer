extends Node

signal player_details_load(player_data: Player)

var player: Player = Player.new()

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
	player.load_player_details()
