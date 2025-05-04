# ------------------------------------------------
# Class Name: MetadaViewer
# Class Description:
# ------------------------------------------------
class_name MetadataViewer extends MarginContainer

const INVOICE_CONTAINER = preload("res://components/world_info_view/invoice_container.tscn")

@onready var rnd_seed_line_edit: LineEdit = %RndSeedLineEdit
@onready var clock_label: Label = %ClockLabel

@onready var money_line_edit: LineEdit = %MoneyLineEdit
@onready var last_money_line_edit: LineEdit = %LastMoneyLineEdit
@onready var last_year_withdraw_line_edit: LineEdit = %LastYearWithdrawLineEdit

@onready var invoice_item_list: VBoxContainer = %InvoiceItemList

func _ready() -> void:
	GreyHack.world_info_load.connect(_on_world_info_loaded)

func _on_world_info_loaded(world_data: WorldInfo) -> void:
	rnd_seed_line_edit.text = str(world_data.rnd_seed)
	clock_label.text = Utils.iso_datetime_to_string(world_data.clock)
	money_line_edit.text = str(world_data.global_money.money)
	last_money_line_edit.text = str(world_data.global_money.last_money)
	last_year_withdraw_line_edit.text = str(world_data.global_money.last_year_withdraw)
	for player_id in world_data.invoices:
		for invoice_key in world_data.invoices[player_id]:
			var invoice_container = INVOICE_CONTAINER.instantiate()
			invoice_item_list.add_child(invoice_container)
			invoice_container.set_invoice_contents(invoice_key, world_data.invoices[player_id][invoice_key])
			invoice_container.size_flags_horizontal = Control.SIZE_EXPAND_FILL
