class_name HelperHackResult extends Resource

# 表示一次渗透尝试的模拟结果
var hack_result: int
var random_path: String
var path_exist: String
var user: String
var num_register_users: int
var num_port_forward: int
var num_conn_gateway: int

static func from_dict(dict: Dictionary) -> HelperHackResult:
	var h = HelperHackResult.new()
	h.hack_result = dict.get("hackResult", 0)
	h.random_path = dict.get("randomPath", "")
	h.path_exist = dict.get("pathExist", "")
	h.user = dict.get("user", "")
	h.num_register_users = dict.get("numRegisterUsers", 0)
	h.num_port_forward = dict.get("numPortForward", 0)
	h.num_conn_gateway = dict.get("numConnGateway", 0)
	return h