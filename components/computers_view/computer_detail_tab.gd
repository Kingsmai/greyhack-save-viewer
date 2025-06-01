# ------------------------------------------------
# Class Name: ComputerDetailTab
# Class Description:
# ------------------------------------------------
class_name ComputerDetailTab extends MarginContainer

@onready var close_button: Button = %CloseButton

@onready var is_router_check_box: CheckBox = %IsRouterCheckBox
@onready var is_player_check_box: CheckBox = %IsPlayerCheckBox
@onready var is_rented_check_box: CheckBox = %IsRentedCheckBox
@onready var is_ctf_check_box: CheckBox = %IsCtfCheckBox

@onready var file_system: FileSystemView = %FileSystem
@onready var users: UsersView = %Users
@onready var hardware: HardwareView = %Hardware
@onready var config_os: ConfigOsView = %ConfigOS
@onready var log_viewer: LogViewerView = %LogViewer

var current_computer: Computer = null

func _ready() -> void:
	close_button.pressed.connect(_on_close_button_pressed)

func _on_close_button_pressed() -> void:
	close()

func close() -> void:
	get_parent().remove_child(self)
	self.queue_free()

## Computer ID will looks like:[br]
## - "192.168.0.1:12345678"[br]
## - "01234567-89ab-cdef-0123-456789abcdef"[br]
func _set_tab_title(computer_id: String) -> void:
	if ":" in computer_id:
		self.name = computer_id.split(":")[1]
	elif "-" in computer_id:
		self.name = computer_id.split("-")[0]

func _set_flags():
	is_router_check_box.button_pressed = current_computer.is_router
	is_player_check_box.button_pressed = current_computer.is_player
	is_rented_check_box.button_pressed = current_computer.is_rented
	is_ctf_check_box.button_pressed = current_computer.is_ctf

func fetch_and_load_computer_data(computer_id: String) -> void:
	current_computer = ComputerDB.get_computer_by_id(computer_id)
	var logs = LogDB.get_log_contents_by_computer_id(computer_id)
	if current_computer != null:
		_set_flags()
		_set_tab_title(computer_id)
		file_system.populate_file_system(current_computer.file_system)
		users.populate_computer_users(current_computer.users)
		hardware.set_hardware_data(current_computer.hardware)
		config_os.set_config_os_data(current_computer.config_os)		
		log_viewer.set_log_contents(logs)
	else:
		print_debug("Computer not found!")
	pass
