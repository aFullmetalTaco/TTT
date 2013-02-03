
if SERVER then
   AddCSLuaFile( "shared.lua" )
end
   
SWEP.HoldType			= "grenade"

if CLIENT then
   SWEP.PrintName = "White Smoke"
   SWEP.Slot = 3

   SWEP.Icon = "VGUI/ttt/icon_nades"
   
   SWEP.EquipMenuData = {
      type  = "item_weapon",
      name  = "White Smoke",
      desc  = [[White smoke to hide and kill people]]
   };
   
end

SWEP.Base				= "weapon_tttbasegrenade"

SWEP.Spawnable = true
SWEP.AdminSpawnable = true

SWEP.WeaponID = AMMO_SMOKE
SWEP.Kind = WEAPON_NADE
SWEP.CanBuy = {ROLE_TRAITOR}

SWEP.ViewModel			= "models/weapons/v_eq_smokegrenade.mdl"
SWEP.WorldModel			= "models/weapons/w_eq_smokegrenade.mdl"
SWEP.Weight			= 5
SWEP.AutoSpawnable      = true
-- really the only difference between grenade weapons: the model and the thrown
-- ent.

function SWEP:GetGrenadeName()
   return "ttt_whitesmoke"
end