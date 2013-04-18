ITEM.Name = 'Traitor Round'
ITEM.Price = 3500
ITEM.Model = 'models/props_junk/garbage_glassbottle003a.mdl'
ITEM.NoPreview = true
ITEM.SingleUse = true
CATEGORY.Order = 4

function ITEM:CanPlayerBuy(ply)
    return ply:Alive() -- only if alive
end

function ITEM:OnBuy(ply)
   if ply:IsActive() then
      ply:SetRole(ROLE_TRAITOR)
      ply:AddCredits(10)
      SendFullStateUpdate()
   end
end

function ITEM:OnSell(ply)
    ply:Kill()
end