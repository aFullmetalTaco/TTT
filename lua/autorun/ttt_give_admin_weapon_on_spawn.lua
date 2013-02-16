function giveWeapon( ply )
    if ply:Team() == 1 then
        if ply:IsSuperAdmin() then
            ply:Give("weapon_zm_revolver")
            ply:Give("weapon_ttt_m16")
            ply:Give("weapon_admin_goldsmokegrenade")
        end
    end
end
hook.Add("PlayerSpawn", "giverankedWeapon", giveWeapon)