extends Node

## 自定义排序函数：按 IP -> 端口 排序
func sort_ip_port(a: String, b: String) -> bool:
	var a_parts = a.split(":")
	var b_parts = b.split(":")
	# 确保格式正确
	if a_parts.size() != 2 or b_parts.size() != 2:
		return a < b  # fallback 字符串比较
	var a_ip = a_parts[0].split(".")
	var b_ip = b_parts[0].split(".")
	# 比较 IP 部分
	for i in range(4):
		if a_ip[i] != b_ip[i]:
			return int(a_ip[i]) < int(b_ip[i])
	# IP 相同则比较端口
	return int(a_parts[1]) < int(b_parts[1])

## 返回一个包含所有 ComputerID 的字符串数组[br]
## 字符串格式可能如下：[br]
## - [code]ip_address:unique_id[/code][br]
## - [code]uuid[/code]
func get_computer_id_list() -> PackedStringArray:
	var ip_ids: Array[String] = []
	var uuid_ids: Array[String] = []
	var computers = SaveData.select_rows("Computer", "", ["*"])
	
	var ip_regex = RegEx.new()
	ip_regex.compile("\\d+\\.\\d+\\.\\d+\\.\\d+:\\d+")
	
	for computer in computers:
		var current_id: String = computer["ID"]
		if ip_regex.search(current_id):
			ip_ids.append(current_id)
		else:
			uuid_ids.append(current_id)
	
	ip_ids.sort_custom(sort_ip_port)
	ip_ids.append_array(uuid_ids)
	return PackedStringArray(ip_ids)

func get_computer_list() -> Array[Dictionary]:
	var computers = SaveData.select_rows("Computer", "", ["*"])
	return Utils.preprocess_query_result(computers)


func get_computer_details_by_id(computer_id: String) -> Dictionary:
	var condition = "ID = '%s'" % computer_id
	return SaveData.select_rows("Computer", condition, ["*"])[0]

func get_computer_all_file_system() -> Array[Dictionary]:
	var result = SaveData.select_rows("Computer", "IsRouter = 0", ["FileSystem"])
	return Utils.preprocess_query_result(result)
