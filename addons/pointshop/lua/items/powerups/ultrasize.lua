ITEM.Name = 'Ultra Size'
ITEM.Price = 5000
ITEM.Model = 'models/props_junk/GlassBottle01a.mdl'
ITEM.NoPreview = true
ITEM.AdminOnly = true

function ITEM:OnEquip(ply, modifications)
	ply:SetModelScale(4, 1)
end

function ITEM:OnHolster(ply)
	ply:SetModelScale(1, 1)
end