class_name MapObject extends Resource

var position: Vector2

var bssid: String
var essid: String

var id: String
var web_address: String
var web_type: int
var rnd_seed: int

var ip_address: String
## TODO: Convert to readable string
var access_type: int

## TODO: No data yet
var mission: String

var lib_versions: LibVersion
## Generated child targets[br]
## For example:[br]
## [code]
## ["4.32.163.189:10598576","4.32.163.189:1481164163","4.32.163.189:1388817960","4.32.163.189:54381521","4.32.163.189:1836523257"]
## [/code]
var generateds: PackedStringArray

## Generated npc targets[br]
## For example:[br]
## [code]
## {"63.230.159.152:321400753":["Olkka"]}
## [/code]
var mission_npc_names: Dictionary[String, PackedStringArray]

## The date of generate
var date: int

class LibVersion:
	## TODO: No data yet
	var lib_versions: Dictionary
	## For example:[br]
	## [code]
	## {
	##   "libssh.so": "6425732fc6a2c72b0ecb0fc78b08dcf2",
	##   "libftp.so": "7615e6956220f523b6a4dbab4c7ded8f",
	## }
	## [/code]
	var lib_versions_sel: Dictionary[String, String]

static func parse_map_object_from_json(json: Dictionary) -> MapObject:
	var map_object: MapObject = MapObject.new()
	map_object.position.x = json["posX"]
	map_object.position.y = json["posY"]
	map_object.bssid = json["Bssid"]
	map_object.essid = json["Essid"]
	map_object.id = json["ID"]
	map_object.web_address = json["WebAddress"]
	map_object.web_type = json["TipoRed"]
	map_object.rnd_seed = json["Seed"]
	map_object.mission = json["Mission"]
	map_object.ip_address = json["IpAddress"]
	map_object.access_type = json["AccessType"]
	map_object.lib_versions = LibVersion.new()
	map_object.lib_versions.lib_versions = json["LibVersions"]["libVersions"]
	map_object.lib_versions.lib_versions_sel = {}
	for key in json["LibVersions"]["libVersionsSel"]:
		map_object.lib_versions.lib_versions_sel[key] = json["LibVersions"]["libVersionsSel"][key]
	map_object.generateds = json["generateds"]
	map_object.mission_npc_names = {}
	for key in json["MissionNpcNames"]:
		map_object.mission_npc_names[key] = [] as PackedStringArray
		for npc in json["MissionNpcNames"][key]:
			map_object.mission_npc_names[key].append(npc)
	map_object.date = json["Date"]
	return map_object
