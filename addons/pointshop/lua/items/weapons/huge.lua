ITEM.Name = 'Huge M249 Para'
ITEM.Price = 200
ITEM.Model = 'models/weapons/w_mach_m249para.mdl'
ITEM.WeaponClass = 'weapon_zm_sledge'
ITEM.SingleUse = true

function ITEM:OnBuy(ply)
	ply:Give("weapon_zm_sledge")
	ply:SelectWeapon(self.WeaponClass)
end

function ITEM:OnSell(ply)
	ply:StripWeapon(self.WeaponClass)
end