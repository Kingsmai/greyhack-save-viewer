class_name PasswordsDB extends RefCounted

static func get_password_dictionary() -> Dictionary[String, String]:
	var password_dict_cache: Dictionary[String, String]
	var query_result = SaveData.select_rows("Passwords", "", ["ID", "PlainPassword"])
	for r in query_result:
		password_dict_cache[r["ID"]] = r["PlainPassword"]
	return password_dict_cache
