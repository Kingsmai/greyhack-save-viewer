extends Node

func get_map_list() -> Array[Dictionary]:
	var result = SaveData.select_rows("Map", "", [
		"posX", "posY", "Bssid", "Essid",
		"ID", "WebAddress", "TipoRed", "IpAddress",
		"Seed", "Mission", "AccessType",
		"LibVersions", "generateds", "MissionNpcNames", "Date"
	])
	return Utils.preprocess_query_result(result)

func get_map_ip_with_type() -> Dictionary[String, int]:
	var result = SaveData.select_rows("Map", "", ["IpAddress", "TipoRed"])
	var ip_with_type: Dictionary[String, int] = {}
	for r in result:
		ip_with_type[r["IpAddress"]] = r["TipoRed"]
	return ip_with_type
