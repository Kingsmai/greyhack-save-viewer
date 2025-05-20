## Used by saved_networks in ConfigOS
class_name Network extends Resource

var bssid: String
var essid: String
var password: String
var public_ip: String

static func from_dict(data: Dictionary) -> Network:
	var network = Network.new()
	network.bssid = data.get("bssid", "")
	network.essid = data.get("essid", "")
	network.password = data.get("password", "")
	network.public_ip = data.get("publicIp", "")
	return network
