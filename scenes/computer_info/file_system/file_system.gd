# ------------------------------------------------
# Class Name: FileSystem
# Class Description:
# ------------------------------------------------
class_name FileSystem extends MarginContainer

@onready var file_system_tree: Tree = %FileSystemTree
@onready var path_line_edit: LineEdit = %PathLineEdit
@onready var content_code_edit: CodeEdit = %ContentCodeEdit

# File Details
@onready var file_name_line_edit: LineEdit = %FileNameLineEdit
@onready var is_binary_check_box: CheckBox = %IsBinaryCheckBox
@onready var is_allow_import_check_box: CheckBox = %IsAllowImportCheckBox
@onready var is_edited_other_player_check_box: CheckBox = %IsEditedOtherPlayerCheckBox
@onready var is_saved_check_box: CheckBox = %IsSavedCheckBox
@onready var is_protected_check_box: CheckBox = %IsProtectedCheckBox
@onready var is_default_content_check_box: CheckBox = %IsDefaultContentCheckBox
@onready var file_owner_line_edit: LineEdit = %FileOwnerLineEdit
@onready var file_group_line_edit: LineEdit = %FileGroupLineEdit
@onready var permissions_check_box: Array[CheckBox] = [
	%OwRCheckBox, %OwWCheckBox, %OwXCheckBox,
	%GrRCheckBox, %GrWCheckBox, %GrXCheckBox,
	%OtRCheckBox, %OtWCheckBox, %OtXCheckBox
]

@onready var file_id_label: Label = %FileIdLabel
@onready var file_ref_count_label: Label = %FileRefCountLabel


func _ready() -> void:
	file_system_tree.item_selected.connect(_on_file_selected)

func reset() -> void:
	file_system_tree.clear()
	path_line_edit.text = ""
	content_code_edit.text = ""
	file_name_line_edit.text = ""
	is_binary_check_box.button_pressed = false
	is_allow_import_check_box.button_pressed = false
	is_edited_other_player_check_box.button_pressed = false
	is_saved_check_box.button_pressed = false
	is_protected_check_box.button_pressed = false
	is_default_content_check_box.button_pressed = false
	file_owner_line_edit.text = ""
	file_group_line_edit.text = ""
	for permission in permissions_check_box:
		permission.button_pressed = false
	file_id_label.text = ""
	file_ref_count_label.text = ""

func populate_file_system(file_system: Dictionary) -> void:
	file_system_tree.clear()
	var root = file_system_tree.create_item()
	root.set_text(0, file_system["nombre"])
	_populate_node(root, file_system)

# 递归函数：填充节点
func _populate_node(parent: TreeItem, node_data: Dictionary) -> void:
	# 添加文件夹
	for folder in node_data.get("folders", []):
		var folder_item = parent.create_child()
		folder_item.set_text(0, folder["nombre"] + "/")
		folder_item.collapsed = true
		folder_item.set_metadata(0, folder)
		_populate_node(folder_item, folder) # 递归处理子文件夹
	# 添加文件
	for file in node_data.get("files", []):
		var file_item = parent.create_child()
		file_item.set_text(0, file["nombre"])
		file_item.set_metadata(0, file)

func _get_path(child: TreeItem) -> String:
	var current_path = child.get_text(0)
	var parent = child.get_parent()
	if parent == null:
		return current_path
	else:
		return _get_path(parent) + current_path

## 当选中某个文件
func _on_file_selected() -> void:
	var file_folder = file_system_tree.get_selected().get_metadata(0)
	var file_path = _get_path(file_system_tree.get_selected())
	path_line_edit.text = file_path
	if file_folder != null and "ID" in file_folder:
		var file_details = FilesRepository.get_file_details_by_id(file_folder["ID"])
		content_code_edit.text = Utils.prettier_content(file_details["Content"])
		file_id_label.text = file_id_label.text.split(":")[0] + ": " + file_details["ID"]
		file_ref_count_label.text = file_ref_count_label.text.split(":")[0] + ": " + str(file_details["refCount"])
		# Initialize file details
		file_name_line_edit.text = file_folder["nombre"]
		is_binary_check_box.button_pressed = file_folder["isBinario"]
		is_allow_import_check_box.button_pressed = file_folder["allowImport"]
		is_edited_other_player_check_box.button_pressed = file_folder["isEditedOtherPlayer"]
		is_saved_check_box.button_pressed = file_folder["saved"]
		is_protected_check_box.button_pressed = file_folder["isProtected"]
		is_default_content_check_box.button_pressed = file_folder["isDefaultContent"]
		file_owner_line_edit.text = file_folder["owner"]
		file_group_line_edit.text = file_folder["group"]
		var permissions = file_folder["permisos"]["permisos"].substr(1, 9).split("")
		for idx in range(permissions_check_box.size()):
			permissions_check_box[idx].button_pressed = permissions[idx] != "-"
