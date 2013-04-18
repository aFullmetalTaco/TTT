ITEM.Name = 'Black Smoke'
ITEM.Price = 200
ITEM.Model = 'models/weapons/w_eq_smokegrenade.mdl'
ITEM.WeaponClass = 'weapon_ttt_blacksmokegrenade'
ITEM.SingleUse = true

function ITEM:OnBuy(ply)
	ply:Give("weapon_ttt_blacksmokegrenade")
	ply:SelectWeapon(self.WeaponClass)
end

function ITEM:OnSell(ply)
	ply:StripWeapon(self.WeaponClass)
end