# ------------------------------------------------
# Class Name: MessageContainer
# Class Description:
# ------------------------------------------------
class_name MessageContainer extends PanelContainer

@onready var message_title_label: Label = %MessageTitleLabel
@onready var message_content_rich_text_label: RichTextLabel = %MessageContentRichTextLabel

func set_message(message: Message):
	message_title_label.text = message.title
	message_content_rich_text_label.text = Utils.gh_html_to_bbcode(message.message)
	if message.is_sending:
		self.theme_type_variation = "MessageOutgoing"
