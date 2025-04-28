extends Node

var db_ext: String = "db"
var db_path: String = "res://data/GreyHackDB-20240918":
	set(value):
		if value.ends_with(".sqlite") or value.ends_with(".db"):
			#db_ext = db_path.get_extension()
			db_ext = ""
			db_path = value
		else:
			db_path = value
var verbosity_level: int = SQLite.VerbosityLevel.QUIET
var read_only: bool = false
var foreign_keys_enabled: bool = false

func get_connection() -> SQLite:
	var connection := SQLite.new()
	connection.verbosity_level = self.verbosity_level
	connection.read_only = self.read_only
	connection.foreign_keys = self.foreign_keys_enabled
	connection.path = self.db_path
	connection.default_extension = self.db_ext
	connection.open_db()
	return connection

func select_rows(table_name: String, conditions: String, columns: Array) -> Array:
	var connection := self.get_connection()
	var result := connection.select_rows(table_name, conditions, columns)
	if connection.query_result.is_empty() and connection.error_message != "not an error":
		print(connection.path)
		printerr("[SQLite] Select failed: %s" % connection.error_message)
	connection.close_db()
	return Utils.preprocess_query_result(result)
