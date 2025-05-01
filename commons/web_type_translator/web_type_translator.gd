class_name WebTypeTranslator extends Node

enum Type {
	Unknown,
	PoliceStation,
	Universities,
	Supermarkets,
	FastFood,
	Workshop,
	MobileShop,
	Hospitals,
	Banks,
	Individuals,
	MailServices,
	HackShop,
	ComputerStore,
	RentServer,
	NetServices,
	HardwareManufacturer,
	Neurobox,
	Tutorial,
	CurrencyCreation,
	CTF
}

static func type_translator(type: Type) -> String:
	match type:
		Type.Unknown				: return "Unknown"
		Type.PoliceStation			: return "Police Station"
		Type.Universities			: return "Universities"
		Type.Supermarkets			: return "Supermarkets"
		Type.FastFood				: return "Fast Food"
		Type.Workshop				: return "Workshop"
		Type.MobileShop				: return "Mobile Shop"
		Type.Hospitals				: return "Hospitals"
		Type.Banks					: return "Banks"
		Type.Individuals			: return "Individuals"
		Type.MailServices			: return "Mail Services"
		Type.HackShop				: return "Hack Shop"
		Type.ComputerStore			: return "Computer Store"
		Type.RentServer				: return "Rent Server"
		Type.NetServices			: return "Net Services"
		Type.HardwareManufacturer	: return "Hardware Manufacturer"
		Type.Neurobox				: return "Neurobox"
		Type.Tutorial				: return "Tutorial"
		Type.CurrencyCreation		: return "Currency Creation"
		Type.CTF					: return "CTF"
		_: return str(type)

static func type_to_texture(type: Type) -> Texture2D:
	match type:
		Type.PoliceStation			: return preload("res://assets/ip_icons/police.svg")
		Type.Universities			: return preload("res://assets/ip_icons/university.svg")
		Type.Supermarkets			: return preload("res://assets/ip_icons/shop.svg")
		Type.FastFood				: return preload("res://assets/ip_icons/fast_food.svg")
		Type.Workshop				: return preload("res://assets/ip_icons/car_work.svg")
		Type.MobileShop				: return preload("res://assets/ip_icons/phone.svg")
		Type.Hospitals				: return preload("res://assets/ip_icons/hospital.svg")
		Type.Banks					: return preload("res://assets/ip_icons/bank.svg")
		Type.Individuals			: return preload("res://assets/ip_icons/blog.svg")
		Type.MailServices			: return preload("res://assets/ip_icons/email.svg")
		Type.HackShop				: return preload("res://assets/ip_icons/hack.svg")
		Type.ComputerStore			: return preload("res://assets/ip_icons/eshop.svg")
		Type.RentServer				: return preload("res://assets/ip_icons/server.svg")
		Type.NetServices			: return preload("res://assets/ip_icons/isp.svg")
		Type.HardwareManufacturer	: return preload("res://assets/ip_icons/electronic.svg")
		Type.Neurobox				: return preload("res://assets/ip_icons/target.svg")
		Type.Tutorial				: return preload("res://assets/ip_icons/tutorial.svg")
		Type.CurrencyCreation		: return preload("res://assets/ip_icons/crypto.svg")
		Type.CTF					: return preload("res://assets/ip_icons/ctf.svg")
		_: return null
