ITEM.Name = 'Pistol'
ITEM.Price = 200
ITEM.Model = 'models/weapons/w_pist_fiveseven.mdl'
ITEM.WeaponClass = 'weapon_zm_pistol'
ITEM.SingleUse = true

function ITEM:OnBuy(ply)
	ply:Give("weapon_zm_pistol")
	ply:SelectWeapon(self.WeaponClass)
end

function ITEM:OnSell(ply)
	ply:StripWeapon(self.WeaponClass)
end