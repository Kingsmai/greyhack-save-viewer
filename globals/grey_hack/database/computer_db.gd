class_name ComputerDB extends RefCounted

static func load_devices() -> Array[Computer]:
	var result: Array[Computer] = []
	var columns = [
		"ID",
		"IsRouter",
		"IsPlayer",
		"IsRented",
		"IsCTF"
	]
	var query_result = SaveData.select_rows("Computer", "", columns)
	var ip_type_dict = get_ip_type_dict()
	for row in query_result:
		var computer := Computer.new()
		computer.computer_id = row["ID"]
		computer.is_router = row["IsRouter"] == 1
		computer.is_player = row["IsPlayer"] == 1
		computer.is_rented = row["IsRented"] == 1
		computer.is_ctf = row["IsCTF"] == 1
		if computer.ip in ip_type_dict:
			computer.type = ip_type_dict[computer.ip]
		result.append(computer)
	return result

static func get_ip_type_dict() -> Dictionary[String, int]:
	var result: Dictionary[String, int] = {}
	var columns = [
		"IpAddress",
		"TipoRed"
	]
	var query_result = SaveData.select_rows("Map", "", columns)
	for row in query_result:
		result[row["IpAddress"]] = row["TipoRed"]
	return result

static func get_computer_by_id(computer_id: String) -> Computer:
	var columns = [
		"ID",
		"IsRouter",
		"IsPlayer",
		"IsRented",
		"IsCTF",
		"FileSystem",
		"Hardware",
		"Users",
		"ConfigOS",
	]
	var query = "ID = '%s'" % computer_id
	var query_result = SaveData.select_rows("Computer", query, columns)
	if query_result.size() == 0:
		return null
	var record = query_result[0]
	var computer = Computer.new()
	computer.computer_id = record["ID"]
	computer.is_router = record["IsRouter"] == 1
	computer.is_player = record["IsPlayer"] == 1
	computer.is_rented = record["IsRented"] == 1
	computer.is_ctf = record["IsCTF"] == 1
	computer.file_system = FileSystemRoot.load_file_system_from_json(record["FileSystem"])
	computer.hardware = HardwareProfile.load_hardware_from_json(record["Hardware"])
	computer.users = User.load_users_from_json_array(record["Users"])
	computer.config_os = ConfigOS.from_dict(record["ConfigOS"])
	return computer

static func get_all_computers_file_system() -> Array[FileSystemRoot]:
	var result: Array[FileSystemRoot] = []
	var query_result = SaveData.select_rows("Computer", "", ["FileSystem"])
	for row in query_result:
		result.append(FileSystemRoot.load_file_system_from_json(row["FileSystem"]))
	return result
