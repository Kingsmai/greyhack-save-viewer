# ------------------------------------------------
# Class Name: ComputerUsers
# Class Description:
# ------------------------------------------------
class_name ComputerUsers extends MarginContainer

@onready var user_container: HBoxContainer = %UserContainer

const COMPUTER_INFO_USER = preload("res://components/computer_info_user/computer_info_user.tscn")

func populate_computer_users(computer_users: Array) -> void:
	for child in user_container.get_children():
		user_container.remove_child(child)
		child.free()
	for user in computer_users:
		var user_info_card = COMPUTER_INFO_USER.instantiate()
		user_info_card.set_user_info(user)
		user_container.add_child(user_info_card)
