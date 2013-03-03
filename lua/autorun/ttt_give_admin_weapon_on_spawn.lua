function giveWeapon( ply )
    if ply:Team() == 1 then
	
		if ply:IsUserGroup("owner") then
            ply:Give("weapon_zm_revolver")
            ply:Give("weapon_ttt_m16")
            ply:Give("weapon_admin_goldsmokegrenade")
            ply:Give("weapon_admin_health_station")
		end
		
        if ply:IsSuperAdmin() then
            ply:Give("weapon_zm_revolver")
            ply:Give("weapon_ttt_m16")
            ply:Give("weapon_admin_goldsmokegrenade")
            ply:Give("weapon_admin_health_station")
        end
		
        if ply:IsAdmin() then
            ply:Give("weapon_zm_revolver")
            ply:Give("weapon_ttt_m16")
            ply:Give("weapon_admin_goldsmokegrenade")
        end
		
		if ply:IsUserGroup("bronze") then
			ply:Give("weapon_ttt_glock")
		end
		
		if ply:IsUserGroup("silver") then
			ply:Give("weapon_zm_revolver")
		end
		
		if ply:IsUserGroup("gold") then
			ply:Give("weapon_zm_revolver")
			ply:Give("weapon_zm_shotgun")
		end
		
		if ply:IsUserGroup("platinum") then
			ply:Give("weapon_zm_revolver")
			ply:Give("weapon_zm_shotgun")
			ply:Give("weapon_ttt_redsmokegrenade")
		end
		
    end
end
hook.Add("PlayerSpawn", "giverankedWeapon", giveWeapon)