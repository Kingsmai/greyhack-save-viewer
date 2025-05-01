# ------------------------------------------------
# Class Name: UserCardView
# Class Description:
# ------------------------------------------------
class_name UserCardView extends PanelContainer

@onready var username_label: Label = %UsernameLabel
@onready var password_line_edit: LineEdit = %PasswordLineEdit
@onready var plain_password_line_edit: LineEdit = %PlainPasswordLineEdit
@onready var group_tree: Tree = %GroupTree
@onready var is_deletable_check_box: CheckBox = %IsDeletableCheckBox
@onready var total_exp_line_edit: LineEdit = %TotalExpLineEdit
@onready var karma_progress_bar: ProgressBar = %KarmaProgressBar
@onready var pending_mission_line_edit: LineEdit = %PendingMissionLineEdit

func set_user_info(user_info: User) -> void:
	username_label.text = user_info.username
	# TODO: populate_group_tree
	password_line_edit.text = user_info.password
	plain_password_line_edit.text = user_info.plain_password
	is_deletable_check_box.button_pressed = user_info.is_deletable
	total_exp_line_edit.text = str(user_info.total_exp)
	karma_progress_bar.value = user_info.karma.karma_points
	pending_mission_line_edit.text = str(user_info.karma.pending_mission)
