class_name LibraryType extends RefCounted

enum Type {
	LIB_SSH,
	LIB_FTP,
	LIB_HTTP,
	LIB_SQL,
	LIB_SMTP,
	LIB_CHAT,
	LIB_CAM,
	LIB_RSHELL,
	LIB_REPOSITORY,
	BLOCKCHAIN,
	LIB_ADB,
	LIB_SMART_APPLIANCE,
	KERNEL_ROUTER,
	APT_CLIENT,
	METAXPLOIT,
	CRYPTO,
	KERNEL_MODULE,
	INIT,
	NET,
	LIB_TRAFFIC_NET
}

static func translate(type: Type) -> String:
	var rs = ""
	match type:
		Type.LIB_SSH            : rs = "libssh.so"
		Type.LIB_FTP            : rs = "libftp.so"
		Type.LIB_HTTP           : rs = "libhttp.so"
		Type.LIB_SQL            : rs = "libsql.so"
		Type.LIB_SMTP           : rs = "libsmtp.so"
		Type.LIB_CHAT           : rs = "libchat.so"
		Type.LIB_CAM            : rs = "libcam.so"
		Type.LIB_RSHELL         : rs = "librshell.so"
		Type.LIB_REPOSITORY     : rs = "librepository.so"
		Type.BLOCKCHAIN         : rs = "blockchain.so"
		Type.LIB_ADB            : rs = "libadb.so"
		Type.LIB_SMART_APPLIANCE: rs = "libsmartappliance.so"
		Type.KERNEL_ROUTER      : rs = "kernel_router.so"
		Type.APT_CLIENT         : rs = "aptclient.so"
		Type.METAXPLOIT         : rs = "metaxploit.so"
		Type.CRYPTO             : rs = "crypto.so"
		Type.KERNEL_MODULE      : rs = "kernel_module.so"
		Type.INIT               : rs = "init.so"
		Type.NET                : rs = "net.so"
		Type.LIB_TRAFFIC_NET    : rs = "libtrafficnet.so"
		_                       : rs = "unknown"
	return rs

static func translate_for_exploit(type: Type) -> String:
	var rs = ""
	match type:
		Type.LIB_SSH            : rs = "e_ssh"
		Type.LIB_FTP            : rs = "e_ftp"
		Type.LIB_HTTP           : rs = "e_http"
		Type.LIB_SQL            : rs = "e_sql"
		Type.LIB_SMTP           : rs = "e_smtp"
		Type.LIB_CHAT           : rs = "e_chat"
		Type.LIB_CAM            : rs = "e_cam"
		Type.LIB_RSHELL         : rs = "e_rsh"
		Type.LIB_REPOSITORY     : rs = "e_repo"
		Type.BLOCKCHAIN         : rs = "e_bchain"
		Type.LIB_ADB            : rs = "e_adb"
		Type.LIB_SMART_APPLIANCE: rs = "e_smap"           # smart appliance 缩写
		Type.KERNEL_ROUTER      : rs = "e_kroute"         # kernel router
		Type.APT_CLIENT         : rs = "e_aptcli"
		Type.METAXPLOIT         : rs = "e_mxp"            # metaxploit 缩写
		Type.CRYPTO             : rs = "e_crypto"
		Type.KERNEL_MODULE      : rs = "e_kmod"
		Type.INIT               : rs = "e_init"
		Type.NET                : rs = "e_net"
		Type.LIB_TRAFFIC_NET    : rs = "e_trafnet"
		_                       : rs = "e_unknown"
	return rs
