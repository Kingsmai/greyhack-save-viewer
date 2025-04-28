extends Node

var db: SQLite
var db_ext: String = "db"
var db_path: String = "":
	set(value):
		if value.ends_with(".sqlite") or value.ends_with(".db"):
			db_ext = value.get_extension()
			db_path = value
		else:
			db_path = value + "." + db_ext

var verbosity_level: int = SQLite.VerbosityLevel.NORMAL
var read_only: bool = false
var foreign_keys_enabled: bool = false

func _init():
	db = SQLite.new()

func connect_db(path: String, read_only_mode := false) -> bool:
	db_path = path
	read_only = read_only_mode
	db.path = db_path
	db.read_only = read_only
	db.verbosity_level = verbosity_level
	db.foreign_keys = foreign_keys_enabled
	var success = db.open_db()
	if not success:
		printerr("[SQLite] Failed to open database at %s: %s" % [db_path, db.error_message])
	return success

func close_db():
	db.close_db()

func create_table(table_name: String, schema: Dictionary) -> bool:
	var result = db.create_table(table_name, schema)
	if not result:
		printerr("[SQLite] Failed to create table: %s" % db.error_message)
	return result

func drop_table(table_name: String) -> bool:
	return db.drop_table(table_name)

func insert_row(table_name: String, row_data: Dictionary) -> bool:
	var result = db.insert_row(table_name, row_data)
	if not result:
		printerr("[SQLite] Insert failed: %s" % db.error_message)
	return result

func insert_rows(table_name: String, rows: Array) -> bool:
	var result = db.insert_rows(table_name, rows)
	if not result:
		printerr("[SQLite] Bulk insert failed: %s" % db.error_message)
	return result

func update_rows(table_name: String, conditions: String, new_data: Dictionary) -> bool:
	var result = db.update_rows(table_name, conditions, new_data)
	if not result:
		printerr("[SQLite] Update failed: %s" % db.error_message)
	return result

func delete_rows(table_name: String, conditions: String) -> bool:
	var result = db.delete_rows(table_name, conditions)
	if not result:
		printerr("[SQLite] Delete failed: %s" % db.error_message)
	return result

func select_rows(table_name: String, conditions: String, columns: Array) -> Array:
	db.select_rows(table_name, conditions, columns)
	if db.query_result.is_empty() and db.error_message != "":
		printerr("[SQLite] Select failed: %s" % db.error_message)
	return Utils.preprocess_query_result(db.query_result)

func run_query(query_string: String) -> bool:
	var result = db.query(query_string)
	if not result:
		printerr("[SQLite] Raw query failed: %s" % db.error_message)
	return result

func run_query_with_bindings(query_string: String, params: Array) -> bool:
	var result = db.query_with_bindings(query_string, params)
	if not result:
		printerr("[SQLite] Bound query failed: %s" % db.error_message)
	return result

func export_to_json(json_path: String) -> bool:
	return db.export_to_json(json_path)

func import_from_json(json_path: String) -> bool:
	return db.import_from_json(json_path)

func backup(path: String) -> bool:
	return db.backup_to(path)

func restore(path: String) -> bool:
	return db.restore_from(path)

func get_last_insert_id() -> int:
	return db.last_insert_rowid
