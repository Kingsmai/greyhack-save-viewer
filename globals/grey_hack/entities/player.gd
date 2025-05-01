class_name Player extends RefCounted

var player_id: String
var nickname: String
var location: Vector2
var game_over_count: int
var bank_account: String
var email_address: String
var last_connection: String:
	set(value):
		last_connection = value
	get:
		return Utils.iso_datetime_to_string(last_connection)
var wallet_id: String
var wallet_password: String
var login_data: String

var owned_devices: PackedStringArray

var player_shop: Dictionary

func get_player_storage(device_id: String, type: String) -> Array:
	var key
	match type.to_lower():
		"motherboard":
			key = "motherBoards"
		"cpu":
			key = "cpus"
		"gpu":
			key = "gpus"
		"ram":
			key = "rams"
		"harddisk":
			key = "hardDisks"
		"netdevice":
			key = "netDevices"
		"psu":
			key = "psus"
		_:
			return []
	var result = SaveData.select_rows("Players", "", ["Storage"])[0]
	if result == null:
		return []
	if typeof(result["Storage"]) != TYPE_DICTIONARY:
		return []
	var storages: Dictionary = result["Storage"]
	if storages.has("computers"):
		var devices = storages["computers"]
		if devices.has(device_id):
			return devices[device_id][key]
	return []
