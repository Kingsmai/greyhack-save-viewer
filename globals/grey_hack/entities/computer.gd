class_name Computer extends Resource

var computer_id: String:
	set(value):
		computer_id = value
		is_unique = ":" not in value

var ip: String:
	get:
		if ":" in computer_id:
			return computer_id.split(":")[0]
		else:
			return computer_id
var local_id: String:
	get:
		if ":" in computer_id:
			return computer_id.split(":")[1]
		else:
			return computer_id

var type: WebTypeTranslator.Type = WebTypeTranslator.Type.Unknown

var is_unique: bool
	
var is_router: bool = false
var is_player: bool = false
var is_rented: bool = false
var is_ctf: bool = false

var file_system: FileSystemRoot
var hardware: HardwareProfile
var users: Array[User]
var config_os: ConfigOS
