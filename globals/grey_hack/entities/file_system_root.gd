class_name FileSystemRoot extends Resource

var computer_id: String
var files: Array[FileEntry] = []
var folders: Array[FolderEntry] = []

class FilePermissions:
	var permissions: String

class HelperImport:
	var is_from_launch: bool
	var index_starts: Array[int]
	var index_ends: Array[int]
	var file_names: Array[String]

class FileEntry:
	var id: String
	var price: int
	var is_binary: bool
	var allow_import: bool
	var is_edited_by_other_player: bool
	var original_owner_id: String
	var is_saved: bool
	var description: String
	var helper_import_data: HelperImport
	var name: String
	var permissions: FilePermissions
	var owner: String
	var group: String
	var command: String
	var symlink: String
	var size: int
	var process_name: String
	var server_path: String
	var is_protected: bool
	var mission_id: String
	var file_type: int
	var is_default_content: bool

class FolderEntry:
	var files: Array[FileEntry] = []
	var folders: Array[FolderEntry] = []
	var name: String
	var permissions: FilePermissions
	var owner: String
	var group: String
	var command: String
	var symlink: String
	var size: int
	var process_name: String
	var server_path: String
	var is_protected: bool
	var mission_id: String
	var file_type: int
	var is_default_content: bool

static func load_file_system_from_json(data: Dictionary) -> FileSystemRoot:
	if typeof(data) != TYPE_DICTIONARY:
		push_error("Invalid JSON format.")
		return null

	var root := FileSystemRoot.new()
	root.computer_id = data.get("computerID", "")
	root.files = _parse_files(data.get("files", []))
	root.folders = _parse_folders(data.get("folders", []))
	return root

static func _parse_files(raw_files: Array) -> Array[FileEntry]:
	var files_arr: Array[FileEntry] = []
	for f in raw_files:
		var entry := FileEntry.new()
		entry.id = f.get("ID", "")
		entry.price = f.get("precio", 0)
		entry.is_binary = f.get("isBinario", false)
		entry.allow_import = f.get("allowImport", false)
		entry.is_edited_by_other_player = f.get("isEditedOtherPlayer", false)
		entry.original_owner_id = f.get("origOwnerID", "")
		entry.is_saved = f.get("saved", false)
		var desc = f.get("desc", "")
		entry.description = "" if desc == null else desc
		
		## TODO: Got bug here
		## Invalid assignment of property or key 'index_starts' with value of
		## type 'Array' on a base object of type 'RefCounted (HelperImport)'.
		#if f.has("helperImport") and f.helperImport != null:
			#var helper := HelperImport.new()
			#var raw_helper = f["helperImport"]
			#helper.is_from_launch = raw_helper.get("isFromLaunch", false)
			#helper.index_starts = Array(raw_helper.get("indexInis", [])).duplicate() as Array[int]
			#helper.index_ends = Array(raw_helper.get("indexEnds", [])).duplicate() as Array[int]
			#helper.file_names = Array(raw_helper.get("fileName", [])).duplicate() as Array[String]
			#entry.helper_import_data = helper
		
		entry.name = f.get("nombre", "")
		
		var perms := FilePermissions.new()
		perms.permissions = f.get("permisos", {}).get("permisos", "")
		entry.permissions = perms
		
		entry.owner = f.get("owner", "")
		entry.group = f.get("group", "")
		entry.command = f.get("comando", "")
		entry.symlink = f.get("symlink", "")
		entry.size = f.get("size", 0)
		entry.process_name = f.get("process", "")
		entry.server_path = f.get("serverPath", "")
		entry.is_protected = f.get("isProtected", false)
		entry.mission_id = f.get("missionID", "")
		entry.file_type = f.get("typeFile", 0)
		entry.is_default_content = f.get("isDefaultContent", false)
		files_arr.append(entry)
	return files_arr

static func _parse_folders(raw_folders: Array) -> Array[FolderEntry]:
	var folders_arr: Array[FolderEntry] = []
	for f in raw_folders:
		var folder := FolderEntry.new()
		folder.name = f.get("nombre", "")
		
		var perms := FilePermissions.new()
		perms.permissions = f.get("permisos", {}).get("permisos", "")
		folder.permissions = perms
		
		folder.owner = f.get("owner", "")
		folder.group = f.get("group", "")
		folder.command = f.get("comando", "")
		folder.symlink = f.get("symlink", "")
		folder.size = f.get("size", 0)
		folder.process_name = f.get("process", "")
		folder.server_path = f.get("serverPath", "")
		folder.is_protected = f.get("isProtected", false)
		folder.mission_id = f.get("missionID", "")
		folder.file_type = f.get("typeFile", 0)
		folder.is_default_content = f.get("isDefaultContent", false)
		
		folder.files = _parse_files(f.get("files", []))
		folder.folders = _parse_folders(f.get("folders", []))
		
		folders_arr.append(folder)
	return folders_arr

## 🔍 1. 递归查找文件或文件夹（按名称）
func find_file_by_name(name: String) -> FileEntry:
	for file in files:
		if file.name == name:
			return file
	for folder in folders:
		var result = _find_file_in_folder(folder, name)
		if result:
			return result
	return null

func _find_file_in_folder(folder: FolderEntry, name: String) -> FileEntry:
	for file in folder.files:
		if file.name == name:
			return file
	for subfolder in folder.folders:
		var result = _find_file_in_folder(subfolder, name)
		if result:
			return result
	return null

## 📂 2. 查找特定路径下的文件夹（支持递归）
func find_folder_by_path(path: String) -> FolderEntry:
	var segments = path.split("/")
	return _find_folder_recursive(folders, segments)

func _find_folder_recursive(current_folders: Array[FolderEntry], segments: Array[String]) -> FolderEntry:
	if segments.is_empty():
		return null
	for folder in current_folders:
		if folder.name == segments[0]:
			if segments.size() == 1:
				return folder
			else:
				return _find_folder_recursive(folder.folders, segments.slice(1, segments.size()))
	return null

func clone() -> FileSystemRoot:
	var new_root := FileSystemRoot.new()
	new_root.computer_id = computer_id
	new_root.files = _clone_files(files)
	new_root.folders = _clone_folders(folders)
	return new_root

## 🔄 克隆工具（复制结构体，不共享引用）
func _clone_files(files_arr: Array[FileEntry]) -> Array[FileEntry]:
	var result: Array[FileEntry] = []
	for file in files_arr:
		var cloned_file := FileEntry.new()
		cloned_file.id = file.id
		cloned_file.price = file.price
		cloned_file.is_binary = file.is_binary
		cloned_file.allow_import = file.allow_import
		cloned_file.is_edited_by_other_player = file.is_edited_by_other_player
		cloned_file.original_owner_id = file.original_owner_id
		cloned_file.is_saved = file.is_saved
		cloned_file.description = file.description
		if file.helper_import_data:
			var h := HelperImport.new()
			h.is_from_launch = file.helper_import_data.is_from_launch
			h.index_starts = file.helper_import_data.index_starts.duplicate()
			h.index_ends = file.helper_import_data.index_ends.duplicate()
			h.file_names = file.helper_import_data.file_names.duplicate()
			cloned_file.helper_import_data = h
		else:
			cloned_file.helper_import_data = null
		cloned_file.name = file.name
		var p := FilePermissions.new()
		p.permissions = file.permissions.permissions
		cloned_file.permissions = p
		cloned_file.owner = file.owner
		cloned_file.group = file.group
		cloned_file.command = file.command
		cloned_file.symlink = file.symlink
		cloned_file.size = file.size
		cloned_file.process_name = file.process_name
		cloned_file.server_path = file.server_path
		cloned_file.is_protected = file.is_protected
		cloned_file.mission_id = file.mission_id
		cloned_file.file_type = file.file_type
		cloned_file.is_default_content = file.is_default_content
		result.append(cloned_file)
	return result

func _clone_folders(folders_arr: Array[FolderEntry]) -> Array[FolderEntry]:
	var result: Array[FolderEntry] = []
	for folder in folders_arr:
		var cloned_folder := FolderEntry.new()
		cloned_folder.name = folder.name
		var p := FilePermissions.new()
		p.permissions = folder.permissions.permissions
		cloned_folder.permissions = p
		cloned_folder.owner = folder.owner
		cloned_folder.group = folder.group
		cloned_folder.command = folder.command
		cloned_folder.symlink = folder.symlink
		cloned_folder.size = folder.size
		cloned_folder.process_name = folder.process_name
		cloned_folder.server_path = folder.server_path
		cloned_folder.is_protected = folder.is_protected
		cloned_folder.mission_id = folder.mission_id
		cloned_folder.file_type = folder.file_type
		cloned_folder.is_default_content = folder.is_default_content
		cloned_folder.files = _clone_files(folder.files)
		cloned_folder.folders = _clone_folders(folder.folders)
		result.append(cloned_folder)
	return result

## 📊 统计工具
func count_total_files() -> int:
	return _count_files_in_list(files) + _count_files_in_folders(folders)

func _count_files_in_list(list: Array[FileEntry]) -> int:
	return list.size()

func _count_files_in_folders(folder_list: Array[FolderEntry]) -> int:
	var count = 0
	for folder in folder_list:
		count += folder.files.size()
		count += _count_files_in_folders(folder.folders)
	return count

func get_total_size() -> int:
	var size = 0
	for file in files:
		size += file.size
	for folder in folders:
		size += _get_folder_size(folder)
	return size

func _get_folder_size(folder: FolderEntry) -> int:
	var size = 0
	for file in folder.files:
		size += file.size
	for sub in folder.folders:
		size += _get_folder_size(sub)
	return size
