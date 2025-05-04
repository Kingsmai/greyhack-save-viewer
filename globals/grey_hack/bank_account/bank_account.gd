class_name BankAccount extends Resource

var account: String
var password: String
var origin_bank_domain: String
var origin_bank_ip: String
var money: int
var is_player: bool
var transactions: Array[Transaction]

static func from_dict(data: Dictionary) -> BankAccount:
	var bank_account = BankAccount.new()
	bank_account.account = data["account"]
	bank_account.password = data["password"]
	bank_account.origin_bank_domain = data["origBankDomain"]
	bank_account.origin_bank_ip = data["origBankAddress"]
	bank_account.money = data["dinero"]
	bank_account.is_player = data["isPlayer"]
	bank_account.transactions = [] as Array[Transaction]
	for transaction in data["transacciones"]:
		bank_account.transactions.append(Transaction.from_dict(transaction))
	return bank_account
