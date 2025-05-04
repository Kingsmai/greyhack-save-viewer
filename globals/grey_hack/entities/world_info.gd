class_name WorldInfo extends Resource

var rnd_seed: int
var clock: String:
	set(value):
		clock = Utils.iso_datetime_to_string(value)
	get:
		return clock

## Library infomations
var versions_control: Dictionary[String, Lib]

## Exploits[br]
## [code]exploits.lib_name.version = exploit[/code]
var exploits: Dictionary[String, Dictionary]

## Lib and corresponding file
var all_libs: Dictionary[String, PackedStringArray]

## Invoices[br]
## [code]invoices.payment_target = invoice[/code]
## Payment target: BANK / RENTED
var invoices: Dictionary[String, Dictionary]

var global_money: GlobalMoney

static func from_dict(dict: Dictionary) -> WorldInfo:
	var world_info = WorldInfo.new()
	world_info.rnd_seed = dict["Seed"]
	world_info.clock = dict["Clock"]
	for lib in dict["VersionsControl"]:
		world_info.versions_control[lib] = Lib.from_dict(dict["VersionsControl"][lib])
	for lib in dict["Exploits"]:
		world_info.exploits[lib] = {}
		for ver in dict["Exploits"][lib]:
			world_info.exploits[lib][ver] = []
			for exploit in dict["Exploits"][lib][ver]:
				world_info.exploits[lib][ver].append(Exploit.from_dict(exploit))
	for lib in dict["AllLibs"]:
		world_info.all_libs[lib] = [] as PackedStringArray
		for file_id in dict["AllLibs"][lib]:
			world_info.all_libs[lib].append(file_id)
	for player_id in dict["Invoices"]:
		world_info.invoices[player_id] = {}
		for payment_target in dict["Invoices"][player_id]:
			world_info.invoices[player_id][payment_target] = Invoice.from_dict(dict["Invoices"][player_id][payment_target])
	world_info.global_money = GlobalMoney.from_dict(dict["GlobalMoney"])
	return world_info
