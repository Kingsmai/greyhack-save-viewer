extends Window

# Server Address
const TARGET_IP = "85.215.109.98"
const TARGET_PORT = 21200

# Address Listening Port
const LISTEN_IP = "0.0.0.0"
const LISTEN_PORT = 21200

var listener: TCPServer

@onready var start_proxy_button: Button = %StartProxyButton
@onready var stop_proxy_button: Button = %StopProxyButton
@onready var log_rich_text_label: RichTextLabel = %LogRichTextLabel

func _ready() -> void:
	set_process(false)
	self.hide()
	start_proxy_button.pressed.connect(func(): start_proxy())
	stop_proxy_button.pressed.connect(func(): stop_proxy())

func _notification(what: int) -> void:
	match what:
		NOTIFICATION_WM_CLOSE_REQUEST:
			self.hide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("server_listener"):
		if self.visible:
			self.hide()
		else:
			self.show()

func start_proxy():
	var listener := TCPServer.new()
	listener.listen(LISTEN_PORT, LISTEN_IP)
	log_rich_text_label.append_text("Proxy listening on %s:%d\n" % [LISTEN_IP, LISTEN_PORT])
	set_process(true)
	self.listener = listener

func stop_proxy():
	listener.stop()
	log_rich_text_label.append_text("Proxy stopped\n")
	set_process(false)

func _process(_delta: float) -> void:
	if listener.is_connection_available():
		var client := listener.take_connection()
		log_rich_text_label.append_text("Accepted connection from client\n")
		var server = StreamPeerTCP.new()
		var err := server.connect_to_host(TARGET_IP, TARGET_PORT)
		if err != OK:
			log_rich_text_label.append_text("Failed to connect to target server\n")
			client.disconnect_from_host()
			return
		log_rich_text_label.append_text("Connected to target server\n")
		
		var pair := ConnectionPair.new()
		pair.setup(client, server)
		add_child(pair) # Let it process independently

# --------------------------
# 转发连接类（双向）
class ConnectionPair:
	extends Node

	var client: StreamPeerTCP
	var server: StreamPeerTCP
	var client_buffer := PackedByteArray()
	var server_buffer := PackedByteArray()

	func setup(c: StreamPeerTCP, s: StreamPeerTCP):
		client = c
		server = s
		set_process(true)

	func _process(_delta):
		if client.get_status() != StreamPeerTCP.STATUS_CONNECTED \
		or server.get_status() != StreamPeerTCP.STATUS_CONNECTED:
			print("Connection closed")
			client.disconnect_from_host()
			server.disconnect_from_host()
			queue_free()
			return

		_forward_data(client, server, "CLIENT->SERVER")
		_forward_data(server, client, "SERVER->CLIENT")

	func _forward_data(from_peer: StreamPeerTCP, to_peer: StreamPeerTCP, label: String):
		while from_peer.get_available_bytes() > 0:
			var data := from_peer.get_data(from_peer.get_available_bytes())
			if data.size() == 0:
				return
			to_peer.put_data(data)
			to_peer.flush()
