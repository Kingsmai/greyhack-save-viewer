extends Node

const ONLINE_DB_PATH = "user://GreyHackDB_Online.db"

const BANK_ACCOUNT_TABLE = "BankAccount"
const COINS_TABLE = "Coins"
const COMPUTER_TABLE = "Computer"
const CTFS_TABLE = "CTFs"
const FILES_TABLE = "Files"
const INFOGEN_TABLE = "InfoGen"
const LOGS_TABLE = "Logs"
const MAIL_ACCOUNT_TABLE = "MailAccount"
const MAP_TABLE = "Map"
const PASSWORDS_TABLE = "Passwords"
const PLAYER_CONNS_TABLE = "PlayerConns"
const PLAYERS_TABLE = "Players"
const SHARED_CONNS_TABLE = "SharedConns"
const STOCKS_TABLE = "Stocks"
const WALLETS_TABLE = "Wallets"
const WEB_PAGES_TABLE = "WebPages"
const SERVER_PACKETS_TABLE = "ServerPackets"

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

func get_online_connection() -> SQLite:
	var connection := SQLite.new()
	connection.verbosity_level = self.verbosity_level
	connection.read_only = self.read_only
	connection.foreign_keys = self.foreign_keys_enabled
	connection.path = ONLINE_DB_PATH
	connection.default_extension = ""
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

func insert_row(table_name: String, values: Dictionary, is_online: bool = false) -> void:
	var connection: SQLite 
	if is_online:
		connection = self.get_online_connection()
	else:
		connection = self.get_connection()
	connection.insert_row(table_name, values)
	if connection.query_result.is_empty() and connection.error_message != "not an error":
		print(connection.path)
		printerr("[SQLite] Insert failed: %s" % connection.error_message)
	connection.close_db()

func create_online_db():
	var conn := SQLite.new()
	conn.verbosity_level = self.verbosity_level
	conn.read_only = self.read_only
	conn.foreign_keys = self.foreign_keys_enabled
	conn.path = ONLINE_DB_PATH
	conn.default_extension = self.db_ext
	conn.open_db()
	# Create tables
	var server_packets_table_dict = {
		"isSend": {"data_type": "int"}, # 0 = receive, 1 = send
		"ID": {"data_type": "int"},
		"packetName": {"data_type": "text"},
		"strValues": {"data_type": "text"},
		"intValues": {"data_type": "int"},
		"intArrayValues": {"data_type": "text"},
		"ulongValues": {"data_type": "text"},
		"longValues": {"data_type": "text"},
		"boolValues": {"data_type": "text"},
		"byteValues": {"data_type": "text"},
		"decodedByteValues": {"data_type": "text"},
		"floatValues": {"data_type": "text"},
		"rolesValues": {"data_type": "text"},
		"typeWebValues": {"data_type": "text"},
		"serviceValues": {"data_type": "text"},
		"vectorValues": {"data_type": "text"},
		"mailValues": {"data_type": "text"},
		"logValues": {"data_type": "text"}
	}
	conn.create_table(SERVER_PACKETS_TABLE, server_packets_table_dict)
	conn.close_db()
	return ONLINE_DB_PATH
