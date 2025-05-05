# ------------------------------------------------
# Class Name: LogViewerView
# Class Description:
# ------------------------------------------------
class_name LogViewerView extends MarginContainer

@onready var log_tree: Tree = %LogTree

func _ready() -> void:
	log_tree.hide_folding = true
	log_tree.hide_root = true
	log_tree.columns = 3
	log_tree.column_titles_visible = true
	log_tree.set_column_title(0, "Date")
	log_tree.set_column_title(1, "Detail")
	log_tree.set_column_title(2, "IP")
	log_tree.set_column_custom_minimum_width(1, 400)

func set_log_contents(log_contents: Array[LogRecord]):
	log_tree.clear()
	var root = log_tree.create_item()
	for log_content in log_contents:
		var log_entry = root.create_child()
		log_entry.set_text(0, log_content.date)
		log_entry.set_text(1, log_content.get_detail_str())
		log_entry.set_text(2, log_content.ip)
