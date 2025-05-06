# 顶层类：表示某个库文件的补丁与漏洞情况
class_name Lib extends Resource

var id_patch: int
var id_lib: int
var auto_patch_time: String
var auto_patch_time_str: String:
	get:
		return Utils.iso_datetime_to_string(auto_patch_time)
var num_patches: int
var version: LibVersion
var memory_zone_list: Dictionary[String, MemoryZone]  # key: String (memory address), value: MemoryZone

static func from_dict(dict: Dictionary) -> Lib:
	var obj = Lib.new()
	obj.id_patch = dict.get("idPatch", 0)
	obj.id_lib = dict.get("idLib", 0)
	obj.auto_patch_time = dict.get("autoPatchTime", "")
	obj.num_patches = dict.get("numPatches", 0)
	obj.version = LibVersion.from_dict(dict.get("version", {}))

	obj.memory_zone_list = {} as Dictionary[String, MemoryZone]
	for addr in dict.get("listaZonaMem", {}).keys():
		var zone_dict = dict["listaZonaMem"][addr]
		obj.memory_zone_list[addr] = MemoryZone.from_dict(zone_dict)
	return obj

static func deserialize_lib_patch_map(json_data: Dictionary) -> Dictionary:
	var result := {}
	for lib_name in json_data.keys():
		var lib_patch_dict = json_data[lib_name]
		var lib_patch = Lib.from_dict(lib_patch_dict)
		result[lib_name] = lib_patch
	return result
