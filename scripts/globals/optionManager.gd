extends Node
#variables
var flagMenuPausa
var volumenMusic
var volumenSFX
var volumenMaster
var vsync: bool:
	get:
		return vsync
	set(value):
		vsync = value
		onChangeVSync()



func onChangeVSync():
	if vsync:
		DisplayServer.VSyncMode.VSYNC_ENABLED
	else:
		DisplayServer.VSyncMode.VSYNC_DISABLED
	pass
