## 表示库或 Metaxploit 的版本号
class_name LibVersion extends Resource

var version: Array[int] = []
var version_str: String:
	get:
		return ".".join(version)

static func from_dict(dict: Dictionary) -> LibVersion:
	var v = LibVersion.new()
	for v_int in dict.get("version", []):
		v.version.append(int(v_int))
	return v
