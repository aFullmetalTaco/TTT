ITEM.Name = 'AWP Rifle'
ITEM.Price = 750
ITEM.Model = 'models/weapons/w_snip_awp.mdl'
ITEM.WeaponClass = 'weapon_ttt_awp'
ITEM.SingleUse = true
ITEM.AllowedUserGroups = { "bronze", "silver", "gold", "platinum", "admin", "superadmin", "owner" }


function ITEM:OnBuy(ply)
	ply:Give("weapon_ttt_awp")
	ply:SelectWeapon(self.WeaponClass)
end

function ITEM:OnSell(ply)
	ply:StripWeapon(self.WeaponClass)
end