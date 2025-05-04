class_name Message extends Resource

var title: String
var message: String
var is_sending: bool
var serial_attach: FileSystemRoot.FileEntry

static func from_dict(data: Dictionary) -> Message:
	var message = Message.new()
	message.title = data["titulo"]
	message.message = data["mensaje"]
	message.is_sending = data["isSending"]
	#message.serial_attach = JSON.parse_string(data["serialAttach"])
	return message
