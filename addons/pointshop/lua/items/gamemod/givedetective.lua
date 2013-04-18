ITEM.Name = 'Detective Round'
ITEM.Price = 3000
ITEM.Model = 'models/props_junk/GlassBottle01a.mdl'
ITEM.NoPreview = true
ITEM.SingleUse = true
CATEGORY.Order = 5

function ITEM:CanPlayerBuy(ply)
    return ply:Alive() -- only if alive
end

function ITEM:OnBuy(ply)
   if ply:IsActive() then
      ply:SetRole(ROLE_DETECTIVE)
      ply:AddCredits(10)
      SendFullStateUpdate()
   end
end

function ITEM:OnSell(ply)
    ply:Kill()
end