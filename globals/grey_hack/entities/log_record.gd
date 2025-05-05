class_name LogRecord extends Resource

enum ActionType {
	open,
	close,
	shell,
	remove,
	bounce,
	download,
	upload
}

var action: ActionType
var ip: String
var date: String
var port: int
var file: String
var bounceIp: String
var player_net_id: String
var tutorial :bool

static func from_dict(data: Dictionary) -> LogRecord:
	var log_record = LogRecord.new()
	log_record.action = data["action"]
	log_record.ip = data["ip"]
	log_record.date = data["fecha"]
	log_record.file = data["file"]
	log_record.bounceIp = data["bounceIp"]
	log_record.player_net_id = data["playerNetID"]
	log_record.tutorial = data["tutorial"]
	return log_record

func get_detail_str() -> String:
	match action:
		ActionType.open:
			return "Connection established on port %d" % port
		ActionType.close:
			return "Connection closed"
		ActionType.shell:
			return "Shell obtained on port %d" % port
		ActionType.remove:
			return "Deleted file %s" % file
		ActionType.bounce:
			return "Connection routed to %s" % bounceIp
	return ""
