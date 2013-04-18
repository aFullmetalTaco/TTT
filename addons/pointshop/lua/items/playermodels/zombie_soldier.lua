ITEM.Name = 'Zombie Soldier'
ITEM.Price = 250
ITEM.Model = 'models/player/zombie_soldier.mdl'
ITEM.AllowedUserGroups = { "platinum", "tempadmin", "admin", "superadmin", "owner" }

function ITEM:OnEquip(ply, modifications)
	if not ply._OldModel then
		ply._OldModel = ply:GetModel()
	end
	
	timer.Simple(1, function() ply:SetModel(self.Model) end)
end

function ITEM:OnHolster(ply)
	if ply._OldModel then
		ply:SetModel(ply._OldModel)
	end
end