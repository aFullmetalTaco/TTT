ITEM.Name = 'Buy 3 Credits'
ITEM.Price = 600
ITEM.Model = 'models/items/cs_gift.mdl'
ITEM.NoPreview = true
ITEM.SingleUse = true
CATEGORY.Order = 1

function ITEM:CanPlayerBuy(ply)
    return ply:Alive() -- only if alive
end

function ITEM:OnBuy(ply)
   if ply:IsActive() then
      ply:AddCredits(3)
   end
end

function ITEM:OnSell(ply)
    ply:Kill()
end