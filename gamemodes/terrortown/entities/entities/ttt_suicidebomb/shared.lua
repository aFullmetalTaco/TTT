-- Suicide Bomb By Manmax75 :D Made For Taconation
-- Visit www.taconation.net

if SERVER then
   AddCSLuaFile("shared.lua")
end

AccessorFunc( ENT, "thrower", "Thrower") -- Similar Stuff To C4
AccessorFunc( ENT, "radius", "Radius", FORCE_NUMBER )
AccessorFunc( ENT, "dmg", "Dmg", FORCE_NUMBER )

ENT.Type = "anim"
ENT.Model = Model("models/weapons/w_c4_planted.mdl")
ENT.PrintName = "Suicide Bomb"
ENT.Icon = "vgui/ttt/icon_suicidebomb" -- Needed for icon reasons
ENT.Projectile = true

function ENT:Initialize()
    self.Entity:SetModel(self.Model)

   if SERVER then
      self.Entity:PhysicsInit(SOLID_VPHYSICS)
   end
   self.Entity:SetMoveType(MOVETYPE_VPHYSICS) -- Physcis Crap
   self.Entity:SetSolid(SOLID_BBOX)
   self.Entity:SetCollisionGroup(COLLISION_GROUP_WEAPON)
   
   if not self:GetThrower() then self:SetThrower(nil) end

   if not self:GetRadius() then self:SetRadius(500) end
   if not self:GetDmg() then self:SetDmg(200) end

end

function ENT:SphereDamage(center, radius) -- Thanks BKU for the sphere damage

   local r = radius ^ 2
   local dmgowner = self:GetThrower()

   local d = 0.0
   local diff = nil
   local dmg = 0
   for _, ent in pairs(player.GetAll()) do
      if ValidEntity(ent) and ent:Team() == TEAM_TERROR then

        
         diff = center - ent:GetPos()
         d = diff:DotProduct(diff)

         if d < r then
            d = math.max(0, math.sqrt(d) - 490)
            dmg = -0.01 * (d^2) + 125

            local dmginfo = DamageInfo()
            dmginfo:SetDamage(dmg)
            dmginfo:SetAttacker(dmgowner)
            dmginfo:SetInflictor(self.Entity)
            dmginfo:SetDamageType(DMG_BLAST)
            dmginfo:SetDamageForce(center - ent:GetPos())
            dmginfo:SetDamagePosition(ent:GetPos())

            ent:TakeDamageInfo(dmginfo)
         end
      end
   end
end

local c4boom = Sound("c4.explode")
function ENT:Explode(tr) -- Nothing much new
   if SERVER then
      self.Entity:SetNoDraw(true)
      self.Entity:SetSolid(SOLID_NONE)

      if tr.Fraction != 1.0 then
         self.Entity:SetPos(tr.HitPos + tr.HitNormal * 0.6)
      end

      local pos = self.Entity:GetPos()

      if util.PointContents(pos) == CONTENTS_WATER then
         self:Remove()
         return
      end

      self:SphereDamage(pos, 750)

      util.BlastDamage(self, self:GetThrower(), pos, self:GetRadius(), self:GetDmg())

      local effect = EffectData()
      effect:SetStart(pos)
      effect:SetOrigin(pos)
      effect:SetScale(self:GetRadius())
      effect:SetRadius(self:GetRadius())
      effect:SetMagnitude(self:GetDmg())

      if tr.Fraction != 1.0 then
         effect:SetNormal(tr.HitNormal)
      end

      effect:SetOrigin(pos)
      util.Effect("Explosion", effect, true, true) 
      util.Effect("HelicopterMegaBomb", effect, true, true)

      timer.Simple(0.1, function() WorldSound(c4boom, pos, 100, 100) end)

     
      local phexp = ents.Create("env_physexplosion")
      phexp:SetPos(pos)
      phexp:SetKeyValue("magnitude", self:GetDmg())
      phexp:SetKeyValue("radius", self:GetRadius())
      phexp:SetKeyValue("spawnflags", "19")
      phexp:Spawn()
      phexp:Fire("Explode", "", 0)


       timer.Simple(0.2, function(p) StartFires(pos, tr, 4, 5, true, p) end, self:GetThrower())

      

      SCORE:HandleC4Explosion(self:GetThrower(),CurTime(), CurTime())

      self:Remove()
   else
      local spos = self.Entity:GetPos()
      local trs = util.TraceLine({start=spos + Vector(0,0,64), endpos=spos + Vector(0,0,-128), filter=self})
      util.Decal("Scorch", trs.HitPos + trs.HitNormal, trs.HitPos - trs.HitNormal)      

      
   end
end

function ENT:Think() -- Pretty Much Its just a C4 but with editied code
      local spos = self.Entity:GetPos()
      local tr = util.TraceLine({start=spos, endpos=spos + Vector(0,0,-32), mask=MASK_SHOT_HULL, filter=self:GetThrower()})

      local success, err = pcall(self.Explode, self, tr)
      if not success then         
         self:Remove()         
         ErrorNoHalt("ERROR CAUGHT: ttt_c4: " .. err .. "\n")
      end
end