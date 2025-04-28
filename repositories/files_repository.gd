extends Node

func get_file_content_by_id(file_id: String) -> String:
	var condition = "ID = '%s'" % [file_id]
	var result = SaveData.select_rows("Files", condition, ["Content"])
	if len(result) == 0:
		return ""
	return Utils.prettier_content(result[0]["Content"])

func get_file_details_by_id(file_id: String) -> Dictionary:
	var condition = "ID = '%s'" % [file_id]
	var result = SaveData.select_rows("Files", condition, ["ID", "Content", "refCount"])
	if len(result) == 0:
		return {
			"ID": file_id,
			"Content": "",
			"refCount": 1
		}
	return Utils.preprocess_query_result(result)[0]
