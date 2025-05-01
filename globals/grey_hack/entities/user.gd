class_name User extends Resource

var username: String = ""
var groups: Array[String] = []
var password: String = ""
var plain_password: String = ""
var is_deletable: bool = false
var total_exp: int = 0
var karma: Karma = Karma.new()

class Karma:
	var karma_points: int = 0
	var previous_karma: Array[float] = []
	var pending_mission: int = 0

static func from_json(data: Dictionary) -> User:
	var user := User.new()
	user.username = data.get("nombreUsuario", "")
	var grps = Array(data.get("grupos", [])).duplicate() as Array[String]
	for group in grps:
		user.groups.append(group) 
	user.password = data.get("password", "")
	user.plain_password = data.get("passPlano", "")
	user.is_deletable = data.get("isDeletable", false)
	user.total_exp = data.get("totalExp", 0)

	var karma_data = data.get("karma", {})
	var k := Karma.new()
	k.karma_points = karma_data.get("karma", 0)
	var prevKarmas = Array(karma_data.get("prevKarma", [])).duplicate() as Array[int]
	for prevKarma in prevKarmas:
		k.previous_karma.append(prevKarma)
	k.pending_mission = karma_data.get("pendingMission", 0)

	user.karma = k
	return user

static func load_users_from_json_array(data: Array) -> Array[User]:
	var users: Array[User] = []
	for d in data:
		var new_user = from_json(d)
		users.append(new_user)
	return users
