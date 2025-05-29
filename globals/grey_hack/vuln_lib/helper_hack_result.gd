class_name HelperHackResult extends Resource

# 表示一次渗透尝试的模拟结果
var hack_result: HackResultType.Type
var random_path: String
var path_exist: String
var user: String
var num_register_users: int
var num_port_forward: int
var num_conn_gateway: int

# Exploit - data
var part_selected: PartSelected
## For decipher, is the script allow user to select victim rather than decipher all credentials?
var is_specified_user: bool

static func from_dict(dict: Dictionary) -> HelperHackResult:
	var h = HelperHackResult.new()
	h.hack_result = dict.get("hackResult", HackResultType.Type.SHELL)
	h.random_path = dict.get("randomPath", "")
	h.path_exist = dict.get("pathExist", "")
	h.user = dict.get("user", "")
	h.num_register_users = dict.get("numRegisterUsers", 0)
	h.num_port_forward = dict.get("numPortForward", 0)
	h.num_conn_gateway = dict.get("numConnGateway", 0)
	return h

func to_dict() -> Dictionary:
	var dict = {}
	dict["hackResult"] = hack_result
	dict["randomPath"] = random_path
	dict["pathExist"] = path_exist
	dict["user"] = user
	dict["numRegisterUsers"] = num_register_users
	dict["numPortForward"] = num_port_forward
	dict["numConnGateway"] = num_conn_gateway
	dict["partSelected"] = part_selected
	dict["isSpecifiedUser"] = is_specified_user
	return dict

enum PartSelected {
	FOLDER_CONTENTS,
	FOLDER_ETC_PASSWD,
	FOLDER_MAIL_PASSWD,
	COMPUTER_DECIPHER_BANK,
	COMPUTER_DECIPHER_MAIL,
	COMPUTER_DECIPHER_PASSWD
}
