class_name PlayerDB extends RefCounted

static func load_player_details() -> Player:
	var player := Player.new()
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
	player.player_id = player_data["PlayerID"]
	player.nickname = player_data["Nickname"]
	player.email_address = player_data["EmailAddress"]
	player.bank_account = player_data["BankUser"]
	player.game_over_count = player_data["GameOver"]
	player.location.x = player_data["infoMapX"]
	player.location.y = player_data["infoMapY"]
	player.last_connection = player_data["LastConnection"]
	# Blockchain wallet details
	player.wallet_id = player_data["WalletID"]
	player.wallet_password = player_data["WalletPass"]
	# Login Data (raw data)
	player.login_data = player_data["LoginData"]
	# Player's owned devices (Computer, and Rented server)
	player.owned_devices.clear()
	player.owned_devices.append(player_data["ComputerID"])
	player.owned_devices.append_array(player_data["RentalsInfo"].keys())
	player.player_shop = get_player_shop()
	return player

## Return a dictionary which contains devices(array), customShopSeed(int)
static func get_player_shop() -> Dictionary:
	var result: Dictionary = SaveData.select_rows("Players", "", ["ShopHardware"])[0]["ShopHardware"]
	if result == null or result.is_empty():
		return {
			"devices": [],
			"customShopSeed": 0
		}
	return result
