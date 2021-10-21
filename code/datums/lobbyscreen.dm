// see /datum/interface/new_player/buildUI()
// NOTES:
// music files should be in ogg extention

/hook/startup/proc/initLobbyScreen()
	var/list/variations = subtypesof(/datum/lobbyscreen)
	var/datum/lobbyscreen/LS = pick(variations)
	GLOB.lobbyScreen = new LS()
	return 1

/datum/lobbyscreen
	var/image_file
	// insert songs in this list, not into var/musicTrack
	var/list/possibleMusic = list()
	// this var exist so all players will hear one song
	var/musicTrack

/datum/lobbyscreen/New()
	if(!length(possibleMusic) || !image_file)
		crash_with("Login screen setup is wrong.")
	musicTrack = pick(possibleMusic)
	return ..()

/datum/lobbyscreen/ship
	image_file = 'icons/title_screens/ship.png'
	possibleMusic = list(
		'sound/music/lobby/Blank_Banshee-Chlorine.ogg',
		'sound/music/lobby/Lone-Lying_In_The_Reeds.ogg',
		'sound/music/lobby/Machinedrum-Now_U_Know_Tha_Deal_4_Real.ogg',
		'sound/music/lobby/Blank_Banshee-Frozen_Flame.ogg',
		'sound/music/lobby/VEKTROID-Featherskull_Feat.Betamaxx.ogg'
		)


/datum/lobbyscreen/enroute
	image_file = 'icons/title_screens/transit.gif'
	possibleMusic = list(
		'sound/music/lobby/Blank_Banshee-Chlorine.ogg',
		'sound/music/lobby/Lone-Lying_In_The_Reeds.ogg',
		'sound/music/lobby/Machinedrum-Now_U_Know_Tha_Deal_4_Real.ogg',
		'sound/music/lobby/Blank_Banshee-Frozen_Flame.ogg',
		'sound/music/lobby/VEKTROID-Featherskull_Feat.Betamaxx.ogg'
		)

/datum/lobbyscreen/ironhammer
	image_file = 'icons/title_screens/ironhammer.jpg'
	possibleMusic = list(
		'sound/music/lobby/Blank_Banshee-Chlorine.ogg',
		'sound/music/lobby/Lone-Lying_In_The_Reeds.ogg',
		'sound/music/lobby/Machinedrum-Now_U_Know_Tha_Deal_4_Real.ogg',
		'sound/music/lobby/Blank_Banshee-Frozen_Flame.ogg',
		'sound/music/lobby/VEKTROID-Featherskull_Feat.Betamaxx.ogg'
		)


/datum/lobbyscreen/onestar
	image_file = 'icons/title_screens/onestar.png'
	possibleMusic = list(
		'sound/music/lobby/Blank_Banshee-Chlorine.ogg',
		'sound/music/lobby/Lone-Lying_In_The_Reeds.ogg',
		'sound/music/lobby/Machinedrum-Now_U_Know_Tha_Deal_4_Real.ogg',
		'sound/music/lobby/Blank_Banshee-Frozen_Flame.ogg',
		'sound/music/lobby/VEKTROID-Featherskull_Feat.Betamaxx.ogg'
		)

/datum/lobbyscreen/neotheology
	image_file = 'icons/title_screens/neotheology.png'
	possibleMusic = list(
		'sound/music/lobby/Blank_Banshee-Chlorine.ogg',
		'sound/music/lobby/Lone-Lying_In_The_Reeds.ogg',
		'sound/music/lobby/Machinedrum-Now_U_Know_Tha_Deal_4_Real.ogg',
		'sound/music/lobby/Blank_Banshee-Frozen_Flame.ogg',
		'sound/music/lobby/VEKTROID-Featherskull_Feat.Betamaxx.ogg'
		)

/datum/lobbyscreen/proc/play_music(client/C)
	if(!musicTrack)
		return
	if(C.get_preference_value(/datum/client_preference/play_lobby_music) == GLOB.PREF_YES)
		sound_to(C, sound(musicTrack, repeat = 5, wait = 0, volume = 85, channel = GLOB.lobby_sound_channel))

/datum/lobbyscreen/proc/stop_music(client/C)
	if(!musicTrack)
		return
	sound_to(C, sound(null, repeat =5, wait = 0, volume = 85, channel = GLOB.lobby_sound_channel))


/datum/lobbyscreen/proc/show_titlescreen(client/C)
	winset(C, "lobbybrowser", "is-disabled=false;is-visible=true")
	C << browse(image_file, "file=titlescreen.png;display=0")
	C << browse(file('html/lobby_titlescreen.html'), "window=lobbybrowser")

/datum/lobbyscreen/proc/hide_titlescreen(client/C)
	if(C.mob) // Check if the client is still connected to something
		// Hide title screen, allowing player to see the map
		winset(C, "lobbybrowser", "is-disabled=true;is-visible=false")

