class_name Invoice extends Resource

## The Bank that this invoice is associated with
var bank_account: String

## The player who involved in this invoice
var player_id: String

## The amount of money to be paid
var next_money: int

var payment_id: int

## The date when the payment is due
var next_date: String:
	set(value):
		next_date = Utils.iso_datetime_to_string(value)
	get:
		return next_date

## The IP addresses of the servers to be paid
var public_ips: PackedStringArray

static func from_dict(dict: Dictionary) -> Invoice:
	var invoice = Invoice.new()
	invoice.bank_account = dict["bankAccount"]
	invoice.player_id = dict["playerID"]
	invoice.next_money = dict["nextMoney"]
	invoice.payment_id = dict["paymentID"]
	invoice.next_date = dict["nextDate"]
	invoice.public_ips = dict["publicIps"]
	return invoice
