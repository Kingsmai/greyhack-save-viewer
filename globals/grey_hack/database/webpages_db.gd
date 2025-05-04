class_name WebPagesDB extends Node

static func load_web_pages() -> Array[WebPage]:
	var web_pages: Array[WebPage] = []
	var query_result = SaveData.select_rows("WebPages", "", [
		"Web",
		"ExternalPort",
		"PublicIp",
		"LocalIp",
		"Address",
		"TypeNet"
	])
	for row in query_result:
		var new_web_page = WebPage.new()
		new_web_page.web_content = row["Web"]
		new_web_page.public_ip = row["PublicIp"]
		new_web_page.external_port = row["ExternalPort"]
		new_web_page.local_ip = row["LocalIp"]
		new_web_page.address = row["Address"]
		new_web_page.type_net = row["TypeNet"]
		web_pages.append(new_web_page)
	return web_pages
