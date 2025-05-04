## 表示内存地址区域及其包含的漏洞
class_name MemoryZone extends Resource

var address: String
var times_patched: int
var hide: bool
var vulnerabilities: Array[Vulnerability] = []

static func from_dict(dict: Dictionary) -> MemoryZone:
	var m = MemoryZone.new()
	m.address = dict.get("address", "")
	m.times_patched = dict.get("timesPatched", 0)
	m.hide = dict.get("hide", false)
	
	for vuln_dict in dict.get("vulnerabs", []):
		m.vulnerabilities.append(Vulnerability.from_dict(vuln_dict))
	return m
