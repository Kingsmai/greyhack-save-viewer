class_name Message extends Resource

var title: String
var message: String
var is_sending: bool
var serial_attach: FileSystemRoot.FileEntry

static func from_dict(data: Dictionary) -> Message:
	var msg = Message.new()
	msg.title = data["titulo"]
	msg.message = data["mensaje"]
	msg.is_sending = data["isSending"]
	#msg.serial_attach = JSON.parse_string(data["serialAttach"])
	return msg
