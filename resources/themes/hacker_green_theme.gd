@tool
extends ProgrammaticTheme

const UPDATE_ON_SAVE = true

#region HACKER COLOR PALATTE
# 文字颜色（绿色主调 + 高对比度）
const PRIMARY_TEXT = Color("#00FF00")      # Hacker Green
const REGULAR_TEXT = Color("#66FF66")
const SECONDARY_TEXT = Color("#33CC33")
const PLACEHOLDER_TEXT = Color("#1F7F1F")
const DISABLED_TEXT = Color("#0D400D")

# 边框颜色（偏冷色 + 明暗区分）
const DARKER_BORDER = Color("#0D0D0D")
const DARK_BORDER = Color("#1A1A1A")
const BASE_BORDER = Color("#2A2A2A")
const LIGHT_BORDER = Color("#3A3A3A")
const LIGHTER_BORDER = Color("#4A4A4A")
const EXTRA_LIGHT_BORDER = Color("#5A5A5A")

# 填充颜色（低饱和黑绿混合，营造 CRT/夜间监控室感）
const DARKER_FILL = Color("#000000")
const DARK_FILL = Color("#0C0F0C")
const BASE_FILL = Color("#101610")
const LIGHT_FILL = Color("#151C15")
const LIGHTER_FILL = Color("#1C241C")
const EXTRA_LIGHT_FILL = Color("#232D23")
const BLANK_FILL = Color("#2A362A")

# 基础色
const BASIC_BLACK = Color("#000000")
const BASIC_WHITE = Color("#FFFFFF")
const TRANSPARENT = Color(0, 0, 0, 0)

# 背景（暗色偏绿色，贴近 Matrix 黑客视觉）
const PAGE_BACKGROUND = Color("#000000")     # 纯黑底
const BASE_BACKGROUND = Color("#0D0F0D")     # 黑中带绿
const OVERLAY_BACKGROUND = Color("#111711")

# 品牌颜色（偏冷光效色，非传统主色）
const BRAND_COLOR = Color("#000")
const PRIMARY_COLOR = Color("#00FF00")       # Hacker Green
const SUCCESS_COLOR = Color("#33FF33")
const WARNING_COLOR = Color("#FFFF33")
const DANGER_COLOR = Color("#FF3333")
const INFO_COLOR = Color("#888888")

# 状态颜色（亮化/暗化处理）
var BRAND_HOVER_COLOR = BRAND_COLOR.lightened(0.1)
var BRAND_PRESSED_COLOR = BRAND_COLOR.darkened(0.2)
var PRIMARY_HOVER_COLOR = PRIMARY_COLOR.lightened(0.1)
var PRIMARY_PRESSED_COLOR = PRIMARY_COLOR.darkened(0.2)
var SUCCESS_HOVER_COLOR = SUCCESS_COLOR.lightened(0.1)
var SUCCESS_PRESSED_COLOR = SUCCESS_COLOR.darkened(0.2)
var WARNING_HOVER_COLOR = WARNING_COLOR.lightened(0.1)
var WARNING_PRESSED_COLOR = WARNING_COLOR.darkened(0.2)
var DANGER_HOVER_COLOR = DANGER_COLOR.lightened(0.1)
var DANGER_PRESSED_COLOR = DANGER_COLOR.darkened(0.2)
var INFO_HOVER_COLOR = INFO_COLOR.lightened(0.1)
var INFO_PRESSED_COLOR = INFO_COLOR.darkened(0.2)
#endregion

#region BORDER_AND_CORNERS
const DEFAULT_BUTTON_BORDER_WIDTH = 1
const DEFAULT_BUTTON_MARGIN = 4
const DEFAULT_BUTTON_CORNER_RADIUS = 4

const DEFAULT_CONTENT_MARGIN = 8
const DEFAULT_CONTENT_CORNER_RADIUS = 8


const DEFAULT_SEPARATION = 8
#endregion

#region STYLES
# 888888b.            888    888                           .d8888b.  888             888          
# 888  "88b           888    888                          d88P  Y88b 888             888          
# 888  .88P           888    888                          Y88b.      888             888          
# 8888888K.  888  888 888888 888888 .d88b.  88888b.        "Y888b.   888888 888  888 888  .d88b.  
# 888  "Y88b 888  888 888    888   d88""88b 888 "88b          "Y88b. 888    888  888 888 d8P  Y8b 
# 888    888 888  888 888    888   888  888 888  888            "888 888    888  888 888 88888888 
# 888   d88P Y88b 888 Y88b.  Y88b. Y88..88P 888  888      Y88b  d88P Y88b.  Y88b 888 888 Y8b.     
# 8888888P"   "Y88888  "Y888  "Y888 "Y88P"  888  888       "Y8888P"   "Y888  "Y88888 888  "Y8888  
#                                                                                888              
#                                                                           Y8b d88P              
#                                                                            "Y88P"               
var base_button_style = stylebox_flat(inherit(
	border_width(DEFAULT_BUTTON_BORDER_WIDTH),
	content_margins(DEFAULT_BUTTON_CORNER_RADIUS),
	corner_radius(DEFAULT_BUTTON_MARGIN)
))

var default_button_style = inherit(base_button_style, {
	bg_color = TRANSPARENT,
	border_color = BASE_BORDER,
})

var default_button_hover_style = inherit(base_button_style, {
	bg_color = OVERLAY_BACKGROUND,
	border_color = BRAND_COLOR.lightened(0.5)
})

var default_button_pressed_style = inherit(base_button_style, {
	bg_color = OVERLAY_BACKGROUND,
	border_color = BRAND_COLOR
})

var brand_button_style = inherit(base_button_style, {
	bg_color = BRAND_COLOR,
	border_color = BRAND_COLOR
})

var brand_button_hover_style = inherit(base_button_style, {
	bg_color = BRAND_HOVER_COLOR,
	border_color = BRAND_HOVER_COLOR
})

var brand_button_pressed_style = inherit(base_button_style, {
	bg_color = BRAND_PRESSED_COLOR,
	border_color = BRAND_PRESSED_COLOR
})

var primary_button_style = inherit(base_button_style, {
	bg_color = PRIMARY_COLOR,
	border_color = PRIMARY_COLOR
})

var primary_button_hover_style = inherit(base_button_style, {
	bg_color = PRIMARY_HOVER_COLOR,
	border_color = PRIMARY_HOVER_COLOR
})

var primary_button_pressed_style = inherit(base_button_style, {
	bg_color = PRIMARY_PRESSED_COLOR,
	border_color = PRIMARY_PRESSED_COLOR
})

var success_button_style = inherit(base_button_style, {
	bg_color = SUCCESS_COLOR,
	border_color = SUCCESS_COLOR
})

var success_button_hover_style = inherit(base_button_style, {
	bg_color = SUCCESS_HOVER_COLOR,
	border_color = SUCCESS_HOVER_COLOR
})

var success_button_pressed_style = inherit(base_button_style, {
	bg_color = SUCCESS_PRESSED_COLOR,
	border_color = SUCCESS_PRESSED_COLOR
})

var warning_button_style = inherit(base_button_style, {
	bg_color = WARNING_COLOR,
	border_color = WARNING_COLOR
})

var warning_button_hover_style = inherit(base_button_style, {
	bg_color = WARNING_HOVER_COLOR,
	border_color = WARNING_HOVER_COLOR
})

var warning_button_pressed_style = inherit(base_button_style, {
	bg_color = WARNING_PRESSED_COLOR,
	border_color = WARNING_PRESSED_COLOR
})

var danger_button_style = inherit(base_button_style, {
	bg_color = DANGER_COLOR,
	border_color = DANGER_COLOR
})

var danger_button_hover_style = inherit(base_button_style, {
	bg_color = DANGER_HOVER_COLOR,
	border_color = DANGER_HOVER_COLOR
})

var danger_button_pressed_style = inherit(base_button_style, {
	bg_color = DANGER_PRESSED_COLOR,
	border_color = DANGER_PRESSED_COLOR
})

var info_button_style = inherit(base_button_style, {
	bg_color = INFO_COLOR,
	border_color = INFO_COLOR
})

var info_button_hover_style = inherit(base_button_style, {
	bg_color = INFO_HOVER_COLOR,
	border_color = INFO_HOVER_COLOR
})

var info_button_pressed_style = inherit(base_button_style, {
	bg_color = INFO_PRESSED_COLOR,
	border_color = INFO_PRESSED_COLOR
})

var default_plain_button_style = inherit(base_button_style, {
	bg_color = TRANSPARENT,
	border_color = BASE_BORDER,
})

var default_plain_button_hover_style = inherit(base_button_style, {
	bg_color = OVERLAY_BACKGROUND,
	border_color = BRAND_COLOR.lightened(0.5)
})

var default_plain_button_pressed_style = inherit(base_button_style, {
	bg_color = OVERLAY_BACKGROUND,
	border_color = BRAND_COLOR
})

var brand_plain_button_style = inherit(base_button_style, {
	bg_color = TRANSPARENT,
	border_color = BRAND_COLOR
})

var brand_plain_button_hover_style = inherit(base_button_style, {
	bg_color = OVERLAY_BACKGROUND,
	border_color = BRAND_HOVER_COLOR
})

var brand_plain_button_pressed_style = inherit(base_button_style, {
	bg_color = OVERLAY_BACKGROUND,
	border_color = BRAND_PRESSED_COLOR
})

var primary_plain_button_style = inherit(base_button_style, {
	bg_color = TRANSPARENT,
	border_color = PRIMARY_COLOR
})

var primary_plain_button_hover_style = inherit(base_button_style, {
	bg_color = OVERLAY_BACKGROUND,
	border_color = PRIMARY_HOVER_COLOR
})

var primary_plain_button_pressed_style = inherit(base_button_style, {
	bg_color = OVERLAY_BACKGROUND,
	border_color = PRIMARY_PRESSED_COLOR
})

var success_plain_button_style = inherit(base_button_style, {
	bg_color = TRANSPARENT,
	border_color = SUCCESS_COLOR
})

var success_plain_button_hover_style = inherit(base_button_style, {
	bg_color = OVERLAY_BACKGROUND,
	border_color = SUCCESS_HOVER_COLOR
})

var success_plain_button_pressed_style = inherit(base_button_style, {
	bg_color = OVERLAY_BACKGROUND,
	border_color = SUCCESS_PRESSED_COLOR
})

var warning_plain_button_style = inherit(base_button_style, {
	bg_color = TRANSPARENT,
	border_color = WARNING_COLOR
})

var warning_plain_button_hover_style = inherit(base_button_style, {
	bg_color = OVERLAY_BACKGROUND,
	border_color = WARNING_HOVER_COLOR
})

var warning_plain_button_pressed_style = inherit(base_button_style, {
	bg_color = OVERLAY_BACKGROUND,
	border_color = WARNING_PRESSED_COLOR
})

var danger_plain_button_style = inherit(base_button_style, {
	bg_color = TRANSPARENT,
	border_color = DANGER_COLOR
})

var danger_plain_button_hover_style = inherit(base_button_style, {
	bg_color = OVERLAY_BACKGROUND,
	border_color = DANGER_HOVER_COLOR
})

var danger_plain_button_pressed_style = inherit(base_button_style, {
	bg_color = OVERLAY_BACKGROUND,
	border_color = DANGER_PRESSED_COLOR
})

var info_plain_button_style = inherit(base_button_style, {
	bg_color = TRANSPARENT,
	border_color = INFO_COLOR
})

var info_plain_button_hover_style = inherit(base_button_style, {
	bg_color = OVERLAY_BACKGROUND,
	border_color = INFO_HOVER_COLOR
})

var info_plain_button_pressed_style = inherit(base_button_style, {
	bg_color = OVERLAY_BACKGROUND,
	border_color = INFO_PRESSED_COLOR
})
#endregion

func setup() -> void:
	set_save_path("res://resources/main_theme.tres")

# 888888b.                              
# 888  "88b                             
# 888  .88P                             
# 8888888K.   8888b.  .d8888b   .d88b.  
# 888  "Y88b     "88b 88K      d8P  Y8b 
# 888    888 .d888888 "Y8888b. 88888888 
# 888   d88P 888  888      X88 Y8b.     
# 8888888P"  "Y888888  88888P'  "Y8888  
func define_theme() -> void:
	define_style("PanelContainer", {
		panel = stylebox_flat(
			inherit(
				{bg_color = PAGE_BACKGROUND},
				content_margins(DEFAULT_CONTENT_MARGIN),
				corner_radius(DEFAULT_CONTENT_CORNER_RADIUS)
			)
		)
	})
	define_style("Panel", {
		panel = stylebox_flat({
			bg_color = PAGE_BACKGROUND
		})
	})

	define_style("BoxContainer", {
	  separation = DEFAULT_SEPARATION
	})
	
	define_style("RichTextLabel", {
		default_color = PRIMARY_TEXT
	})
	
	define_style("MarginContainer", {
		margin_top = DEFAULT_CONTENT_MARGIN,
		margin_right = DEFAULT_CONTENT_MARGIN,
		margin_bottom = DEFAULT_CONTENT_MARGIN,
		margin_left = DEFAULT_CONTENT_MARGIN,
	})

	define_style("Label", {
		font_color = PRIMARY_TEXT
	})
	define_style("LinkButton", {
		font_color = PRIMARY_TEXT,
		font_hover_color = BRAND_HOVER_COLOR,
		font_pressed_color = BRAND_PRESSED_COLOR,
		font_focus_color = BRAND_COLOR,
	})
	
	define_style("Button", {
		normal = brand_button_style,
		hover = brand_button_hover_style,
		pressed = brand_button_pressed_style,
		font_color = PRIMARY_TEXT,
		font_hover_color = PRIMARY_TEXT,
		font_pressed_color = PRIMARY_TEXT,
		font_hover_pressed_color = PRIMARY_TEXT,
		font_focus_color = PRIMARY_TEXT,
	})
	
	define_style("CheckButton", {
		normal = stylebox_empty(content_margins(DEFAULT_BUTTON_MARGIN)),
		hover = stylebox_empty(content_margins(DEFAULT_BUTTON_MARGIN)),
		pressed = stylebox_empty(content_margins(DEFAULT_BUTTON_MARGIN)),
		focus = stylebox_empty(content_margins(DEFAULT_BUTTON_MARGIN)),
		hover_pressed = stylebox_empty(content_margins(DEFAULT_BUTTON_MARGIN)),
	})
	define_style("CheckBox", {
		normal = stylebox_empty(content_margins(DEFAULT_BUTTON_MARGIN)),
		hover = stylebox_empty(content_margins(DEFAULT_BUTTON_MARGIN)),
		pressed = stylebox_empty(content_margins(DEFAULT_BUTTON_MARGIN)),
		focus = stylebox_empty(content_margins(DEFAULT_BUTTON_MARGIN)),
		hover_pressed = stylebox_empty(content_margins(DEFAULT_BUTTON_MARGIN)),
	})

	define_style("LineEdit", {
	  normal = stylebox_flat(inherit({
			bg_color = BASE_BACKGROUND
		},
		content_margins(DEFAULT_BUTTON_MARGIN),
		border_width(DEFAULT_BUTTON_BORDER_WIDTH),
		corner_radius(DEFAULT_BUTTON_CORNER_RADIUS))),
		font_color = PRIMARY_TEXT,
		caret_color = PRIMARY_TEXT,
	})
	
	# ===========================================
	# Variants
	# ===========================================
	# 888888b.            888    888                              
	# 888  "88b           888    888                              
	# 888  .88P           888    888                              
	# 8888888K.  888  888 888888 888888 .d88b.  88888b.  .d8888b  
	# 888  "Y88b 888  888 888    888   d88""88b 888 "88b 88K      
	# 888    888 888  888 888    888   888  888 888  888 "Y8888b. 
	# 888   d88P Y88b 888 Y88b.  Y88b. Y88..88P 888  888      X88 
	# 8888888P"   "Y88888  "Y888  "Y888 "Y88P"  888  888  88888P' 
	define_variant_style("ButtonPrimary", "Button", {
		normal = primary_button_style,
		hover = primary_button_hover_style,
		pressed = primary_button_pressed_style,
	})
	
	define_variant_style("ButtonSuccess", "Button", {
		normal = success_button_style,
		hover = success_button_hover_style,
		pressed = success_button_pressed_style,
	})
	
	define_variant_style("ButtonWarning", "Button", {
		normal = warning_button_style,
		hover = warning_button_hover_style,
		pressed = warning_button_pressed_style,
	})
	
	define_variant_style("ButtonDanger", "Button", {
		normal = danger_button_style,
		hover = danger_button_hover_style,
		pressed = danger_button_pressed_style,
	})
	
	define_variant_style("ButtonInfo", "Button", {
		normal = info_button_style,
		hover = info_button_hover_style,
		pressed = info_button_pressed_style,
	})
	
	define_variant_style("ButtonPrimaryPlain", "Button", {
		normal = primary_plain_button_style,
		hover = primary_plain_button_hover_style,
		pressed = primary_plain_button_pressed_style,
		font_color = PRIMARY_COLOR,
		font_hover_color = PRIMARY_HOVER_COLOR,
		font_pressed_color = PRIMARY_PRESSED_COLOR,
		font_hover_pressed_color = PRIMARY_PRESSED_COLOR,
		font_focus_color = PRIMARY_HOVER_COLOR,
	})
	
	define_variant_style("ButtonSuccessPlain", "Button", {
		normal = success_plain_button_style,
		hover = success_plain_button_hover_style,
		pressed = success_plain_button_pressed_style,
		font_color = SUCCESS_COLOR,
		font_hover_color = SUCCESS_HOVER_COLOR,
		font_pressed_color = SUCCESS_PRESSED_COLOR,
		font_hover_pressed_color = SUCCESS_PRESSED_COLOR,
		font_focus_color = SUCCESS_HOVER_COLOR,
	})
	
	define_variant_style("ButtonWarningPlain", "Button", {
		normal = warning_plain_button_style,
		hover = warning_plain_button_hover_style,
		pressed = warning_plain_button_pressed_style,
		font_color = WARNING_COLOR,
		font_hover_color = WARNING_HOVER_COLOR,
		font_pressed_color = WARNING_PRESSED_COLOR,
		font_hover_pressed_color = WARNING_PRESSED_COLOR,
		font_focus_color = WARNING_HOVER_COLOR,
	})
	
	define_variant_style("ButtonDangerPlain", "Button", {
		normal = danger_plain_button_style,
		hover = danger_plain_button_hover_style,
		pressed = danger_plain_button_pressed_style,
		font_color = DANGER_COLOR,
		font_hover_color = DANGER_HOVER_COLOR,
		font_pressed_color = DANGER_PRESSED_COLOR,
		font_hover_pressed_color = DANGER_PRESSED_COLOR,
		font_focus_color = DANGER_HOVER_COLOR,
	})
	
	define_variant_style("ButtonInfoPlain", "Button", {
		normal = info_plain_button_style,
		hover = info_plain_button_hover_style,
		pressed = info_plain_button_pressed_style,
		font_color = INFO_COLOR,
		font_hover_color = INFO_HOVER_COLOR,
		font_pressed_color = INFO_PRESSED_COLOR,
		font_hover_pressed_color = INFO_PRESSED_COLOR,
		font_focus_color = INFO_HOVER_COLOR,
	})
