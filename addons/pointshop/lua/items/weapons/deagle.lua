ITEM.Name = 'Deagle'
ITEM.Price = 200
ITEM.Model = 'models/weapons/w_pist_deagle.mdl'
ITEM.WeaponClass = 'weapon_zm_revolver'
ITEM.SingleUse = true

function ITEM:OnBuy(ply)
	ply:Give("weapon_zm_revolver")
	ply:SelectWeapon(self.WeaponClass)
end

function ITEM:OnSell(ply)
	ply:StripWeapon(self.WeaponClass)
end