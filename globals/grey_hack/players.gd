class_name Player extends Node

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

func load_player_details() -> void:
	var columns = [
		"PlayerID",
		"infoMapX",
		"infoMapY",
		"GameOver",
		"Nickname",
		"BankUser",
		"EmailAddress",
		"LastConnection",
		"WalletID",
		"WalletPass",
		"ComputerID",
		"RentalsInfo",
		"LoginData",
	]
	var player_data = SaveData.select_rows("Players", "", columns)[0]
	self.player_id = player_data["PlayerID"]
	self.nickname = player_data["Nickname"]
	self.email_address = player_data["EmailAddress"]
	self.bank_account = player_data["BankUser"]
	self.game_over_count = player_data["GameOver"]
	self.location.x = player_data["infoMapX"]
	self.location.y = player_data["infoMapY"]
	self.last_connection = player_data["LastConnection"]
	# Blockchain wallet details
	self.wallet_id = player_data["WalletID"]
	self.wallet_password = player_data["WalletPass"]
	# Login Data (raw data)
	self.login_data = player_data["LoginData"]
	# Player's owned devices (Computer, and Rented server)
	self.owned_devices.clear()
	self.owned_devices.append(player_data["ComputerID"])
	self.owned_devices.append_array(player_data["RentalsInfo"].keys())
	self.player_shop = get_player_shop()
	GreyHack.player_details_load.emit(self)

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

## Return a dictionary which contains devices(array), customShopSeed(int)
func get_player_shop() -> Dictionary:
	var result: Dictionary = SaveData.select_rows("Players", "", ["ShopHardware"])[0]["ShopHardware"]
	if result == null or result.is_empty():
		return {
			"devices": [],
			"customShopSeed": 0
		}
	return result
