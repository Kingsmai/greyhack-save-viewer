# ------------------------------------------------
# Class Name: LibrariesViewer
# Class Description:
# ------------------------------------------------
class_name LibrariesViewer extends MarginContainer

@onready var library_tree: Tree = %LibraryTree

@onready var library_details_container: LibraryDetailsContainer = %LibraryDetailsContainer
@onready var vulnerability_container: VulnerabilityContainer = %VulnerabilityContainer

func _ready() -> void:
	GreyHack.world_info_load.connect(_on_world_info_load)
	library_tree.hide_folding = true
	library_tree.hide_root = true
	library_tree.item_selected.connect(_on_library_tree_item_selected)
	library_details_container.memory_zone_selected.connect(_on_memory_zone_selected)

func _on_world_info_load(world_data: WorldInfo) -> void:
	var libraries = world_data.versions_control
	library_tree.clear()
	var root = library_tree.create_item()
	for library in libraries:
		var library_entry = root.create_child()
		library_entry.set_text(0, library)
		library_entry.set_metadata(0, libraries[library])

func _on_library_tree_item_selected() -> void:
	var library_info: Lib = library_tree.get_selected().get_metadata(0)
	library_details_container.load_library_detail_content(library_info)
	vulnerability_container.reset_vulnerability_contents()

func _on_memory_zone_selected(vulnerability: Vulnerability) -> void:
	vulnerability_container.load_vulnerability_contents(vulnerability)
