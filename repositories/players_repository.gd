extends Node

func get_player_id_list() -> PackedStringArray:
	var result = []
	var players = SaveData.select_rows("Players", "", ["PlayerID"])
	for player in players:
		result.append(player["PlayerID"])
	return result

func get_player_details_by_id(player_id: String) -> Dictionary:
	var condition = "PlayerID = '%s'" % player_id
	return SaveData.select_rows("Players", condition, ["*"])[0]
