ITEM.Name = 'Shotgun'
ITEM.Price = 200
ITEM.Model = 'models/weapons/w_shot_xm1014.mdl'
ITEM.WeaponClass = 'weapon_zm_shotgun'
ITEM.SingleUse = true

function ITEM:OnBuy(ply)
	ply:Give("weapon_zm_shotgun")
	ply:SelectWeapon(self.WeaponClass)
end

function ITEM:OnSell(ply)
	ply:StripWeapon(self.WeaponClass)
end