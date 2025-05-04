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
	mail_account.account = data["address"]
	mail_account.password = data["plainPassword"]
	mail_account.encrypted_password = data["encPassword"]
	mail_account.blacklist = data["blacklist"]
	mail_account.spam_filter = data["spamFilter"]
	mail_account.emails = [] as Array[Email]
	for email in data["emails"]:
		mail_account.emails.append(Email.from_dict(email))
	return mail_account
