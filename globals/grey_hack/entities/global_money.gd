class_name GlobalMoney extends Resource

var money: int = 0
var last_money: int = 0
var last_year_withdraw: int = 0

static func from_dict(dict: Dictionary) -> GlobalMoney:
	var global_money = GlobalMoney.new()
	global_money.money = dict["money"]
	global_money.last_money = dict["lastMoney"]
	global_money.last_year_withdraw = dict["lastYearWithdraw"]
	return global_money
