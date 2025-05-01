# ------------------------------------------------
# Class Name: FileSystemView
# Class Description:
# ------------------------------------------------
class_name FileSystemView extends MarginContainer

@onready var file_system_tree: Tree = %FileSystemTree
@onready var path_line_edit: LineEdit = %PathLineEdit
@onready var content_code_edit: CodeEdit = %ContentCodeEdit

# File Details
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

func populate_file_system(file_system: FileSystemRoot) -> void:
	file_system_tree.clear()
	var root = file_system_tree.create_item()
	root.set_text(0, "/")
	_populate_node(root, file_system.folders, file_system.files)

func _populate_node(parent: TreeItem, folders: Array[FileSystemRoot.FolderEntry], files: Array[FileSystemRoot.FileEntry]) -> void:
	for folder in folders:
		var folder_item = parent.create_child()
		folder_item.set_text(0, folder.name + "/")
		folder_item.collapsed = true
		folder_item.set_metadata(0, folder)
		_populate_node(folder_item, folder.folders, folder.files)

	for file in files:
		var file_item = parent.create_child()
		file_item.set_text(0, file.name)
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
	var item = file_system_tree.get_selected()
	if item == null:
		return

	var data = item.get_metadata(0)
	var file_path = _get_path(item)
	path_line_edit.text = file_path

	if data is FileSystemRoot.FileEntry:
		var file: FileSystemRoot.FileEntry = data

		# 模拟文件内容获取
		var file_details = FilesDB.get_file_details_by_id(file.id)
		content_code_edit.text = Utils.prettier_content(file_details["Content"])

		file_id_label.text = "ID: " + file.id
		file_ref_count_label.text = "RefCount: " + str(file_details["refCount"])

		is_binary_check_box.button_pressed = file.is_binary
		is_allow_import_check_box.button_pressed = file.allow_import
		is_edited_other_player_check_box.button_pressed = file.is_edited_by_other_player
		is_saved_check_box.button_pressed = file.is_saved
		is_protected_check_box.button_pressed = file.is_protected
		is_default_content_check_box.button_pressed = file.is_default_content
		file_owner_line_edit.text = file.owner
		file_group_line_edit.text = file.group

		var permissions_string = file.permissions.permissions.substr(1, 9)
		for i in range(permissions_check_box.size()):
			permissions_check_box[i].button_pressed = permissions_string[i] != "-"
			permissions_check_box[i].tooltip_text = "rwxrwxrwx"[i]
