## Abandoned
extends Window

@onready var start_proxy_button: Button = %StartProxyButton
@onready var stop_proxy_button: Button = %StopProxyButton
@onready var log_rich_text_label: RichTextLabel = %LogRichTextLabel

const LISTEN_IP = "0.0.0.0"
const LISTEN_PORT = 12345
const TARGET_IP = "8.8.8.8"
const TARGET_PORT = 12345

var listener: TCPServer = TCPServer.new()
var srv: StreamPeerTCP = StreamPeerTCP.new()
var client_to_server: ConnectionPeer
var server_to_client: ConnectionPeer
var proxy_running := false

func _ready():
	stop_proxy_button.disabled = true
	start_proxy_button.pressed.connect(_start_proxy)
	stop_proxy_button.pressed.connect(_stop_proxy)
	client_to_server = ConnectionPeer.new()
	client_to_server.is_outgoing = true
	client_to_server.data_forwarded.connect(_on_client_to_server_data_forwarded)
	server_to_client = ConnectionPeer.new()
	server_to_client.data_forwarded.connect(_on_server_to_client_data_forwarded)
	self.add_child(client_to_server)
	self.add_child(server_to_client)
	self.set_process(false)
	self.hide()

func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		hide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("server_listener"):
		visible = !visible

func _start_proxy():
	if proxy_running:
		_log("⚠️ Listener is already running")
		return
	proxy_running = true
	var listener_err = listener.listen(LISTEN_PORT, LISTEN_IP)
	if listener_err == OK:
		_log("✅ Listener is running, listening %s:%d" % [LISTEN_IP, listener.get_local_port()])
	else:
		_log("❌ Listener cannot start, aborting. error code: %d, %s" % [listener_err, error_string(listener_err)])
	var server_err = srv.connect_to_host(TARGET_IP, TARGET_PORT)
	if server_err == OK:
		_log("✅ Server is running, proxy to %s:%d" % [srv.get_connected_host(), srv.get_connected_port()])
		client_to_server.destination = srv
		server_to_client.source = srv
	else:
		_log("❌ Server cannot start, aborting. error code: %d, %s" % [server_err, error_string(server_err)])
		listener.stop()
		listener = null
		_log("🛑 Listener is stopped")
	start_proxy_button.disabled = true
	stop_proxy_button.disabled = false
	self.set_process(true)

func _stop_proxy():
	proxy_running = false
	listener.stop()
	_log("🛑 Listener is stopped")
	start_proxy_button.disabled = false
	stop_proxy_button.disabled = true
	self.set_process(false)

func _on_client_to_server_data_forwarded(data: PackedByteArray, plain: String):
	_log("➡️ Client to server: %s\n%s" % [str(data), plain])
	pass

func _on_server_to_client_data_forwarded(data: PackedByteArray, plain: String):
	_log("⬅️ Server to client: %s\n%s" % [str(data), plain])
	pass

func _process(delta: float) -> void:
	if listener.is_listening():
		var cli = listener.take_connection()
		if cli:
			_log("Client connected")
			client_to_server.source = cli
			client_to_server.set_process(true)
			server_to_client.destination = cli
			server_to_client.set_process(true)

func _log(msg: String):
	var time = Time.get_time_string_from_system()
	var entry = "[%s] %s" % [time, msg]
	print(entry)
	self.call_deferred("_append_log_text", entry)

func _append_log_text(entry: String):
	log_rich_text_label.append_text(entry + "\n")

class ConnectionPeer extends Node:
	signal source_disconnected
	signal destination_disconnected
	signal data_forwarded(data: PackedByteArray, plain: String)
	
	var is_outgoing: bool = false
	var source: StreamPeerTCP
	var destination: StreamPeerTCP
	
	func _ready() -> void:
		set_process(false)
	
	func _process(delta: float) -> void:
		if source != null:
			if source.get_status() == StreamPeerTCP.STATUS_NONE:
				source_disconnected.emit()
				source = null
				return
		if destination != null:
			if destination.get_status() == StreamPeerTCP.STATUS_NONE:
				destination_disconnected.emit()
				destination = null
				return
		if source != null:
			if source.get_available_bytes() > 0:
				var bytes: Array = source.get_data(source.get_available_bytes())
				var byte_data: PackedByteArray = bytes[1]
				data_forwarded.emit(byte_data, byte_data.get_string_from_utf8())
				destination.put_data(byte_data)
