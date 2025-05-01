# ------------------------------------------------
# Class Name: HardwareView
# Class Description:
# ------------------------------------------------
class_name HardwareView extends MarginContainer

@onready var hardware_tab_container: TabContainer = %HardwareTabContainer

@onready var motherboard: MarginContainer = %Motherboard
@onready var cpus: MarginContainer = %CPUs
@onready var rams: MarginContainer = %RAMs
@onready var gpu: MarginContainer = %GPU
@onready var hard_disk: MarginContainer = %HardDisk
@onready var net_device: MarginContainer = %NetDevice
@onready var psu: MarginContainer = %PSU

@onready var motherboard_id_line_edit: LineEdit = %MotherboardIdLineEdit
@onready var motherboard_name_line_edit: LineEdit = %MotherboardNameLineEdit
@onready var motherboard_power_requirement_line_edit: LineEdit = %MotherboardPowerRequirementLineEdit
@onready var motherboard_quality_progress_bar: ProgressBar = %MotherboardQualityProgressBar
@onready var motherboard_health_progress_bar: ProgressBar = %MotherboardHealthProgressBar
@onready var motherboard_type_line_edit: LineEdit = %MotherboardTypeLineEdit
@onready var motherboard_is_sellable_checkbox: CheckBox = %MotherboardIsSellableCheckbox
@onready var motherboard_cpu_count_line_edit: LineEdit = %MotherboardCpuCountLineEdit
@onready var motherboard_cpu_socket_line_edit: LineEdit = %MotherboardCpuSocketLineEdit
@onready var motherboard_ram_version_line_edit: LineEdit = %MotherboardRamVersionLineEdit
@onready var motherboard_ram_socket_count_line_edit: LineEdit = %MotherboardRamSocketCountLineEdit
@onready var motherboard_max_ram_memory_per_socket_line_edit: LineEdit = %MotherboardMaxRamMemoryPerSocketLineEdit
@onready var motherboard_pci_count_line_edit: LineEdit = %MotherboardPciCountLineEdit

@onready var cpu_buttons_container: HBoxContainer = %CPUButtonsContainer

@onready var cpu_id_line_edit: LineEdit = %CpuIdLineEdit
@onready var cpu_name_line_edit: LineEdit = %CpuNameLineEdit
@onready var cpu_power_requirement_line_edit: LineEdit = %CpuPowerRequirementLineEdit
@onready var cpu_quality_progress_bar: ProgressBar = %CpuQualityProgressBar
@onready var cpu_health_progress_bar: ProgressBar = %CpuHealthProgressBar
@onready var cpu_type_line_edit: LineEdit = %CpuTypeLineEdit
@onready var cpu_is_sellable_checkbox: CheckBox = %CpuIsSellableCheckbox
@onready var cpu_speed_line_edit: LineEdit = %CpuSpeedLineEdit
@onready var cpu_core_count_line_edit: LineEdit = %CpuCoreCountLineEdit
@onready var cpu_socket_line_edit: LineEdit = %CpuSocketLineEdit

@onready var ram_buttons_container: HBoxContainer = %RAMButtonsContainer

@onready var ram_id_line_edit: LineEdit = %RamIdLineEdit
@onready var ram_name_line_edit: LineEdit = %RamNameLineEdit
@onready var ram_power_requirement_line_edit: LineEdit = %RamPowerRequirementLineEdit
@onready var ram_quality_progress_bar: ProgressBar = %RamQualityProgressBar
@onready var ram_health_progress_bar: ProgressBar = %RamHealthProgressBar
@onready var ram_type_line_edit: LineEdit = %RamTypeLineEdit
@onready var ram_is_sellable_checkbox: CheckBox = %RamIsSellableCheckbox
@onready var ram_size_line_edit: LineEdit = %RamSizeLineEdit
@onready var ram_model_line_edit: LineEdit = %RamModelLineEdit

@onready var gpu_id_line_edit: LineEdit = %GpuIdLineEdit
@onready var gpu_name_line_edit: LineEdit = %GpuNameLineEdit
@onready var gpu_power_requirement_line_edit: LineEdit = %GpuPowerRequirementLineEdit
@onready var gpu_quality_progress_bar: ProgressBar = %GpuQualityProgressBar
@onready var gpu_health_progress_bar: ProgressBar = %GpuHealthProgressBar
@onready var gpu_type_line_edit: LineEdit = %GpuTypeLineEdit
@onready var gpu_is_sellable_checkbox: CheckBox = %GpuIsSellableCheckbox
@onready var gpu_hashrate_line_edit: LineEdit = %GpuHashrateLineEdit

@onready var hard_disk_id_line_edit: LineEdit = %HardDiskIdLineEdit
@onready var hard_disk_name_line_edit: LineEdit = %HardDiskNameLineEdit
@onready var hard_disk_power_requirement_line_edit: LineEdit = %HardDiskPowerRequirementLineEdit
@onready var hard_disk_quality_progress_bar: ProgressBar = %HardDiskQualityProgressBar
@onready var hard_disk_health_progress_bar: ProgressBar = %HardDiskHealthProgressBar
@onready var hard_disk_type_line_edit: LineEdit = %HardDiskTypeLineEdit
@onready var hard_disk_is_sellable_checkbox: CheckBox = %HardDiskIsSellableCheckbox
@onready var hard_disk_speed_line_edit: LineEdit = %HardDiskSpeedLineEdit
@onready var hard_disk_actual_speed_line_edit: LineEdit = %HardDiskActualSpeedLineEdit
@onready var hard_disk_total_size_line_edit: LineEdit = %HardDiskTotalSizeLineEdit
@onready var hard_disk_performance_line_edit: LineEdit = %HardDiskPerformanceLineEdit
@onready var hard_disk_affect_performance_line_edit: LineEdit = %HardDiskAffectPerformanceLineEdit

@onready var net_device_buttons_container: HBoxContainer = %NetDeviceButtonsContainer

@onready var net_device_id_line_edit: LineEdit = %NetDeviceIdLineEdit
@onready var net_device_name_line_edit: LineEdit = %NetDeviceNameLineEdit
@onready var net_device_power_requirement_line_edit: LineEdit = %NetDevicePowerRequirementLineEdit
@onready var net_device_quality_progress_bar: ProgressBar = %NetDeviceQualityProgressBar
@onready var net_device_health_progress_bar: ProgressBar = %NetDeviceHealthProgressBar
@onready var net_device_type_line_edit: LineEdit = %NetDeviceTypeLineEdit
@onready var net_device_is_sellable_checkbox: CheckBox = %NetDeviceIsSellableCheckbox
@onready var net_device_is_wifi_check_box: CheckBox = %NetDeviceIsWifiCheckBox
@onready var net_device_is_monitor_support_check_box: CheckBox = %NetDeviceIsMonitorSupportCheckBox
@onready var net_device_is_monitor_enabled_checkbox: CheckBox = %NetDeviceIsMonitorEnabledCheckbox
@onready var net_device_bssid_line_edit: LineEdit = %NetDeviceBssidLineEdit
@onready var net_device_essid_line_edit: LineEdit = %NetDeviceEssidLineEdit

@onready var psu_id_line_edit: LineEdit = %PSUIdLineEdit
@onready var psu_name_line_edit: LineEdit = %PSUNameLineEdit
@onready var psu_power_requirement_line_edit: LineEdit = %PSUPowerRequirementLineEdit
@onready var psu_quality_progress_bar: ProgressBar = %PSUQualityProgressBar
@onready var psu_health_progress_bar: ProgressBar = %PSUHealthProgressBar
@onready var psu_type_line_edit: LineEdit = %PSUTypeLineEdit
@onready var psu_is_sellable_checkbox: CheckBox = %PSUIsSellableCheckbox
@onready var psu_power_supply_line_edit: LineEdit = %PSUPowerSupplyLineEdit

func _ready() -> void:
	motherboard_quality_progress_bar.max_value = 10
	cpu_quality_progress_bar.max_value = 10
	ram_quality_progress_bar.max_value = 10
	hard_disk_quality_progress_bar.max_value = 10
	gpu_quality_progress_bar.max_value = 10
	net_device_quality_progress_bar.max_value = 10
	psu_quality_progress_bar.max_value = 10

func set_hardware_data(data: HardwareProfile):
	populate_multiple_buttons(data)
	_set_motherboard_data(data.mother_board)
	_set_cpu_data(data.cpus[0])
	_set_ram_data(data.rams[0])
	if data.gpu.id.is_empty():
		hardware_tab_container.set_tab_hidden(gpu.get_index(), true)
	else:
		_set_gpu_data(data.gpu)
	_set_hard_disk_data(data.hard_disk)
	if data.network_devices.is_empty():
		# Hide network_data tab
		hardware_tab_container.set_tab_hidden(net_device.get_index(), true)
	else:
		_set_net_device_data(data.network_devices[0])
	_set_psu_data(data.power_supply)

func populate_multiple_buttons(data: HardwareProfile):
	for idx in data.cpus.size():
		var new_cpu_button = Button.new()
		new_cpu_button.text = "CPU#%d" % idx
		new_cpu_button.pressed.connect(func(): _set_cpu_data(data.cpus[idx]))
		cpu_buttons_container.add_child(new_cpu_button)
	for idx in data.rams.size():
		var new_ram_button = Button.new()
		new_ram_button.text = "RAM#%d" % idx
		new_ram_button.pressed.connect(func(): _set_ram_data(data.rams[idx]))
		ram_buttons_container.add_child(new_ram_button)
	for idx in data.network_devices.size():
		var new_net_device_button = Button.new()
		new_net_device_button.text = "Net Device#%d" % idx
		new_net_device_button.pressed.connect(func(): _set_net_device_data(data.network_devices[idx]))
		net_device_buttons_container.add_child(new_net_device_button)

func _set_motherboard_data(data: HardwareProfile.MotherBoard):
	motherboard_id_line_edit.text = data.id
	motherboard_name_line_edit.text = data.name
	motherboard_power_requirement_line_edit.text = str(data.req_power)
	motherboard_quality_progress_bar.value = data.quality
	motherboard_health_progress_bar.value = data.health
	# TODO: Need to convert data to string
	motherboard_type_line_edit.text = str(data.type)
	motherboard_is_sellable_checkbox.button_pressed = data.allow_sell
	motherboard_cpu_count_line_edit.text = str(data.num_cpus)
	motherboard_cpu_socket_line_edit.text = data.cpu_socket
	motherboard_ram_socket_count_line_edit.text = str(data.num_ram_sockets)
	motherboard_ram_version_line_edit.text = str(data.ram_model)
	motherboard_max_ram_memory_per_socket_line_edit.text = str(data.max_ram_socket)
	motherboard_pci_count_line_edit.text = str(data.num_pci)

func _set_cpu_data(data: HardwareProfile.CPU):
	cpu_id_line_edit.text = data.id
	cpu_name_line_edit.text = data.name
	cpu_power_requirement_line_edit.text = str(data.req_power)
	cpu_quality_progress_bar.value = data.quality
	cpu_health_progress_bar.value = data.health
	cpu_type_line_edit.text = str(data.type)
	cpu_is_sellable_checkbox.button_pressed = data.allow_sell
	cpu_speed_line_edit.text = str(data.speed)
	cpu_core_count_line_edit.text = str(data.num_cores)
	cpu_socket_line_edit.text = data.socket

func _set_ram_data(data: HardwareProfile.RAM):
	ram_id_line_edit.text = data.id
	ram_name_line_edit.text = data.name
	ram_power_requirement_line_edit.text = str(data.req_power)
	ram_quality_progress_bar.value = data.quality
	ram_health_progress_bar.value = data.health
	ram_type_line_edit.text = str(data.type)
	ram_is_sellable_checkbox.button_pressed = data.allow_sell
	ram_size_line_edit.text = str(data.memory)
	ram_model_line_edit.text = str(data.ram_model)

func _set_gpu_data(data: HardwareProfile.GPU):
	gpu_id_line_edit.text = data.id
	gpu_name_line_edit.text = data.name
	gpu_power_requirement_line_edit.text = str(data.req_power)
	gpu_quality_progress_bar.value = data.quality
	gpu_health_progress_bar.value = data.health
	gpu_type_line_edit.text = str(data.type)
	gpu_is_sellable_checkbox.button_pressed = data.allow_sell
	gpu_hashrate_line_edit.text = str(data.hashrate)

func _set_hard_disk_data(data: HardwareProfile.HardDisk):
	hard_disk_id_line_edit.text = data.id
	hard_disk_name_line_edit.text = data.name
	hard_disk_power_requirement_line_edit.text = str(data.req_power)
	hard_disk_quality_progress_bar.value = data.quality
	hard_disk_health_progress_bar.value = data.health
	hard_disk_type_line_edit.text = str(data.type)
	hard_disk_is_sellable_checkbox.button_pressed = data.allow_sell
	hard_disk_speed_line_edit.text = str(data.speed)
	hard_disk_actual_speed_line_edit.text = str(data.actual_speed)
	hard_disk_total_size_line_edit.text = str(data.total_size)
	hard_disk_performance_line_edit.text = str(data.performance)
	hard_disk_affect_performance_line_edit.text = str(data.affect_performance)

func _set_net_device_data(data: HardwareProfile.NetworkDevice):
	net_device_id_line_edit.text = data.id
	net_device_name_line_edit.text = data.name
	net_device_power_requirement_line_edit.text = str(data.req_power)
	net_device_quality_progress_bar.value = data.quality
	net_device_health_progress_bar.value = data.health
	net_device_type_line_edit.text = str(data.type)
	net_device_is_sellable_checkbox.button_pressed = data.allow_sell
	net_device_is_wifi_check_box.button_pressed = data.is_wifi
	net_device_is_monitor_support_check_box.button_pressed = data.monitor_support
	net_device_is_monitor_enabled_checkbox.button_pressed = data.monitor_enabled
	net_device_bssid_line_edit.text = data.bssid_ap
	net_device_essid_line_edit.text = data.essid_ap

func _set_psu_data(data: HardwareProfile.PowerSupply):
	psu_id_line_edit.text = data.id
	psu_name_line_edit.text = data.name
	psu_power_requirement_line_edit.text = str(data.req_power)
	psu_quality_progress_bar.value = data.quality
	psu_health_progress_bar.value = data.health
	psu_type_line_edit.text = str(data.type)
	psu_is_sellable_checkbox.button_pressed = data.allow_sell
	psu_power_supply_line_edit.text = str(data.power)
