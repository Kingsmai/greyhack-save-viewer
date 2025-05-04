class_name Transaction extends Resource

var account: String
var amount: int
var reason: String
var date: String
var is_success: bool

static func from_dict(data: Dictionary) -> Transaction:
	var transaction = Transaction.new()
	transaction.account = data["cuenta"]
	transaction.amount = data["cantidad"]
	transaction.reason = data["motivo"]
	transaction.date = data["fecha"]
	transaction.is_success = data["success"]
	return transaction
