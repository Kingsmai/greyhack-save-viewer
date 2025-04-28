extends Node

func get_mail_account_list() -> Array[Dictionary]:
	var result = SaveData.select_rows("MailAccounts", "", [
		"Mails", "User", "Password"
	])
	return Utils.preprocess_query_result(result)
