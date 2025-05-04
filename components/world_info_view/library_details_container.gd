# ------------------------------------------------
# Class Name: LibraryDetailsContainer
# Class Description:
# ------------------------------------------------
class_name LibraryDetailsContainer extends VBoxContainer

signal memory_zone_selected(vulnerability: Vulnerability)

@onready var lib_id_line_edit: LineEdit = %LibIdLineEdit
@onready var patch_id_line_edit: LineEdit = %PatchIdLineEdit
@onready var auto_patch_time_line_edit: LineEdit = %AutoPatchTimeLineEdit
@onready var num_patches_line_edit: LineEdit = %NumPatchesLineEdit
@onready var latest_version_line_edit: LineEdit = %LatestVersionLineEdit
@onready var memory_zone_tree: Tree = %MemoryZoneTree

func _ready() -> void:
	memory_zone_tree.hide_root = true
	memory_zone_tree.item_selected.connect(_on_memory_zone_tree_selected)
	memory_zone_tree.columns = 2
	memory_zone_tree.column_titles_visible = true
	memory_zone_tree.set_column_title(0, "Memory Zone")
	memory_zone_tree.set_column_title(1, "Times patched")
	

func load_library_detail_content(library_info: Lib):
	lib_id_line_edit.text = str(library_info.id_lib)
	patch_id_line_edit.text = str(library_info.id_patch)
	auto_patch_time_line_edit.text = library_info.auto_patch_time_str
	num_patches_line_edit.text = str(library_info.num_patches)
	latest_version_line_edit.text = library_info.version.version_str
	memory_zone_tree.clear()
	var root = memory_zone_tree.create_item()
	for memory_zone_key in library_info.memory_zone_list:
		var memory_zone: MemoryZone = library_info.memory_zone_list[memory_zone_key]
		var memory_zone_entry = root.create_child()
		memory_zone_entry.set_text(0, memory_zone.address)
		memory_zone_entry.collapsed = true
		memory_zone_entry.set_selectable(0, false)
		memory_zone_entry.set_text(1, str(memory_zone.times_patched))
		memory_zone_entry.set_text_alignment(1, HORIZONTAL_ALIGNMENT_CENTER)
		memory_zone_entry.set_selectable(1, false)
		for vulnerability in memory_zone.vulnerabilities:
			var vulnerability_entry = memory_zone_entry.create_child()
			vulnerability_entry.set_text(0, vulnerability.unsec_value)
			vulnerability_entry.set_metadata(0, vulnerability)

func reset_library_detail_content():
	lib_id_line_edit.text = ""
	patch_id_line_edit.text = ""
	auto_patch_time_line_edit.text = ""
	num_patches_line_edit.text = ""
	latest_version_line_edit.text = ""
	memory_zone_tree.clear()

func _on_memory_zone_tree_selected() -> void:
	var vulnerability: Vulnerability = memory_zone_tree.get_selected().get_metadata(0)
	memory_zone_selected.emit(vulnerability)
