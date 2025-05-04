# ------------------------------------------------
# Class Name: InvoiceContainer
# Class Description:
# ------------------------------------------------
class_name InvoiceContainer extends MarginContainer

@onready var player_id_label: Label = %PlayerIdLabel
@onready var bank_account_label: Label = %BankAccountLabel
@onready var payment_id_line_edit: LineEdit = %PaymentIdLineEdit
@onready var next_money_line_edit: LineEdit = %NextMoneyLineEdit
@onready var next_date_line_edit: LineEdit = %NextDateLineEdit
@onready var public_ip_container: VBoxContainer = %PublicIpContainer

func set_invoice_contents(invoice_key: String, invoice: Invoice) -> void:
	player_id_label.text = invoice.player_id
	bank_account_label.text = invoice.bank_account
	payment_id_line_edit.text = str(invoice.payment_id)
	next_money_line_edit.text = str(invoice.next_money)
	next_date_line_edit.text = str(invoice.next_date)
	for public_ip in invoice.public_ips:
		var public_ip_line_edit = LineEdit.new()
		public_ip_line_edit.editable = false
		public_ip_line_edit.text = public_ip
