# ------------------------------------------------
# Class Name: PlayerButton
# Class Description:
# ------------------------------------------------
class_name PlayerButton extends Button

signal player_selected(player_id: String)

var player_id: String

func _init(id: String) -> void:
	self.text = id.substr(0, 8)
	self.player_id = id
	self.pressed.connect(_on_button_pressed)


func _on_button_pressed() -> void:
	player_selected.emit(player_id)
