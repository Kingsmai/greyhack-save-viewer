class_name MailAccountsDB extends RefCounted

static func get_mail_accounts() -> Array[MailAccount]:
	var result: Array[MailAccount] = []
	var query_result = SaveData.select_rows("MailAccounts", "", ["Mails"])
	for row in query_result:
		result.append(MailAccount.from_dict(row["Mails"]))
	return result
