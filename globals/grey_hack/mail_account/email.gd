class_name Email extends Resource

var id: String
var is_unread: bool
var other_mail: String
var id_mission: String
var is_protected: bool
var messages: Array[Message]

static func from_dict(data: Dictionary) -> Email:
	var email = Email.new()
	email.id = data["ID"]
	email.is_unread = data["isUnread"]
	email.other_mail = data["otherMail"]
	email.id_mission = data["idMission"]
	email.is_protected = data["isProtected"]
	email.messages = [] as Array[Message]
	for message in data["messages"]:
		email.messages.append(Message.from_dict(message))
	return email
