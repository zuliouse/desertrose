/obj/item/clothing/accessory //Ties moved to neck slot items, but as there are still things like medals and armbands, this accessory system is being kept as-is
	name = "Accessory"
	desc = "Something has gone wrong!"
	icon = 'icons/obj/clothing/accessories.dmi'
	icon_state = "plasma"
	item_state = ""	//no inhands
	item_color = "plasma" //On accessories, this controls the worn sprite. That's a bit weird.
	slot_flags = 0
	w_class = WEIGHT_CLASS_SMALL
	var/above_suit = FALSE
	var/minimize_when_attached = TRUE // TRUE if shown as a small icon in corner, FALSE if overlayed
	var/datum/component/storage/detached_pockets

/obj/item/clothing/accessory/proc/attach(obj/item/clothing/under/U, user)
	GET_COMPONENT(storage, /datum/component/storage)
	if(storage)
		if(SEND_SIGNAL(U, COMSIG_CONTAINS_STORAGE))
			return FALSE
		U.TakeComponent(storage)
		detached_pockets = storage
	U.attached_accessory = src
	forceMove(U)
	layer = FLOAT_LAYER
	plane = FLOAT_PLANE
	if(minimize_when_attached)
		transform *= 0.5	//halve the size so it doesn't overpower the under
		pixel_x += 8
		pixel_y -= 8
	U.add_overlay(src)

	if (islist(U.armor) || isnull(U.armor)) 										// This proc can run before /obj/Initialize has run for U and src,
		U.armor = getArmor(arglist(U.armor))	// we have to check that the armor list has been transformed into a datum before we try to call a proc on it
																					// This is safe to do as /obj/Initialize only handles setting up the datum if actually needed.
	if (islist(armor) || isnull(armor))
		armor = getArmor(arglist(armor))

	U.armor = U.armor.attachArmor(armor)

	if(isliving(user))
		on_uniform_equip(U, user)

	return TRUE

/obj/item/clothing/accessory/proc/detach(obj/item/clothing/under/U, user)
	if(detached_pockets && detached_pockets.parent == U)
		TakeComponent(detached_pockets)

	U.armor = U.armor.detachArmor(armor)

	if(isliving(user))
		on_uniform_dropped(U, user)

	if(minimize_when_attached)
		transform *= 2
		pixel_x -= 8
		pixel_y += 8
	layer = initial(layer)
	plane = initial(plane)
	U.cut_overlays()
	U.attached_accessory = null
	U.accessory_overlay = null

/obj/item/clothing/accessory/proc/on_uniform_equip(obj/item/clothing/under/U, user)
	return

/obj/item/clothing/accessory/proc/on_uniform_dropped(obj/item/clothing/under/U, user)
	return

/obj/item/clothing/accessory/AltClick(mob/user)
	if(istype(user) && user.canUseTopic(src, BE_CLOSE, ismonkey(user)))
		if(initial(above_suit))
			above_suit = !above_suit
			to_chat(user, "[src] will be worn [above_suit ? "above" : "below"] your suit.")

/obj/item/clothing/accessory/examine(mob/user)
	..()
	to_chat(user, "<span class='notice'>\The [src] can be attached to a uniform. Alt-click to remove it once attached.</span>")
	if(initial(above_suit))
		to_chat(user, "<span class='notice'>\The [src] can be worn above or below your suit. Alt-click to toggle.</span>")

/obj/item/clothing/accessory/waistcoat
	name = "waistcoat"
	desc = "For some classy, murderous fun."
	icon_state = "waistcoat"
	item_state = "waistcoat"
	item_color = "waistcoat"
	minimize_when_attached = FALSE

/obj/item/clothing/accessory/maidapron
	name = "maid apron"
	desc = "The best part of a maid costume."
	icon_state = "maidapron"
	item_state = "maidapron"
	item_color = "maidapron"
	minimize_when_attached = FALSE


//Ranks

/obj/item/clothing/accessory/ncr
    name = "(O-6) Colonel rank pin"
    desc = "An officer holding the rank of Colonel should wear these."
    icon_state = "colonelrank"
    item_color = "colonelrank"
    minimize_when_attached = TRUE

/obj/item/clothing/accessory/ncr/CPT
    name = "(O-3) Captain rank pin"
    desc = "An officer holding the rank of Captain should wear this."
    icon_state = "captainrank"
    item_color = "captainrank"
    minimize_when_attached = TRUE

/obj/item/clothing/accessory/ncr/LT
    name = "(O-1) Lieutenant rank pin"
    desc = "An officer holding the rank of Lieutenant should wear this."
    icon_state = "lieutenantrank"
    item_color = "lieutenantrank"
    minimize_when_attached = TRUE

/obj/item/clothing/accessory/armband/med/ncr
	name = "medical armband (O-1 Medical Officer)"
	desc = "An armband worn by NCR Medical Officers to diplay their rank and specialty. This one is white."

/obj/item/clothing/accessory/ncr/SSGT
    name = "(E-6) Staff Sergeant rank pins"
    desc = "A trooper holding the rank of Staff Sergeant should wear this."
    icon_state = "ncrenlisted"
    item_color = "ncrenlisted"
    minimize_when_attached = TRUE

/obj/item/clothing/accessory/ncr/SGT
    name = "(E-5) Sergeant rank pins"
    desc = "A trooper holding the rank of Sergeant should wear this."
    icon_state = "ncrenlisted"
    item_color = "ncrenlisted"
    minimize_when_attached = TRUE

/obj/item/clothing/accessory/armband/engine/ncr
    name = "engineering armband (E-5 Engineer)"
    desc = "An armband worn by NCR Engineers to display their rank and speciality. This one is orange with a reflective strip!"

/obj/item/clothing/accessory/ncr/CPL
    name = "(E-4) Corporal rank pins"
    desc = "A Corporal should wear this."
    icon_state = "ncrenlisted"
    item_color = "ncrenlisted"
    minimize_when_attached = TRUE

/obj/item/clothing/accessory/ncr/SPC
    name = "(E-4) Corporal rank pins"
    desc = "A Corporal should wear this."
    icon_state = "ncrenlisted"
    item_color = "ncrenlisted"
    minimize_when_attached = TRUE

/obj/item/clothing/accessory/ncr/TPR
    name = "(E-3) Trooper rank pins"
    desc = "A trooper should wear this."
    icon_state = "ncrenlisted"
    item_color = "ncrenlisted"
    minimize_when_attached = TRUE

/obj/item/clothing/accessory/ncr/REC
    name = "(E-2) Recruit rank pins"
    desc = "A recruit should wear this."
    icon_state = "ncrenlisted"
    item_color = "ncrenlisted"
    minimize_when_attached = TRUE

//BOSRanks

/obj/item/clothing/accessory/bos/initiateK
    name = "Knight-Aspirant pin"
    desc = "A silver pin with blue cloth, worn by Initiates aspiring to be Knights."
    icon_state = "initiateK"
    item_color = "initiateK"
    minimize_when_attached = TRUE

/obj/item/clothing/accessory/bos/initiateS
    name = "Scribe-Aspirant pin"
    desc = "A silver pin with red cloth, worn by Initiates aspiring to be Scribes."
    icon_state = "initiateS"
    item_color = "initiateS"
    minimize_when_attached = TRUE

/obj/item/clothing/accessory/bos/knight
    name = "Knight pins"
    desc = "A silver pin with one device and blue coloring, worn by fully fledged Knights of the Brotherhood."
    icon_state = "knight"
    item_color = "knight"
    minimize_when_attached = TRUE

/obj/item/clothing/accessory/bos/scribe
    name = "Scribe pins"
    desc = "A silver pin with one device and red coloring, worn by fully fledged Scribes of the Brotherhood."
    icon_state = "scribe"
    item_color = "scribe"
    minimize_when_attached = TRUE

/obj/item/clothing/accessory/bos/juniorpaladin
    name = "Junior Paladin pins"
    desc = "A silver pin with one device, and purple coloring. Worn by the Paladin-in-Training of the Brotherhood."
    icon_state = "juniorpaladin"
    item_color = "juniorpaladin"
    minimize_when_attached = TRUE

/obj/item/clothing/accessory/bos/knightcaptain
    name = "Knight-Captain pins"
    desc = "A silver pin with one device, a silver sword centered on the blue coloring, and notches denoting the rank of the Knight-Captain."
    icon_state = "knight-captain"
    item_color = "knight-captain"
    minimize_when_attached = TRUE

/obj/item/clothing/accessory/bos/seniorscribe
    name = "Senior Scribe pins"
    desc = "A silver pin with one device, a silver sword centered on the red coloring, and notches denoting the rank of the Senior Scribe."
    icon_state = "seniorscribe"
    item_color = "seniorscribe"
    minimize_when_attached = TRUE

/obj/item/clothing/accessory/bos/paladin
    name = "Paladin pins"
    desc = "A silver pin with one device, a silver sword centered on the blue coloring, and notches denoting the rank of the Paladin."
    icon_state = "paladin"
    item_color = "paladin"
    minimize_when_attached = TRUE

/obj/item/clothing/accessory/bos/seniorpaladin
    name = "Senior Paladin pins"
    desc = "A silver pin with one device gilded in gold, little notches at the top end, and a golden sword in the center of purple cloth; worn by the high-ranking Senior Paladin."
    icon_state = "seniorpaladin"
    item_color = "seniorpaladin"
    minimize_when_attached = TRUE

/obj/item/clothing/accessory/bos/headscribe
    name = "Head-Scribe pins"
    desc = "A gold-plated, silver lined pin with one device and two outstretched wings on the side; a golden sword centered on red-cloth. Worn by the Head Scribe."
    icon_state = "headscribe"
    item_color = "headscribe"
    minimize_when_attached = TRUE

/obj/item/clothing/accessory/bos/sentinel
    name = "Sentinel pins"
    desc = "A gold-plated, silver lined pin with one device and two outstretched wings on the side; a golden sword centered on purple-cloth. Worn by the Sentinel."
    icon_state = "sentinel"
    item_color = "sentinel"
    minimize_when_attached = TRUE

/obj/item/clothing/accessory/bos/elder
    name = "Elder pins"
    desc = "A gold-plated, silver lined pin with one device and two outstretched wings on the side; a golden sword centered on green-cloth. It bears notches with gems on the top half, and denotes the rank of Elder."
    icon_state = "elder"
    item_color = "elder"
    minimize_when_attached = TRUE
//Medals

/obj/item/clothing/accessory/medal
	name = "bronze medal"
	desc = "A bronze medal."
	icon_state = "bronze"
	item_color = "bronze"
	materials = list(MAT_METAL=1000)
	resistance_flags = FIRE_PROOF
	var/medaltype = "medal" //Sprite used for medalbox
	var/commended = FALSE

//Pinning medals on people
/obj/item/clothing/accessory/medal/attack(mob/living/carbon/human/M, mob/living/user)
	if(ishuman(M) && (user.a_intent == INTENT_HELP))

		if(M.wear_suit)
			if((M.wear_suit.flags_inv & HIDEJUMPSUIT)) //Check if the jumpsuit is covered
				to_chat(user, "<span class='warning'>Medals can only be pinned on jumpsuits.</span>")
				return

		if(M.w_uniform)
			var/obj/item/clothing/under/U = M.w_uniform
			var/delay = 20
			if(user == M)
				delay = 0
			else
				user.visible_message("[user] is trying to pin [src] on [M]'s chest.", \
									 "<span class='notice'>You try to pin [src] on [M]'s chest.</span>")
			var/input
			if(!commended && user != M)
				input = stripped_input(user,"Please input a reason for this commendation, it will be recorded by Vault-Tec.", ,"", 140)
			if(do_after(user, delay, target = M))
				if(U.attach_accessory(src, user, 0)) //Attach it, do not notify the user of the attachment
					if(user == M)
						to_chat(user, "<span class='notice'>You attach [src] to [U].</span>")
					else
						user.visible_message("[user] pins \the [src] on [M]'s chest.", \
											 "<span class='notice'>You pin \the [src] on [M]'s chest.</span>")
						if(input)
							SSblackbox.record_feedback("associative", "commendation", 1, list("commender" = "[user.real_name]", "commendee" = "[M.real_name]", "medal" = "[src]", "reason" = input))
							GLOB.commendations += "[user.real_name] awarded <b>[M.real_name]</b> the <span class='medaltext'>[name]</span>! \n- [input]"
							commended = TRUE
							desc += "<br>The inscription reads: [input] - [user.real_name]"
							log_game("<b>[key_name(M)]</b> was given the following commendation by <b>[key_name(user)]</b>: [input]")
							message_admins("<b>[key_name(M)]</b> was given the following commendation by <b>[key_name(user)]</b>: [input]")

		else
			to_chat(user, "<span class='warning'>Medals can only be pinned on jumpsuits!</span>")
	else
		..()

/obj/item/clothing/accessory/medal/conduct
	name = "distinguished conduct medal"
	desc = "A bronze medal awarded for distinguished conduct. Whilst a great honor, this is the most basic award given by Vault-Tec. It is often awarded by a captain to a member of his crew."

/obj/item/clothing/accessory/medal/bronze_heart
	name = "bronze heart medal"
	desc = "A bronze heart-shaped medal awarded for sacrifice. It is often awarded posthumously or for severe injury in the line of duty."
	icon_state = "bronze_heart"

/obj/item/clothing/accessory/medal/ribbon
	name = "ribbon"
	desc = "A ribbon"
	icon_state = "cargo"
	item_color = "cargo"

/obj/item/clothing/accessory/medal/ribbon/cargo
	name = "\"cargo tech of the shift\" award"
	desc = "An award bestowed only upon those cargotechs who have exhibited devotion to their duty in keeping with the highest traditions of Cargonia."

/obj/item/clothing/accessory/medal/silver
	name = "silver medal"
	desc = "A silver medal."
	icon_state = "silver"
	item_color = "silver"
	medaltype = "medal-silver"
	materials = list(MAT_SILVER=1000)

/obj/item/clothing/accessory/medal/silver/valor
	name = "medal of valor"
	desc = "A silver medal awarded for acts of exceptional valor."

/obj/item/clothing/accessory/medal/silver/security
	name = "robust security award"
	desc = "An award for distinguished combat and sacrifice in defence of Vault-Tec's commercial interests. Often awarded to security staff."

/obj/item/clothing/accessory/medal/gold
	name = "gold medal"
	desc = "A prestigious golden medal."
	icon_state = "gold"
	item_color = "gold"
	medaltype = "medal-gold"
	materials = list(MAT_GOLD=1000)

/obj/item/clothing/accessory/medal/gold/captain
	name = "medal of captaincy"
	desc = "A golden medal awarded exclusively to those promoted to the rank of captain. It signifies the codified responsibilities of a captain, and their undisputable authority over their crew."
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF

/obj/item/clothing/accessory/medal/gold/heroism
	name = "medal of exceptional heroism"
	desc = "An extremely rare golden medal awarded only by CentCom. To receive such a medal is the highest honor and as such, very few exist. This medal is almost never awarded to anybody but commanders."

/obj/item/clothing/accessory/medal/plasma
	name = "ultracite medal"
	desc = "An eccentric medal made of ultracite."
	icon_state = "plasma"
	item_color = "plasma"
	medaltype = "medal-plasma"
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = -10, "acid" = 0) //It's made of plasma. Of course it's flammable.
	materials = list(MAT_PLASMA=1000)

/obj/item/clothing/accessory/medal/plasma/temperature_expose(datum/gas_mixture/air, exposed_temperature, exposed_volume)
	if(exposed_temperature > 300)
		atmos_spawn_air("plasma=20;TEMP=[exposed_temperature]")
		visible_message("<span class='danger'> \The [src] bursts into flame!</span>","<span class='userdanger'>Your [src] bursts into flame!</span>")
		qdel(src)

/obj/item/clothing/accessory/medal/plasma/nobel_science
	name = "nobel sciences award"
	desc = "A plasma medal which represents significant contributions to the field of science or engineering."


////////////
//Armbands//
////////////

/obj/item/clothing/accessory/armband
	name = "red armband"
	desc = "A fancy red armband!"
	icon_state = "redband"
	item_color = "redband"

/obj/item/clothing/accessory/armband/white
	name = "armband"
	desc = "A fancy armband!"
	icon_state = "whiteband"
	item_color = "whiteband"

/obj/item/clothing/accessory/armband/deputy
	name = "security deputy armband"
	desc = "An armband, worn by personnel authorized to act as a deputy of vault security."

/obj/item/clothing/accessory/armband/cargo
	name = "cargo bay guard armband"
	desc = "An armband, worn by the vault's security forces to display which department they're assigned to. This one is brown."
	icon_state = "cargoband"
	item_color = "cargoband"

/obj/item/clothing/accessory/armband/engine
	name = "engineering guard armband"
	desc = "An armband, worn by the vault's security forces to display which department they're assigned to. This one is orange with a reflective strip!"
	icon_state = "engieband"
	item_color = "engieband"

/obj/item/clothing/accessory/armband/science
	name = "science guard armband"
	desc = "An armband, worn by the vault's security forces to display which department they're assigned to. This one is purple."
	icon_state = "rndband"
	item_color = "rndband"

/obj/item/clothing/accessory/armband/hydro
	name = "hydroponics guard armband"
	desc = "An armband, worn by the vault's security forces to display which department they're assigned to. This one is green and blue."
	icon_state = "hydroband"
	item_color = "hydroband"

/obj/item/clothing/accessory/armband/med
	name = "medical guard armband"
	desc = "An armband, worn by the vault's security forces to display which department they're assigned to. This one is white."
	icon_state = "medband"
	item_color = "medband"

/obj/item/clothing/accessory/armband/medblue
	name = "first aid armband"
	desc = "An armband, worn NCR troopers who are trained in and can perform first aid."
	icon_state = "medblueband"
	item_color = "medblueband"

//////////////
//OBJECTION!//
//////////////

/obj/item/clothing/accessory/lawyers_badge
	name = "attorney's badge"
	desc = "Fills you with the conviction of JUSTICE. Lawyers tend to want to show it to everyone they meet."
	icon_state = "lawyerbadge"
	item_color = "lawyerbadge"

/obj/item/clothing/accessory/lawyers_badge/on_uniform_equip(obj/item/clothing/under/U, user)
	var/mob/living/L = user
	if(L)
		L.bubble_icon = "lawyer"

/obj/item/clothing/accessory/lawyers_badge/on_uniform_dropped(obj/item/clothing/under/U, user)
	var/mob/living/L = user
	if(L)
		L.bubble_icon = initial(L.bubble_icon)

////////////////
//HA HA! NERD!//
////////////////
/obj/item/clothing/accessory/pocketprotector
	name = "pocket protector"
	desc = "Can protect your clothing from ink stains, but you'll look like a nerd if you're using one."
	icon_state = "pocketprotector"
	item_color = "pocketprotector"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/pocketprotector

/obj/item/clothing/accessory/pocketprotector/full/Initialize()
	. = ..()
	new /obj/item/pen/red(src)
	new /obj/item/pen(src)
	new /obj/item/pen/blue(src)

/obj/item/clothing/accessory/pocketprotector/cosmetology/Initialize()
	. = ..()
	for(var/i in 1 to 3)
		new /obj/item/lipstick/random(src)

////////////////
//OONGA BOONGA//
////////////////

/obj/item/clothing/accessory/talisman
	name = "bone talisman"
	desc = "A hunter's talisman, some say the old gods smile on those who wear it."
	icon_state = "talisman"
	item_color = "talisman"
	armor = list("melee" = 5, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 25)

/obj/item/clothing/accessory/skullcodpiece
	name = "skull codpiece"
	desc = "A skull shaped ornament, intended to protect the important things in life."
	icon_state = "skull"
	item_color = "skull"
	above_suit = TRUE
	armor = list("melee" = 5, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 25)
