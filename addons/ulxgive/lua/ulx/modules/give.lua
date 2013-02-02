-- ULX Give By Seth - owner@diamondbuild.info
function ulx.cc_give( ply, command, argv, args )
	hl2weps = {"weapon_crowbar","weapon_stunstick","weapon_physcannon","weapon_physgun","weapon_pistol","weapon_ttt_ak47","weapon_357","weapon_smg1","weapon_ar2","weapon_shotgun","weapon_crossbow","weapon_annabelle","weapon_frag","weapon_rpg","weapon_slam","weapon_bugbait","item_ml_grenade","item_ar2_grenade","item_ammo_ar2_altfire","item_healthkit","item_healthvial","item_suit","item_battery","gmod_camera","gmod_tool"}
	table.Add(weapons)
	for c , d in pairs(weapons.GetList()) do
		table.insert(weapons , d.ClassName)
	end

			
	local wep = tostring( argv[ 2 ] )
	
	if not argv[ 2 ] then
		ULib.tsay( ply, ulx.LOW_ARGS )
		return
	end

	local targets, err = ULib.getUsers( argv[ 1 ], _, true, ply )
	if not targets then
		ULib.tsay( ply, err )
		return
	end

	for _, v in ipairs( targets ) do
		if not v:Alive() then
			ULib.tsay( ply, v:Nick() .. " is dead!", true )
			return
		end
		if v.ragdoll then
			ULib.tsay( ply, v:Nick() .. " is a ragdoll.", true )
			return
		end	
		if v:InVehicle() then
			ULib.tsay( ply, v:Nick() .. " is in a vehicle.", true )
			return
		end
		if table.HasValue( weapons, wep ) or table.HasValue( hl2weps, wep ) then
			ulx.logUserAct( ply, v, "#A gave " .. wep .. " to #T." )
			v:Give(wep)
		else
			ULib.tsay( ply, wep .. " is not installed on this server.", true )
		end
	end
end
ulx.concommand( "give", ulx.cc_give, "<user>  <weapon>- gives a user the specified weapon", ULib.ACCESS_ADMIN, "!give", _, ulx.ID_PLAYER_HELP )
ulx.addToMenu( ulx.ID_MCLIENT, "give", "ulx give" )