class_name FacePart extends Resource

var part_name: String
var part_scale: Vector2
var part_position: Vector2

static func from_dict(data: Dictionary) -> FacePart:
	var face_part = FacePart.new()
	face_part.part_name = data.get("nombre", "")
	var escala: Dictionary = data.get("escala", {})
	face_part.part_scale = Vector2(
		escala.get("x", 0),
		escala.get("y", 0)
	)
	var posicion: Dictionary = data.get("posicion", {})
	face_part.part_position = Vector2(
		posicion.get("x", 0),
		posicion.get("y", 0)
	)
	return face_part
