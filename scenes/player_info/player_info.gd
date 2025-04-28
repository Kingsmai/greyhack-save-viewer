# ------------------------------------------------
# Class Name: PlayerInfo
# Class Description:
# ------------------------------------------------
class_name PlayerInfo extends MarginContainer

var current_selected_player_id: String = ""

func load_player_info():
	_reset_player_details()
	for child in %PlayerSelectorList.get_children():
		%PlayerSelectorList.remove_child(child)
		child.queue_free()
	# 显示用户列表
	for player_id in PlayersRepository.get_player_id_list():
		var player_button = PlayerButton.new(player_id)
		player_button.player_selected.connect(_on_player_selected)
		%PlayerSelectorList.add_child(player_button)


func _on_player_selected(player_id: String) -> void:
	current_selected_player_id = player_id
	var player = PlayersRepository.get_player_details_by_id(player_id)
	%LongitudeLineEdit.text = str(player["infoMapX"])
	%LatitudeLineEdit.text = str(player["infoMapY"])
	%LastSeenLineEdit.text = Utils.iso_datetime_to_string(player["LastConnection"])
	# DisplayServer.clipboard_set(JSON.stringify(player, "", false))

func _reset_player_details() -> void:
	%LongitudeLineEdit.text = ""
	%LatitudeLineEdit.text = ""
	%LastSeenLineEdit.text = ""
