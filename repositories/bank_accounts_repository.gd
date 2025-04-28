extends Node

func get_bank_account_list() -> Array[Dictionary]:
	var result = SaveData.select_rows("BankAccounts", "", [
		"Transactions", "User", "Password"
	])
	return Utils.preprocess_query_result(result)
