ITEM.Name = 'Buy 5 Credits'
ITEM.Price = 750
ITEM.Model = 'models/items/cs_gift.mdl'
ITEM.NoPreview = true
ITEM.SingleUse = true
CATEGORY.Order = 2

function ITEM:CanPlayerBuy(ply)
    return ply:Alive() -- only if alive
end

function ITEM:OnBuy(ply)
   if ply:IsActive() then
      ply:AddCredits(5)
   end
end

function ITEM:OnSell(ply)
    ply:Kill()
end