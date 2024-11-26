extends Node

var busNameMaster = "Master"
var busNameMusic = "Music"
var busNameSFX = "SFX"
var language:String = "EN"
var languageId:int = 1:
		get:
			return languageId
		set(value):
			languageId = value
			if languageId == 1:
				language = "EN"
			elif languageId == 0:
				language = "ES"
			print(language)
			
var busIndexMaster = AudioServer.get_bus_index("Master")

var busIndexMusic = AudioServer.get_bus_index("Music")

var busIndexSFX = AudioServer.get_bus_index("SFX")


var volumeMusic:
	get:
		return volumeMusic
	set(value):
		volumeMusic=value
		onChangeVolumeMusic()
var volumeSFX:
	get:
		return volumeSFX
	set(value):
		volumeSFX=value
		onChangeVolumeSFX()
var volumeMaster:
	get:
		return volumeMaster
	set(value):
		volumeMaster=value
		onChangeVolumeMaster()
var vsync: bool:
	get:
		return vsync
	set(value):
		vsync = value
		onChangeVSync()
		


func _ready() -> void:
	
	volumeMaster=1
	volumeMusic=1
	volumeSFX=1
	vsync=false
	
	pass

func onChangeVSync():
	print("Changed VSync")
	if vsync:
		DisplayServer.VSyncMode.VSYNC_ENABLED
	else:
		DisplayServer.VSyncMode.VSYNC_DISABLED
	pass

func onChangeVolumeMaster():
	AudioServer.set_bus_volume_db(busIndexMaster,linear_to_db(volumeMaster))
	pass
	
func onChangeVolumeMusic():
	AudioServer.set_bus_volume_db(busIndexMusic,linear_to_db(volumeMusic))
	pass

func onChangeVolumeSFX():
	AudioServer.set_bus_volume_db(busIndexSFX,linear_to_db(volumeSFX))
	pass
