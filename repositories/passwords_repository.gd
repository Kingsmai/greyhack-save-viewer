extends Node

var password_dict_cache: Dictionary[String, String]

func get_password_dictionary() -> Dictionary[String, String]:
	if password_dict_cache.size() != 0:
		return password_dict_cache
	reload_password_dictionary()
	return password_dict_cache

func reload_password_dictionary() -> void:
	password_dict_cache.clear()
	var query_result = SaveData.select_rows("Passwords", "", ["ID", "PlainPassword"])
	for r in query_result:
		password_dict_cache[r["ID"]] = r["PlainPassword"]
