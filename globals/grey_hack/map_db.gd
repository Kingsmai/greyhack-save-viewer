class_name MapDB extends RefCounted

static func load_map() -> Array[MapObject]:
	var map: Array[MapObject] = []
	var columns = [
		"posX", "posY",
		"Bssid", "Essid",
		"ID", "WebAddress", "TipoRed", "Seed", "IpAddress",
		"Mission", "AccessType", "LibVersions",
		"generateds", "MissionNpcNames",
		"Date"
	]
	var query_result = SaveData.select_rows("Map", "", columns)
	for row in query_result:
		map.append(MapObject.parse_map_object_from_json(row))
	return map