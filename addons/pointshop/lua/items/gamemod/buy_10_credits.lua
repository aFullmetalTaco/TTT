ITEM.Name = 'Buy 10 Credits'
ITEM.Price = 1250
ITEM.Model = 'models/items/cs_gift.mdl'
ITEM.NoPreview = true
ITEM.SingleUse = true
CATEGORY.Order = 3

function ITEM:CanPlayerBuy(ply)
    return ply:Alive() -- only if alive
end

function ITEM:OnBuy(ply)
   if ply:IsActive() then
      ply:AddCredits(10)
   end
end

function ITEM:OnSell(ply)
    ply:Kill()
end