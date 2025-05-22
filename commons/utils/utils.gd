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

static func html_to_bbcode(html: String) -> String:
	var bb = html
	bb = bb.replace("<b>", "[b]").replace("</b>", "[/b]")
	bb = bb.replace("<strong>", "[b]").replace("</strong>", "[/b]")
	bb = bb.replace("<i>", "[i]").replace("</i>", "[/i]")
	bb = bb.replace("<em>", "[i]").replace("</em>", "[/i]")
	bb = bb.replace("<u>", "[u]").replace("</u>", "[/u]")
	bb = bb.replace("<br>", "[br]").replace("<br/>", "[br]").replace("<br />", "[br]")

	# 替换链接
	var link_regex = RegEx.new()
	link_regex.compile("<a href=['\"](.*?)['\"]>(.*?)</a>")
	bb = link_regex.sub(bb, "[url=\\1]\\2[/url]", true)

	# 替换颜色标签
	var color_regex = RegEx.new()
	color_regex.compile("<span style=['\"]color:(.*?);?['\"]>(.*?)</span>")
	bb = color_regex.sub(bb, "[color=\\1]\\2[/color]", true)

	# 替换图片标签
	var img_regex = RegEx.new()
	img_regex.compile("<img src=['\"](.*?)['\"] ?/?>")
	bb = img_regex.sub(bb, "[img]\\1[/img]", true)

	# 替换代码块
	bb = bb.replace("<code>", "[code]").replace("</code>", "[/code]")

	# 移除剩余的 HTML 标签
	var strip_tag = RegEx.new()
	strip_tag.compile("<.*?>")
	bb = strip_tag.sub(bb, "", true)

	return bb

static func gh_html_to_bbcode(html: String) -> String:
	var bb = html

	# <b> -> [b]
	bb = bb.replace("<b>", "[b]").replace("</b>", "[/b]")
	bb = bb.replace("<u>", "[u]").replace("</u>", "[/u]")

	# <color=#xxxxxx> -> [color=#xxxxxx]
	var color_regex = RegEx.new()
	color_regex.compile("<color=(#[A-Fa-f0-9]+|[a-zA-Z]+)>")
	bb = color_regex.sub(bb, "[color=$1]", true)
	bb = bb.replace("</color>", "[/color]")
	
	var link_regex = RegEx.new()
	link_regex.compile("<link=(\"[A-Z_]+\")>")
	bb = link_regex.sub(bb, "[url=$1]", true)
	bb = bb.replace("</link>", "[/url]")

	# 换行处理：保留原始换行符
	# 如果是 <br> 或 <br />，你也可以加上
	bb = bb.replace("<br>", "[br]").replace("<br/>", "[br]").replace("<br />", "[br]")

	return bb

## 深拷贝函数
static func deep_copy(original) -> Variant:
	if typeof(original) in [TYPE_ARRAY, TYPE_DICTIONARY]:
		var copy
		if typeof(original) == TYPE_ARRAY:
			copy = []
			for item in original:
				copy.append(deep_copy(item))
		elif typeof(original) == TYPE_DICTIONARY:
			copy = {}
			for key in original.keys():
				copy[key] = deep_copy(original[key])
		return copy
	else:
		return original

static func decode_base64_gzip(encoded_text: String) -> String:
	var byte_array = Marshalls.base64_to_raw(encoded_text)
	# 使用较大的 buffer，避免因估算不足而失败（实际 JSON 字符串远大于压缩内容）
	var max_size := 1024 * 100  # 100 KB
	var decompressed = byte_array.decompress(max_size, FileAccess.CompressionMode.COMPRESSION_GZIP)
	#var estimated_sizes = [1024, 4096, 8192, 16384, 32768, 65536]
	#for size in estimated_sizes:
	if decompressed != null:
		return decompressed.get_string_from_utf8()
	
	push_error("GZIP 解压失败：尝试了多个预估大小仍然无效")
	return ""
