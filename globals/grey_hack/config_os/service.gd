## Used by services in ConfigOS
class_name Service extends Resource

var id: int
var port: int
var path_exe: String
var path_db: String
var name_exe: String
var name_db: String
var probability: int ## TODO: Don't know what mean
var is_closed: bool

static func from_dict(data: Dictionary) -> Service:
	var service = Service.new()
	service.id = data.get("ID", 0)
	service.id = data.get("puerto", 0)
	service.id = data.get("pathExe", "")
	service.id = data.get("pathDb", "")
	service.id = data.get("nomdb", "")
	service.id = data.get("nomexe", "")
	service.id = data.get("probabilidad", 0)
	service.id = data.get("isClosed", false)
	return service
