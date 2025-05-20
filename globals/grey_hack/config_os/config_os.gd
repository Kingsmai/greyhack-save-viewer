class_name ConfigOS extends Resource

var is_rented: bool
var saved: bool
var override_settings: bool
var override_used: bool

var pc_name: String
var public_ip: String
var local_ip: String
var original_public_ip: String
var active_net_card: int
var last_reboot: String

#var ports: Dictionary
var all_ports: Array[Port]
# TODO: Visualize
var services: Array
# TODO: Visualize
var person: Array[Person]
# TODO: Visualize
var saved_networks: Array[Network]

# -------------------------------------
# Router Only
# -------------------------------------
var is_home_network: bool
var router_password: String
# TODO: Visualize
var reverse_shells: Dictionary
# TODO: Visualize
var network_lan: Dictionary

# -------------------------------------
# Dev use
# -------------------------------------
var raw_data: Dictionary
var person_raw_data: Array

static func from_dict(data: Dictionary) -> ConfigOS:
	var config_os = ConfigOS.new()
	
	config_os.raw_data = data
	config_os.person_raw_data = data.get("personas", [])
	
	config_os.is_rented = data.get("isRented", false)
	config_os.saved = data.get("saved", false)
	config_os.override_settings = data.get("overrideSettings", false)
	config_os.override_used = data.get("overrideUsed", false)

	config_os.pc_name = data.get("pcName", "")
	config_os.public_ip = data.get("ipPublica", "")
	config_os.local_ip = data.get("ipLocal", "")
	config_os.original_public_ip = data.get("origIpPublica", "")
	config_os.active_net_card = data.get("activeNetCard", 0)
	config_os.last_reboot = data.get("lastReboot", "")

	var ports: Array = Dictionary(data.get("puertos", {})).get("allPorts", [])
	for port in ports:
		config_os.all_ports.append(Port.from_dict(port))
	var servicios: Array = data.get("servicios", [])
	for service in servicios:
		config_os.services.append(Service.from_dict(service))
	var personas: Array = data.get("personas", [])
	for persona in personas:
		config_os.person.append(Person.from_dict(persona))
	var savedNetworks: Array = data.get("savedNetworks", [])
	for network in savedNetworks:
		config_os.saved_networks.append(Network.from_dict(network))
	
	config_os.is_home_network = data.get("isHomeNetwork", false)
	config_os.router_password = data.get("routerPassword", "")
	var reverseShells = data.get("reverseShells", {})
	for net_id in reverseShells:
		config_os.reverse_shells[net_id] = ReverseShell.from_dict(reverseShells[net_id])
	var networkLan = data.get("networkLan", {})
	if networkLan != null:
		config_os.network_lan = networkLan

	return config_os
