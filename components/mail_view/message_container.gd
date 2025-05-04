# ------------------------------------------------
# Class Name: MessageContainer
# Class Description:
# ------------------------------------------------
class_name MessageContainer extends PanelContainer

@onready var message_title_label: Label = %MessageTitleLabel
@onready var message_content_rich_text_label: RichTextLabel = %MessageContentRichTextLabel

func set_message(message: Message):
	message_title_label.text = message.title
	print(message.message)
	message_content_rich_text_label.text = Utils.gh_html_to_bbcode(message.message)
	if message.is_sending:
		var sending_stylebox = StyleBoxFlat.new()
		sending_stylebox.bg_color = Color.SEA_GREEN
		sending_stylebox.corner_radius_bottom_left = 4
		sending_stylebox.corner_radius_bottom_right = 4
		sending_stylebox.corner_radius_top_left = 4
		sending_stylebox.corner_radius_top_right = 4
		self.add_theme_stylebox_override("panel", sending_stylebox)
