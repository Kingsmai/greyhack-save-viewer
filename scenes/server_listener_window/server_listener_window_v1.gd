## Abandoned
extends Window

@onready var start_proxy_button: Button = %StartProxyButton
@onready var stop_proxy_button: Button = %StopProxyButton
@onready var log_rich_text_label: RichTextLabel = %LogRichTextLabel

const LISTEN_IP = "0.0.0.0"
const LISTEN_PORT = 12345
const TARGET_IP = "8.8.8.8"
const TARGET_PORT = 12345

var listener: TCPServer
var accept_thread: Thread
var proxy_threads: Array = []
var proxy_running := false

func _ready():
	stop_proxy_button.disabled = true
	start_proxy_button.pressed.connect(_start_proxy)
	stop_proxy_button.pressed.connect(_stop_proxy)
	#hide()

func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		hide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("server_listener"):
		visible = !visible

func _start_proxy():
	if proxy_running:
		_log("⚠️ 代理已运行中")
		return

	listener = TCPServer.new()
	var err = listener.listen(LISTEN_PORT, LISTEN_IP)
	if err != OK:
		_log("❌ 无法绑定端口：%s:%d" % [LISTEN_IP, LISTEN_PORT])
		return

	proxy_running = true
	accept_thread = Thread.new()
	accept_thread.start(Callable(self, "_accept_clients"))
	_log("✅ 代理已启动，监听 %s:%d" % [LISTEN_IP, LISTEN_PORT])
	start_proxy_button.disabled = true
	stop_proxy_button.disabled = false

func _stop_proxy():
	proxy_running = false
	
	# 停止接受新连接
	if accept_thread and accept_thread.is_alive():
		accept_thread.wait_to_finish()
	
	# 停止所有转发线程
	for t in proxy_threads:
		if t and t.is_alive():
			t.wait_to_finish()
	proxy_threads.clear()
	
	# 关闭监听器
	if listener:
		listener.stop()
		listener = null
	
	_log("🛑 代理已停止")
	start_proxy_button.disabled = false
	stop_proxy_button.disabled = true

func _accept_clients(_user_data = null):
	while proxy_running:
		if listener and listener.is_connection_available():
			var client = listener.take_connection()
			call_deferred("_log_thread_safe", "📥 新连接已接入")
			var t := Thread.new()
			t.start(Callable(self, "_handle_proxy_connection").bind(client))
			proxy_threads.append(t)
		OS.delay_msec(50)

func _handle_proxy_connection(client: StreamPeerTCP):
	# 连接目标服务器
	var target := StreamPeerTCP.new()
	var connect_err = target.connect_to_host(TARGET_IP, TARGET_PORT)
	if connect_err != OK:
		call_deferred("_log_thread_safe", "❌ 无法连接目标服务器: %s:%d (错误码: %d)" % [TARGET_IP, TARGET_PORT, connect_err])
		client.disconnect_from_host()
		return
	
	call_deferred("_log_thread_safe", "✅ 成功连接到目标服务器")
	
	# 启动双向转发线程
	var client_to_server = Thread.new()
	var server_to_client = Thread.new()
	
	client_to_server.start(Callable(self, "_proxy_data").bind(client, target, "CLIENT → SERVER"))
	server_to_client.start(Callable(self, "_proxy_data").bind(target, client, "SERVER → CLIENT"))
	
	# 存储线程引用
	proxy_threads.append(client_to_server)
	proxy_threads.append(server_to_client)

func _proxy_data(src: StreamPeerTCP, dst: StreamPeerTCP, direction: String):
	var buffer := PackedByteArray()
	
	while proxy_running and src.get_status() == StreamPeerTCP.STATUS_CONNECTED:
		var available = src.get_available_bytes()
		if available > 0:
			var data = src.get_data(available)[1]
			buffer.append_array(data)
			
			# 直接转发原始字节，不进行任何解码
			var err = dst.put_data(data)
			if err != OK:
				call_deferred("_log_thread_safe", "❌ 转发失败: %s" % direction)
				break
			
			# 记录原始HEX（可选调试）
			call_deferred("_log_thread_safe", "[%s] 转发 %d 字节: %s..." % [direction, data.size(), data.hex_encode().substr(0, 20)])
		else:
			OS.delay_msec(10)
	
	# 关闭连接
	#call_deferred("_log_thread_safe", "🔌 [%s] 连接关闭" % direction)
	#src.disconnect_from_host()
	#dst.disconnect_from_host()

func _log(msg: String):
	var time = Time.get_time_string_from_system()
	var entry = "[%s] %s" % [time, msg]
	print(entry)
	call_deferred("_append_log_text", entry)

func _log_thread_safe(msg: String):
	var time = Time.get_time_string_from_system()
	var entry = "[%s] %s" % [time, msg]
	print(entry)
	log_rich_text_label.call_deferred("append_text", entry + "\n")

func _append_log_text(entry: String):
	log_rich_text_label.append_text(entry + "\n")
