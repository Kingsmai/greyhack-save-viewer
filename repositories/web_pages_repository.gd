extends Node

func get_web_pages() -> Array[Dictionary]:
	var result = SaveData.select_rows("WebPages", "", [
		"Web",
		"ExternalPort",
		"PublicIp",
		"LocalIp",
		"Address",
		"TypeNet"
	])
	return Utils.preprocess_query_result(result)

func get_web_ip_with_type() -> Dictionary[String, int]:
	var result = SaveData.select_rows("WebPages", "", ["PublicIp", "TypeNet"])
	var ip_with_type: Dictionary[String, int] = {}
	for r in result:
		ip_with_type[r["PublicIp"]] = r["TypeNet"]
	return ip_with_type
