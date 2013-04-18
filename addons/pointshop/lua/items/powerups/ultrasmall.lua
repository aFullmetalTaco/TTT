ITEM.Name = 'Ultra Small'
ITEM.Price = 2500
ITEM.Model = 'models/props_junk/garbage_glassbottle003a.mdl'
ITEM.NoPreview = true
ITEM.AdminOnly = true

function ITEM:OnEquip(ply, modifications)
	ply:SetModelScale(0.4, 1)
end

function ITEM:OnHolster(ply)
	ply:SetModelScale(1, 1)
end