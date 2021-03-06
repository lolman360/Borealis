/**
  * Simple data container component containing level up statistics.
  * This does NOT make something a valid inspiration. It simply holds the data in case it gets used as one!
  * To actually use it, the typepath of the object has to be contained within the sanity datum valid_inspiration list.
  * Assign this component to an item specifying which statistics should be levelled up, and the item will be able to be used as an inspiration.
  * The format of statistics is list(STAT_DEFINE = number) or a proc that returns such a list.
  * (This would've been better as an element instead of a component, but currently elements don't exist on cev eris. F)
*/

/datum/component/inspiration
	/// Simple list defined as list(STAT_DEFINE = number).
	var/list/stats
	/// Callback used for dynamic calculation of the stats to level up, used if stats is null. It must accept NO arguments, and it needs to return a list shaped like stats.
	var/datum/callback/get_stats
	//perk
	var/datum/perk/perk

/// Statistics can be a list (static) or a callback to a proc that returns a list (of the same format)
/datum/component/inspiration/Initialize(statistics, datum/perk/new_perk)
	if(!istype(parent, /obj/item))
		return COMPONENT_INCOMPATIBLE
	if(islist(statistics))
		stats = statistics
	else if(istype(statistics, /datum/callback))
		get_stats = statistics
	else
		return COMPONENT_INCOMPATIBLE
	var/obj/item/oddity/father = parent
	perk = father.perk
	get_power()

/datum/component/inspiration/RegisterWithParent()
	RegisterSignal(parent, COMSIG_EXAMINE, .proc/on_examine)

/datum/component/inspiration/proc/on_examine(mob/user)
	var/strength
	switch(get_power())
		if(1)
			strength = "a weak mechanical catalyst power"
		if(2)
			strength = "a normal mechanical catalyst power"
		if(3)
			strength = "a medium mechanical catalyst power"
		if(4)
			strength = "a strong mechanical catalyst power"
		else
			strength = "no catalyst power"
	to_chat(user, SPAN_NOTICE("This item has [strength]"))

/// Returns stats if defined, otherwise it returns the return value of get_stats
/datum/component/inspiration/proc/calculate_statistics()
	if(stats)
		return stats
	else
		return get_stats.Invoke()

/datum/component/inspiration/proc/get_power() // used to determine how powerful the artifact is for the matterforge
	var/power = 0
	if(perk)
		var/list/L = calculate_statistics()
		switch(L[STAT_MEC])
			if(1 to 3)
				power = 1
			if(3 to 5)
				power = 2
			if(5 to 7)
				power = 3
			if(7 to INFINITY)
				power = 4
	return power