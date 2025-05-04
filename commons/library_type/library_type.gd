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
		Type.BLOCKCHAIN         : rs = "libblockchain.so"
		Type.LIB_ADB            : rs = "libadb.so"
		Type.LIB_SMART_APPLIANCE: rs = "libsmartappliance.so"
		Type.KERNEL_ROUTER      : rs = "libkernelrouter.so"
		Type.APT_CLIENT         : rs = "libaptclient.so"
		Type.METAXPLOIT         : rs = "libmetaxploit.so"
		Type.CRYPTO             : rs = "libcrypto.so"
		Type.KERNEL_MODULE      : rs = "libkernelmodule.so"
		Type.INIT               : rs = "libinit.so"
		Type.NET                : rs = "libnet.so"
		Type.LIB_TRAFFIC_NET    : rs = "libtrafficnet.so"
		_                       : rs = "unknown"
	return rs

		
