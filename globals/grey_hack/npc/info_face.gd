class_name InfoFace extends Resource

var variants: PackedStringArray
var info_face: Array[FacePart]

static func from_dict(data: Dictionary) -> InfoFace:
	var i_f = InfoFace.new()
	i_f.variants = data.get("variantes", [])
	var infoFace = data.get("infoFace", [])
	for info in infoFace:
		i_f.info_face.append(FacePart.from_dict(info))
	return i_f
