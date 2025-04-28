# ------------------------------------------------
# Class Name: ComputerInfoUser
# Class Description:
# ------------------------------------------------
class_name ComputerInfoUser extends PanelContainer

func set_user_info(user_info: Dictionary) -> void:
	%UsernameLabel.text = user_info["nombreUsuario"]
	# TODO: populate_group_tree
	%PasswordLineEdit.text = user_info["password"]
	%PlainPasswordLineEdit.text = user_info["passPlano"]
	%IsDeletableCheckBox.button_pressed = user_info["isDeletable"]
	%TotalExpLineEdit.text = str(user_info["totalExp"])
	%KarmaProgressBar.value = user_info["karma"]["karma"]
	%PendingMissionLineEdit.text = str(user_info["karma"]["pendingMission"])
	pass
