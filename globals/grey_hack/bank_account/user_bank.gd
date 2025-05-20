class_name UserBank extends Resource

var user_name: String
var password: String
var encrypted_password: String

static func from_dict(data: Dictionary) -> UserBank:
	var user_bank = UserBank.new()
	user_bank.user_name = data.get("userName", "")
	var pw = data.get("pw", "")
	if pw != null:
		user_bank.password = pw
	var enc_password = data.get("encPassword", "")
	if enc_password != null:
		user_bank.encrypted_password = enc_password
	return user_bank
