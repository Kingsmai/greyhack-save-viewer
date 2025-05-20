class_name Person extends Resource

var npc_info: NpcInfo
var user_mail: MailAccount
var user_bank: UserBank
var current_traces: Array

static func from_dict(data: Dictionary) -> Person:
	var person = Person.new()
	person.npc_info = NpcInfo.from_dict(data.get("npcInfo", {}))
	person.user_mail = MailAccount.from_dict(data.get("userMail", {}))
	person.user_bank = UserBank.from_dict(data.get("userBank", {}))
	person.current_traces = data.get("currentTraces")
	return person
