# ------------------------------------------------
# Class Name: UsersView
# Class Description:
# ------------------------------------------------
class_name UsersView extends MarginContainer

@onready var user_container: HBoxContainer = %UserContainer

const USER_CARD_VIEW = preload("res://components/computers_view/user_card_view.tscn")

func populate_computer_users(computer_users: Array[User]) -> void:
	for child in user_container.get_children():
		user_container.remove_child(child)
		child.free()
	for user in computer_users:
		var user_info_card = USER_CARD_VIEW.instantiate()
		user_container.add_child(user_info_card)
		user_info_card.set_user_info(user)
