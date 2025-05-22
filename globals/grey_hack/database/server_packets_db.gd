class_name ServerPacketsDB extends RefCounted

static func insert_packet(packet: Dictionary, is_send: bool = false) -> void:
	var packed_dict = packet.duplicate()
	var packet_name = ""
	if is_send:
		packet_name = ClientRpcType.IdClient.keys()[packed_dict["ID"]].to_snake_case()
	else:
		packet_name = ServerRpcType.IdServer.keys()[packed_dict["ID"]].to_snake_case()
	packed_dict["isSend"] = 1 if is_send else 0
	packed_dict["packetName"] = packet_name
	packed_dict["decodedByteValues"] = []
	if packed_dict.has("byteValues"):
		for byte in packed_dict["byteValues"]:
			if byte != null and byte != "":
				var decoded = Utils.decode_base64_gzip(byte)
				if decoded != null:
					packed_dict["decodedByteValues"].append(decoded)
				else:
					packed_dict["decodedByteValues"].append(byte)
	for key in packed_dict:
		packed_dict[key] = JSON.stringify(packed_dict[key], "", false)
	SaveData.insert_row(SaveData.SERVER_PACKETS_TABLE, packed_dict, true)
