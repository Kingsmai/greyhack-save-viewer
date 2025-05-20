class_name Port extends Resource

var id: int
var internal_port: int
var external_port: int
var is_closed: bool
var is_visible: bool
var lan_ip: String
var is_protected: bool

static func from_dict(data: Dictionary) -> Port:
	var port = Port.new()
	port.id = data.get("ID", 0)
	port.internal_port = data.get("internalPort", 0)
	port.external_port = data.get("externalPort", 0)
	port.is_closed = data.get("isClosed", false)
	port.is_visible = data.get("isVisible", false)
	port.lan_ip = data.get("lanIP", "")
	port.is_protected = data.get("isProtected", false)
	return port
