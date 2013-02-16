if SERVER then
   AddCSLuaFile( "shared.lua" )
end
   
SWEP.HoldType = "pistol"

if CLIENT then
   SWEP.PrintName = ".44 Magnum"			
   SWEP.Author = "JBoytheGreat"
   SWEP.ViewModelFlip = false
   SWEP.Slot = 1
end

SWEP.Base = "weapon_tttbase"
SWEP.Spawnable = false
SWEP.AdminSpawnable = true
SWEP.Kind = WEAPON_PISTOL
SWEP.WeaponID = AMMO_DEAGLE

SWEP.Primary.Ammo = "AlyxGun"
SWEP.Primary.Recoil = 7
SWEP.Primary.Damage = 30
SWEP.Primary.Delay = 0.3
SWEP.Primary.Cone = 0.02
SWEP.Primary.ClipSize = 6
SWEP.Primary.ClipMax = 18
SWEP.Primary.DefaultClip = 6
SWEP.Primary.Automatic = false

SWEP.HeadshotMultiplier = 4

SWEP.AutoSpawnable = false
SWEP.AmmoEnt = "item_ammo_revolver_ttt"
SWEP.Primary.Sound = Sound( "Weapon_deagle.Single" )
SWEP.ViewModel = "models/weapons/v_357.mdl"
SWEP.WorldModel = "models/weapons/w_357.mdl"

SWEP.IronSightsPos = Vector( -5.47, 2.92, 2.55 )
SWEP.IronSightsAng = Vector( 0.55, 0.55, 0.00 )