class_name MailAccount extends Resource

var account: String
var password: String
var encrypted_password: String
var blacklist: Array
var spam_filter: int
var player_pc_id: String
var emails: Array[Email]

static func from_dict(data: Dictionary) -> MailAccount:
	var mail_account = MailAccount.new()
	mail_account.account = data.get("address", "")
	var plain_password = data.get("plainPassword", "")
	if plain_password != null:
		mail_account.password = plain_password
	var enc_password = data.get("encPassword", "")
	if enc_password != null:
		mail_account.encrypted_password = enc_password
	mail_account.blacklist = data.get("blacklist", [])
	mail_account.spam_filter = data.get("spamFilter", 0)
	mail_account.emails = [] as Array[Email]
	for email in data.get("emails", []):
		mail_account.emails.append(Email.from_dict(email))
	return mail_account
