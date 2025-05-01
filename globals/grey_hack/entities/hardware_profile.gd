class_name HardwareProfile extends Resource

var hard_disk: HardDisk
var cpus: Array[CPU] = []
var rams: Array[RAM] = []
var gpu: GPU
var power_supply: PowerSupply
var mother_board: MotherBoard
var network_devices: Array[NetworkDevice] = []

class HardDisk:
	var speed: int
	var actual_speed: int
	var total_size: int
	var performance: int
	var affect_performance: int
	var id: String
	var name: String
	var req_power: float
	var quality: int
	var health: float
	var precio: int
	var type: int
	var allow_sell: bool

class CPU:
	var speed: float
	var num_cores: int
	var socket: String
	var id: String
	var name: String
	var req_power: float
	var quality: int
	var health: float
	var precio: int
	var type: int
	var allow_sell: bool

class RAM:
	var memory: int
	var ram_model: int
	var id: String
	var name: String
	var req_power: int
	var quality: int
	var health: float
	var precio: int
	var type: int
	var allow_sell: bool

class GPU:
	var hashrate: int
	var id: String
	var name: String
	var req_power: int
	var quality: int
	var health: int
	var precio: int
	var type: int
	var allow_sell: bool

class PowerSupply:
	var power: int
	var id: String
	var name: String
	var req_power: int
	var quality: int
	var health: float
	var precio: int
	var type: int
	var allow_sell: bool

class MotherBoard:
	var num_cpus: int
	var cpu_socket: String
	var ram_model: int
	var num_ram_sockets: int
	var max_ram_socket: int
	var num_pci: int
	var id: String
	var name: String
	var req_power: int
	var quality: int
	var health: float
	var precio: int
	var type: int
	var allow_sell: bool

class NetworkDevice:
	var is_wifi: bool
	var monitor_support: bool
	var monitor_enabled: bool
	var bssid_ap: String
	var essid_ap: String
	var id: String
	var name: String
	var req_power: int
	var quality: int
	var health: int
	var precio: int
	var type: int
	var allow_sell: bool

static func load_hardware_from_json(data: Dictionary) -> HardwareProfile:
	var profile := HardwareProfile.new()
	
	profile.hard_disk = _parse_hard_disk(data["hardDisk"])
	for cpu_data in data["cpus"]:
		profile.cpus.append(_parse_cpu(cpu_data))
	for ram_data in data["rams"]:
		profile.rams.append(_parse_ram(ram_data))
	profile.gpu = _parse_gpu(data["gpu"])
	profile.power_supply = _parse_power_supply(data["powerSupply"])
	profile.mother_board = _parse_mother_board(data["motherBoard"])
	for net_data in data["networkDevices"]:
		profile.network_devices.append(_parse_network_device(net_data))
	
	return profile

static func _parse_hard_disk(d: Dictionary) -> HardDisk:
	var h := HardDisk.new()
	h.speed = d["speed"]
	h.actual_speed = d["actualSpeed"]
	h.total_size = d["totalSize"]
	h.performance = d["performance"]
	h.affect_performance = d["affectPerformance"]
	h.id = d["ID"]
	h.name = d["name"]
	h.req_power = d["reqPower"]
	h.quality = d["quality"]
	h.health = d["health"]
	h.precio = d["precio"]
	h.type = d["Type"]
	h.allow_sell = d["allowSell"]
	return h

static func _parse_cpu(d: Dictionary) -> CPU:
	var c := CPU.new()
	c.speed = d["speed"]
	c.num_cores = d["numCores"]
	c.socket = d["socket"]
	c.id = d["ID"]
	c.name = d["name"]
	c.req_power = d["reqPower"]
	c.quality = d["quality"]
	c.health = d["health"]
	c.precio = d["precio"]
	c.type = d["Type"]
	c.allow_sell = d["allowSell"]
	return c

static func _parse_ram(d: Dictionary) -> RAM:
	var r := RAM.new()
	r.memory = d["memory"]
	r.ram_model = d["ramModel"]
	r.id = d["ID"]
	r.name = d["name"]
	r.req_power = d["reqPower"]
	r.quality = d["quality"]
	r.health = d["health"]
	r.precio = d["precio"]
	r.type = d["Type"]
	r.allow_sell = d["allowSell"]
	return r

static func _parse_gpu(d: Dictionary) -> GPU:
	var g := GPU.new()
	g.hashrate = d["hashrate"]
	g.id = d["ID"]
	g.name = d["name"]
	g.req_power = d["reqPower"]
	g.quality = d["quality"]
	g.health = d["health"]
	g.precio = d["precio"]
	g.type = d["Type"]
	g.allow_sell = d["allowSell"]
	return g

static func _parse_power_supply(d: Dictionary) -> PowerSupply:
	var p := PowerSupply.new()
	p.power = d["power"]
	p.id = d["ID"]
	p.name = d["name"]
	p.req_power = d["reqPower"]
	p.quality = d["quality"]
	p.health = d["health"]
	p.precio = d["precio"]
	p.type = d["Type"]
	p.allow_sell = d["allowSell"]
	return p

static func _parse_mother_board(d: Dictionary) -> MotherBoard:
	var m := MotherBoard.new()
	m.num_cpus = d["numCpus"]
	m.cpu_socket = d["cpuSocket"]
	m.ram_model = d["ramModel"]
	m.num_ram_sockets = d["numRamSockets"]
	m.max_ram_socket = d["maxRamSocket"]
	m.num_pci = d["numPci"]
	m.id = d["ID"]
	m.name = d["name"]
	m.req_power = d["reqPower"]
	m.quality = d["quality"]
	m.health = d["health"]
	m.precio = d["precio"]
	m.type = d["Type"]
	m.allow_sell = d["allowSell"]
	return m

static func _parse_network_device(d: Dictionary) -> NetworkDevice:
	var n := NetworkDevice.new()
	n.is_wifi = d["isWifi"]
	n.monitor_support = d["monitorSupport"]
	n.monitor_enabled = d["monitorEnabled"]
	n.bssid_ap = d["bssidAp"]
	n.essid_ap = d["essidAp"]
	n.id = d["ID"]
	n.name = d["name"]
	n.req_power = d["reqPower"]
	n.quality = d["quality"]
	n.health = d["health"]
	n.precio = d["precio"]
	n.type = d["Type"]
	n.allow_sell = d["allowSell"]
	return n
