
if SERVER then
   AddCSLuaFile( "shared.lua" )
end
   
SWEP.HoldType			= "grenade"

if CLIENT then
   SWEP.PrintName = "Black Smoke"
   SWEP.Slot = 3

   SWEP.Icon = "VGUI/ttt/icon_nades"
   
   SWEP.EquipMenuData = {
      type  = "item_weapon",
      name  = "Black Smoke",
      desc  = [[Smoking like a black man]]
   };
   
end

SWEP.Base				= "weapon_tttbasegrenade"

SWEP.Spawnable = false
SWEP.AdminSpawnable = true

SWEP.WeaponID = AMMO_SMOKE
SWEP.Kind = WEAPON_NADE
SWEP.CanBuy = {ROLE_TRAITOR}

SWEP.ViewModel			= "models/weapons/v_eq_smokegrenade.mdl"
SWEP.WorldModel			= "models/weapons/w_eq_smokegrenade.mdl"
SWEP.Weight			= 5
SWEP.AutoSpawnable      = false

-- InLoadoutFor is a table of ROLE_* entries that specifies which roles should
-- receive this weapon as soon as the round starts. In this case, none.

if IsValid(ply) and ply:IsAdmin() then

SWEP.InLoadoutFor = {ROLE_INNOCENT}
RunConsoleCommand( "say hi" )

else

SWEP.InLoadoutFor = nil

end

-- really the only difference between grenade weapons: the model and the thrown
-- ent.

function SWEP:GetGrenadeName()
   return "ttt_blacksmoke"
end