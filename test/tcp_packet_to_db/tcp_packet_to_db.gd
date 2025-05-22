extends Control

@onready var create_db_button: Button = %CreateDbButton
@onready var is_send_check_button: CheckButton = %IsSendCheckButton
@onready var tcp_packet_code_edit: CodeEdit = %TcpPacketCodeEdit
@onready var save_button: Button = %SaveButton

func _ready() -> void:
	create_db_button.pressed.connect(func():
		SaveData.create_online_db()
	)
	save_button.pressed.connect(func():
		var packet = JSON.parse_string(tcp_packet_code_edit.text)
		var is_send = is_send_check_button.button_pressed
		ServerPacketsDB.insert_packet(packet, is_send)
	)
