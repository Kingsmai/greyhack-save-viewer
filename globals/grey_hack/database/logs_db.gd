class_name LogDB extends RefCounted

static func get_log_contents_by_computer_id(computer_id: String) -> Array[LogRecord]:
	var log_records = [] as Array[LogRecord]
	var conditions = "ID = '%s'" % computer_id
	var query_result = SaveData.select_rows("Logs", conditions, ["Log"])
	if query_result.size() > 0:
		var log_contents = query_result[0]["Log"]["contentLog"]
		for log_content in log_contents:
			log_records.append(LogRecord.from_dict(log_content))
	return log_records
