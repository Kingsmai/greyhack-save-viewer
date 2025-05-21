extends Window

const INFO_FACE_TEXTURE_RECT = preload("res://components/npc_viewer_window/info_face_texture_rect.tscn")

@onready var name_line_edit: LineEdit = %NameLineEdit
@onready var gender_line_edit: LineEdit = %GenderLineEdit
@onready var age_line_edit: LineEdit = %AgeLineEdit
@onready var license_plate_line_edit: LineEdit = %LicensePlateLineEdit
@onready var phone_number_line_edit: LineEdit = %PhoneNumberLineEdit
@onready var email_line_edit: LineEdit = %EmailLineEdit
@onready var email_password_line_edit: LineEdit = %EmailPasswordLineEdit

@onready var bank_domain_line_edit: LineEdit = %BankDomainLineEdit
@onready var bank_address_line_edit: LineEdit = %BankAddressLineEdit

@onready var local_ip_line_edit: LineEdit = %LocalIpLineEdit
@onready var job_role_line_edit: LineEdit = %JobRoleLineEdit
@onready var company_align_line_edit: LineEdit = %CompanyAlignLineEdit
@onready var zero_day_contact_line_edit: LineEdit = %ZeroDayContactLineEdit

@onready var is_fired_check_box: CheckBox = %IsFiredCheckBox
@onready var has_rumor_check_box: CheckBox = %HasRumorCheckBox

@onready var portrait_panel: Panel = %PortraitPanel

func _notification(what: int) -> void:
	match what:
		NOTIFICATION_WM_CLOSE_REQUEST:
			self.hide()

func _ready() -> void:
	self.hide()

func open(npc_info: NpcInfo):
	name_line_edit.text = npc_info.fullname
	gender_line_edit.text = "Male" if npc_info.gender == 0 else "Female"
	age_line_edit.text = str(npc_info.age)
	license_plate_line_edit.text = npc_info.license_plate
	phone_number_line_edit.text = str(npc_info.phone_number)
	email_line_edit.text = npc_info.user_mail
	email_password_line_edit.text = npc_info.email_password
	bank_domain_line_edit.text = npc_info.original_bank_domain
	bank_address_line_edit.text = npc_info.original_bank_address
	local_ip_line_edit.text = npc_info.local_ip
	job_role_line_edit.text = str(npc_info.job_role)
	company_align_line_edit.text = str(npc_info.company_align)
	zero_day_contact_line_edit.text = npc_info.zero_day_contact
	is_fired_check_box.button_pressed = npc_info.is_fired
	has_rumor_check_box.button_pressed = npc_info.has_rumor
	# Draw NPC Portrait
	for child in portrait_panel.get_children():
		portrait_panel.remove_child(child)
		child.queue_free()
	# Draw background:
	var background = INFO_FACE_TEXTURE_RECT.instantiate()
	portrait_panel.add_child(background)
	# Draw layers
	for layer in npc_info.info_face.info_face:
		var l = INFO_FACE_TEXTURE_RECT.instantiate()
		l.texture = load("res://assets/info_face/" + layer.part_name + ".png")
		portrait_panel.add_child(l)
	# TODO: Show NPC Schedule
	self.show()
