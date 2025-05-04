class_name InfoGenDB extends Node

static func load_info_gen_data() -> WorldInfo:
	var column = [
		"Seed",
		"VersionsControl", "Exploits", "AllLibs",
		"Clock",
		"Invoices", "GlobalMoney"
	]
	var query_result = SaveData.select_rows("InfoGen", "", column)[0]
	var world_info = WorldInfo.from_dict(query_result)
	return world_info
