class_name FilesDB extends RefCounted

static func get_file_details_by_id(file_id: String) -> Dictionary:
	var result = {
		"ID": file_id,
		"Content": "",
		"refCount": 0
	}
	var condition = "ID = '%s'" % file_id
	var columns = ["ID", "Content", "refCount"]
	var query_result = SaveData.select_rows("Files", condition, columns)
	if query_result.size() > 0:
		result = query_result[0]
	return result

static func get_file_content_by_id(file_id: String) -> String:
	var result: String = ""
	var condition = "ID = '%s'" % file_id
	var columns = ["Content"]
	var query_result = SaveData.select_rows("Files", condition, columns)
	if query_result.size() > 0:
		result = JSON.stringify(query_result[0]["Content"], "\t", false)
	return result
