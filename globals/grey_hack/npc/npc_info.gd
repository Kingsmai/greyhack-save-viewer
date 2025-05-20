class_name NpcInfo extends Resource

var raw_data: Dictionary

var id: String
var name: String
var surname: String
var fullname: String:
	get:
		return name + " " + surname
## 0 = Male, 1 = Female
var gender: int
var age: int

## TODO
var info_face: InfoFace

## TODO
var schedule: Dictionary

var phone_number: int
var user_mail: String

## TODO: Some enum, haven't figure out
var inteligencia: int
## TODO: Some enum, haven't figure out
var exp_pcs: int

var license_plate: String

var dead_time: String

var hire_time: String
var work_performance: int
## TODO: Enum
var job_role: int
var is_fired: bool
var wake_up_time: String
var late_strikes: int
var day_alarm: int
# TODO
var alarm_config
## Enum??
var company_align: int
var has_rumor: bool
var local_ip: String
var zero_day_contact: String
# TODO
var forced_pass
var original_bank_domain: String
var original_bank_address: String
var email_password: String

static func from_dict(data: Dictionary) -> NpcInfo:
	var npc = NpcInfo.new()
	
	npc.raw_data = data
	
	npc.id = data.get("ID", "")
	npc.name = data.get("name", "")
	npc.surname = data.get("surname", "")
	npc.gender = data.get("gender", 0)
	npc.age = data.get("age", 0)
	npc.info_face = InfoFace.from_dict(data.get("infoFace", {}))
	npc.schedule = data.get("schedule", {})
	npc.phone_number = data.get("phoneNumber", 0)
	npc.user_mail = data.get("userMail", "")
	npc.inteligencia = data.get("inteligencia", 0)
	npc.exp_pcs = data.get("expPcs", 0)
	npc.license_plate = data.get("licensePlate", "")
	var deadTime = data.get("deadTime", "")
	if deadTime != null:
		npc.dead_time = deadTime
	npc.hire_time = data.get("hireTime", "")
	npc.work_performance = data.get("workPerformance", 0)
	npc.job_role = data.get("jobRole", 0)
	npc.is_fired = data.get("isFired", false)
	var wakeUpTime = data.get("wakeUpTime", "")
	if wakeUpTime != null:
		npc.wake_up_time = wakeUpTime
	npc.late_strikes = data.get("lateStrikes", 0)
	npc.day_alarm = data.get("dayAlarm", 0)
	npc.alarm_config = data.get("alarmConfig", {})
	npc.company_align = data.get("companyAlign", 0)
	npc.has_rumor = data.get("hasRumor", false)
	npc.local_ip = data.get("localIP", "")
	npc.zero_day_contact = data.get("zeroDayContact", "")
	npc.forced_pass = data.get("forcedPass", "")
	npc.original_bank_domain = data.get("origBankDomain", "")
	npc.original_bank_address = data.get("origBankAddress", "")
	npc.email_password = data.get("emailPass", "")
	return npc
