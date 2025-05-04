class_name BankAccountsDB extends RefCounted

static func get_bank_accounts() -> Array[BankAccount]:
	var result: Array[BankAccount] = []
	var query_result = SaveData.select_rows("BankAccounts", "", ["Transactions"])
	for row in query_result:
		result.append(BankAccount.from_dict(row["Transactions"]))
	return result
