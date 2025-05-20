class_name ReverseShell extends Resource

var port: int
var username: String
var pid: int
var net_id: String

static func from_dict(data: Dictionary) -> ReverseShell:
	var reverse_shell = ReverseShell.new()
	reverse_shell.port = data.get("puerto", 0)
	reverse_shell.username = data.get("userName", "")
	reverse_shell.pid = data.get("PID", 0)
	reverse_shell.net_id = data.get("netID", "")
	return reverse_shell
