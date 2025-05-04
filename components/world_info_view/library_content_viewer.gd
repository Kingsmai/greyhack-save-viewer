# ------------------------------------------------
# Class Name: LibraryContentViewer
# Class Description:
# ------------------------------------------------
class_name LibraryContentViewer extends MarginContainer

@onready var library_tree: Tree = %LibraryTree

@onready var library_details_container: LibraryDetailsContainer = %LibraryDetailsContainer
@onready var vulnerability_container: VulnerabilityContainer = %VulnerabilityContainer

func _ready() -> void:
	GreyHack.world_info_load.connect(_on_world_info_loaded)
	library_tree.hide_root = true
	library_tree.item_selected.connect(_on_library_tree_item_selected)
	library_details_container.memory_zone_selected.connect(_on_memory_zone_selected)

func _on_world_info_loaded(world_info: WorldInfo) -> void:
	library_tree.clear()
	var root = library_tree.create_item()
	for lib in world_info.all_libs:
		var lib_entry = root.create_child()
		lib_entry.set_text(0, lib)
		lib_entry.set_selectable(0, false)
		lib_entry.collapsed = true
		for file in world_info.all_libs[lib]:
			var file_entry = lib_entry.create_child()
			file_entry.set_text(0, "Version #%d" % world_info.all_libs[lib].find(file))
			file_entry.set_metadata(0, file)

func _on_library_tree_item_selected() -> void:
	library_details_container.reset_library_detail_content()
	vulnerability_container.reset_vulnerability_contents()
	var file_id = library_tree.get_selected().get_metadata(0)
	var file_details = FilesDB.get_file_details_by_id(file_id)
	var file_content = file_details["Content"]
	var lib: Lib
	if typeof(file_content) == TYPE_DICTIONARY:
		lib = Lib.from_dict(file_content)
	else:
		return
	library_details_container.load_library_detail_content(lib)

func _on_memory_zone_selected(vulnerability: Vulnerability) -> void:
	vulnerability_container.load_vulnerability_contents(vulnerability)
