/obj/item/gun/projectile/boltgun/lever
	name = "\"Armstrong\" repeater rifle"
	desc = "Weapon for hunting, or endless open plains. Perfect for horseback!"
	icon = 'icons/obj/guns/projectile/lever.dmi'
	icon_state = "lever"
	item_state = "lever"
	slot_flags = SLOT_BELT|SLOT_BACK
	force = WEAPON_FORCE_PAINFUL
	caliber = CAL_MAGNUM
	max_shells = 11
	price_tag = 650
	recoil_buildup = 10
	damage_multiplier = 0.9
	penetration_multiplier  = 1.1
	extra_damage_mult_scoped = 0.2 //scoping this should be rewarded its not that good
	matter = list(MATERIAL_STEEL = 25, MATERIAL_WOOD = 10, MATERIAL_PLASTEEL = 5)
	sawn = /obj/item/gun/projectile/boltgun/sawn/lever


/obj/item/gun/projectile/boltgun/sawn/lever
	name = "\"obrez\" repeater"
	desc = "A mangled, cut-down \"Armstrong\" repeater. Rifle was fine."
	icon = 'icons/obj/guns/projectile/sawnoff/lever.dmi'
	icon_state = "lever"
	item_state = "lever"
	caliber = CAL_MAGNUM
	matter = list(MATERIAL_STEEL = 15, MATERIAL_PLASTEEL = 5)

/obj/item/gun/projectile/boltgun/lever/bolt_act()
	..()
	if(!silenced) //silenced sprites look weird, also why would you do do a visible_message+gun sound with a silenced gun
		visible_message(SPAN_NOTICE("\The [usr] spins \the [src] as they work the lever!"))
		playsound(src.loc, 'sound/weapons/revolver_spin.ogg', 100, 1)
