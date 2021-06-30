/mob/living/carbon/superior_animal/fungi/hear_say(var/message, var/verb = "says", var/datum/language/language = null, var/alt_name = "", var/italics = 0, var/mob/speaker = null, var/sound/speech_sound, var/sound_vol, speech_volume)
	..()
	if(speaker in friends) // Is the one talking a friend?
		if(message == "Follow." && !following) // Is he telling us to follow?
			following = speaker
			visible_emote("says, \"I follow friend, [speaker.name].\"")

		if(message == "Stop." && following) // Else, is he telling us to stop?
			following = null
			visible_emote("says, \"I stop follow friend.\"")

/mob/living/carbon/superior_animal/fungi/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if(istype(W, /obj/item/weapon/reagent_containers/food/snacks))

		// Not overfeed the shroom
		if(nutrition >= max_nutrition * 0.9)
			to_chat(user, "The [name] is stuffed full.")
			return
		var/obj/item/weapon/reagent_containers/food/snacks/S = W
		for(var/datum/reagent/organic/nutriment/N in S.reagents.reagent_list)
			src.adjustNutrition(N.nutriment_factor * N.volume)
		user.visible_message(
							"[user] feed [src.name] the [S.name].",
							"You feed [src.name] the [S.name]."
							)
		qdel(W)
		return
	..()