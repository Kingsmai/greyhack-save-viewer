# ------------------------------------------------
# Class Name: Utils
# Class Description:
# ------------------------------------------------
class_name Utils extends Node

static func preprocess_query_result(data: Array[Dictionary]) -> Array[Dictionary]:
	for d in data:
		_process_dictionary(d)
	return data

static func _process_dictionary(d: Dictionary) -> void:
	for key in d.keys():
		var val = d[key]
		# 只处理字符串类型
		if typeof(val) != TYPE_STRING:
			continue
		# 去除前后空格
		var val_str: String = val.strip_edges()
		# 只有在明显是 JSON 的时候才尝试解析
		if not (val_str.begins_with("{") or val_str.begins_with("[") or val_str.begins_with('"')):
			continue
		# 尝试解析 JSON
		var parsed = JSON.parse_string(val_str)
		if parsed == null:
			push_warning("JSON parsing failed for key '%s': '%s'" % [key, val_str])
			continue
		# 替换原始值
		d[key] = parsed


static func iso_datetime_to_string(iso_datetime: String):
	var datetime_dict = Time.get_datetime_dict_from_datetime_string(iso_datetime, true)
	return datetime_to_string(datetime_dict)

static func datetime_to_string(datetime_dict: Dictionary):
	# Extract values from the dictionary
	var year = datetime_dict.year
	var month = datetime_dict.month
	var day = datetime_dict.day
	var hour = datetime_dict.hour
	var minute = datetime_dict.minute
	var second = datetime_dict.second
	
	# Format the values into a readable string
	return "%04d-%02d-%02d %02d:%02d:%02d" % [year, month, day, hour, minute, second]

static func prettier_content(base_content: Variant) -> String:
	if typeof(base_content) == TYPE_ARRAY or typeof(base_content) == TYPE_DICTIONARY:
		return JSON.stringify(base_content, "\t", false)
	else:
		return base_content


func _is_iso_datetime(s: String) -> bool:
	# 简单正则匹配 ISO8601 日期字符串格式
	return s.match("^\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}(\\.\\d+)?(Z|[+-]\\d{2}:\\d{2})?$")

static func is_valid_uuid(s: String) -> bool:
	# UUID 的正则表达式，匹配标准的 UUID 格式
	var uuid_regex = "^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$"
	return s.match(uuid_regex)
