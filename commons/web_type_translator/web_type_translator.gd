class_name WebTypeTranslator extends Node

static func type_translator(type: int) -> String:
	match type:
		0: return "Unknown"
		1: return "Police Station"
		2: return "Universities"
		3: return "Supermarkets"
		4: return "Fast Food"
		5: return "Workshop"
		6: return "Mobile Shop"
		7: return "Hospitals"
		8: return "Banks"
		9: return "Individuals"
		10: return "Mail Services"
		11: return "Hack Shop"
		12: return "Computer Store"
		13: return "Rent Server"
		14: return "Net Services"
		15: return "Hardware Manufacturer"
		16: return "Neurobox"
		17: return "Tutorial"
		18: return "Currency Creation"
		19: return "CTF"
		_: return str(type)

static func type_to_texture(type: int) -> Texture2D:
	match type:
		1: return preload("res://assets/ip_icons/police.svg")
		2: return preload("res://assets/ip_icons/university.svg")
		3: return preload("res://assets/ip_icons/shop.svg")
		4: return preload("res://assets/ip_icons/fast_food.svg")
		5: return preload("res://assets/ip_icons/car_work.svg")
		6: return preload("res://assets/ip_icons/phone.svg")
		7: return preload("res://assets/ip_icons/hospital.svg")
		8: return preload("res://assets/ip_icons/bank.svg")
		9: return preload("res://assets/ip_icons/blog.svg")
		10: return preload("res://assets/ip_icons/email.svg")
		11: return preload("res://assets/ip_icons/hack.svg")
		12: return preload("res://assets/ip_icons/eshop.svg")
		13: return preload("res://assets/ip_icons/server.svg")
		14: return preload("res://assets/ip_icons/isp.svg")
		15: return preload("res://assets/ip_icons/electronic.svg")
		16: return preload("res://assets/ip_icons/target.svg")
		17: return preload("res://assets/ip_icons/tutorial.svg")
		18: return preload("res://assets/ip_icons/crypto.svg")
		19: return preload("res://assets/ip_icons/ctf.svg")
		_: return null
