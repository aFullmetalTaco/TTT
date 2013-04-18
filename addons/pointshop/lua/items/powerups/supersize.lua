ITEM.Name = 'Super Size'
ITEM.Price = 1000
ITEM.Model = 'models/props_junk/GlassBottle01a.mdl'
ITEM.NoPreview = true
ITEM.AllowedUserGroups = { "gold", "platinum", "tempadmin", "admin", "superadmin", "owner" }

function ITEM:OnEquip(ply, modifications)
	ply:SetModelScale(2, 1)
end

function ITEM:OnHolster(ply)
	ply:SetModelScale(1, 1)
end

function ITEM:OnSell(ply)
	ply:SetModelScale(1, 1)
end