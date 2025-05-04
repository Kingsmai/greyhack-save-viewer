class_name HackResultType extends RefCounted

enum Type {
	SHELL,
	RANDOM_FOLDER,
	CHANGE_PASS,
	COMPUTER,
	FIREWALL_DISABLE,
	OVERRIDE_SETTINGS,
	TRAFFIC_LIGHT_CONTROL
}

static func translate(type: Type) -> String:
	var rs = ""
	match type:
		Type.SHELL: rs = "Shell"
		Type.RANDOM_FOLDER: rs = "Random Folder"
		Type.CHANGE_PASS: rs = "Change Password"
		Type.COMPUTER: rs = "Computer"
		Type.FIREWALL_DISABLE: rs = "Firewall Disable"
		Type.OVERRIDE_SETTINGS: rs = "Override Settings"
		Type.TRAFFIC_LIGHT_CONTROL: rs = "Traffic Light Control"
		_: rs = "Unknown"
	return rs
