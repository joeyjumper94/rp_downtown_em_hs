--config for the text shown on screen when in the admin room
local line1="welcome to the admin sit roomm"
local color1=Color(255,255,255,255)

local line2="the only thing you can really"
local color2=Color(255,255,255,255)

local line3="do is talk, type, and walk"
local color3=Color(255,255,255,255)

local line4=""
local color4=Color(255,255,255,255)

local line5=""
local color5=Color(255,255,255,255)
--end of config
local version=tonumber(string.Split(game.GetMap(),"rp_downtown_em_hs_")[2])
if !version then return end
hook.Add("StartCommand","_rp_downtown_em_hs_admin",function(ply,CUserCmd)
	if ply and ply:IsValid() and ply:GetPos():WithinAABox(Vector(-3911,94,285),Vector(-3305,5466,561)) then
		CUserCmd:RemoveKey(IN_ATTACK)
		CUserCmd:RemoveKey(IN_ATTACK2)
		CUserCmd:RemoveKey(IN_RELOAD)
	end
end)
hook.Add("CanPlayerEnterVehicle","_rp_downtown_em_hs_admin",function(ply,vehicle,role)
	if ply and ply:IsValid() and !ply:IsAdmin() and ply:GetPos():WithinAABox(Vector(-3911,94,285),Vector(-3305,5466,561)) then return false
end end)
hook.Add("CanPlayerSuicide","_rp_downtown_em_hs_admin",function(ply)
	if ply and ply:IsValid() and !ply:IsAdmin() and ply:GetPos():WithinAABox(Vector(-3911,94,285),Vector(-3305,5466,561)) then return false
end end)
hook.Add("EntityTakeDamage","_rp_downtown_em_hs_admin",function(ply,info)
	if ply and ply:IsValid() and ply:GetPos():WithinAABox(Vector(-3911,94,285),Vector(-3305,5466,561)) then
		if info then
			info:SetDamage(0)
			info:SetDamageType(DMG_FALL)
		end
		return true
end end)
hook.Add("PlayerGiveSWEP","_rp_downtown_em_hs_admin",function(ply,weapon,swep)
	if ply and ply:IsValid() and !ply:IsAdmin() and ply:GetPos():WithinAABox(Vector(-3911,94,285),Vector(-3305,5466,561)) then return false
end end)
hook.Add("PlayerSpawnEffect","_rp_downtown_em_hs_admin",function(ply,model)
	if ply and ply:IsValid() and !ply:IsAdmin() and ply:GetPos():WithinAABox(Vector(-3911,94,285),Vector(-3305,5466,561)) then return false
end end)
hook.Add("PlayerSpawnNPC","_rp_downtown_em_hs_admin",function(ply,npc_type,weapon)
	if ply and ply:IsValid() and !ply:IsAdmin() and ply:GetPos():WithinAABox(Vector(-3911,94,285),Vector(-3305,5466,561)) then return false
end end)
hook.Add("PlayerSpawnObject","_rp_downtown_em_hs_admin",function(ply,model,skin)
	if ply and ply:IsValid() and !ply:IsAdmin() and ply:GetPos():WithinAABox(Vector(-3911,94,285),Vector(-3305,5466,561)) then return false
end end)
hook.Add("PlayerSpawnProp","_rp_downtown_em_hs_admin",function(ply,model)
	if ply and ply:IsValid() and !ply:IsAdmin() and ply:GetPos():WithinAABox(Vector(-3911,94,285),Vector(-3305,5466,561)) then return false
end end)
hook.Add("PlayerSpawnRagdoll","_rp_downtown_em_hs_admin",function(ply,model)
	if ply and ply:IsValid() and !ply:IsAdmin() and ply:GetPos():WithinAABox(Vector(-3911,94,285),Vector(-3305,5466,561)) then return false
end end)
hook.Add("PlayerSpawnSENT","_rp_downtown_em_hs_admin",function(ply,class)
	if ply and ply:IsValid() and !ply:IsAdmin() and ply:GetPos():WithinAABox(Vector(-3911,94,285),Vector(-3305,5466,561)) then return false
end end)
hook.Add("PlayerSpawnSWEP","_rp_downtown_em_hs_admin",function(ply,weapon,swep)
	if ply and ply:IsValid() and !ply:IsAdmin() and ply:GetPos():WithinAABox(Vector(-3911,94,285),Vector(-3305,5466,561)) then return false
end end)
hook.Add("PlayerSpawnVehicle","_rp_downtown_em_hs_admin",function(ply,model,name,table)
	if ply and ply:IsValid() and !ply:IsAdmin() and ply:GetPos():WithinAABox(Vector(-3911,94,285),Vector(-3305,5466,561)) then return false
end end)

hook.Add("canAdvert","_rp_downtown_em_hs_admin",function(ply,arguments)
	if ply and ply:IsValid() and ply:GetPos():WithinAABox(Vector(-3911,94,285),Vector(-3305,5466,561)) then return false--,msg
end end)
hook.Add("canArrest","_rp_downtown_em_hs_admin",function(ply,vic)
	if ply and ply:IsValid() and ply:GetPos():WithinAABox(Vector(-3911,94,285),Vector(-3305,5466,561)) then return false--,msg
end end)
hook.Add("canBuyAmmo","_rp_downtown_em_hs_admin",function(ply,ammoTable)
	if ply and ply:IsValid() and ply:GetPos():WithinAABox(Vector(-3911,94,285),Vector(-3305,5466,561)) then return false--,true,msg
end end)
hook.Add("canBuyPistol","_rp_downtown_em_hs_admin",function(ply,shipmentTable)
	if ply and ply:IsValid() and ply:GetPos():WithinAABox(Vector(-3911,94,285),Vector(-3305,5466,561)) then return false--,true,msg
end end)
hook.Add("canBuyShipment","_rp_downtown_em_hs_admin",function(ply,shipmentTable)
	if ply and ply:IsValid() and ply:GetPos():WithinAABox(Vector(-3911,94,285),Vector(-3305,5466,561)) then return false--,true,msg
end end)
hook.Add("canBuyVehicle","_rp_downtown_em_hs_admin",function(ply,vehicleTable)
	if ply and ply:IsValid() and ply:GetPos():WithinAABox(Vector(-3911,94,285),Vector(-3305,5466,561)) then return false--,true,msg
end end)
hook.Add("canChangeJob","_rp_downtown_em_hs_admin",function(ply,job)
	if ply and ply:IsValid() and ply:GetPos():WithinAABox(Vector(-3911,94,285),Vector(-3305,5466,561)) then return false--,msg
end end)
hook.Add("CanChangeRPName","_rp_downtown_em_hs_admin",function(ply,name)
	if ply and ply:IsValid() and ply:GetPos():WithinAABox(Vector(-3911,94,285),Vector(-3305,5466,561)) then return false--,msg
end end)
hook.Add("canDarkRPUse","_rp_downtown_em_hs_admin",function(ply,entity)
	if ply and ply:IsValid() and ply:GetPos():WithinAABox(Vector(-3911,94,285),Vector(-3305,5466,561)) then return false--,msg
end end)
hook.Add("canDemote","_rp_downtown_em_hs_admin",function(ply,target,reason)
	if ply and ply:IsValid() and ply:GetPos():WithinAABox(Vector(-3911,94,285),Vector(-3305,5466,561)) then return false--,msg
end end)
hook.Add("canDropWeapon","_rp_downtown_em_hs_admin",function(ply,weapon)
	if ply and ply:IsValid() and ply:GetPos():WithinAABox(Vector(-3911,94,285),Vector(-3305,5466,561)) then return false--,msg
end end)
hook.Add("canEditLaws","_rp_downtown_em_hs_admin",function(ply,action,arguments)
	if ply and ply:IsValid() and ply:GetPos():WithinAABox(Vector(-3911,94,285),Vector(-3305,5466,561)) then return false--,msg
end end)
hook.Add("canGoAFK","_rp_downtown_em_hs_admin",function(ply,afk)
	if ply and ply:IsValid() and ply:GetPos():WithinAABox(Vector(-3911,94,285),Vector(-3305,5466,561)) then return !afk
end end)
hook.Add("canSleep","_rp_downtown_em_hs_admin",function(player,force)
	if ply and ply:IsValid() and ply:GetPos():WithinAABox(Vector(-3911,94,285),Vector(-3305,5466,561)) then return false--,false,msg
end end)
hook.Add("HUDPaint","_rp_downtown_em_hs_admin",function()
	if LocalPlayer():GetPos():WithinAABox(Vector(-3911,94,285),Vector(-3305,5466,561)) then
		draw.DrawText(""..line1.."\n\n\n\n","CloseCaption_Bold",ScrW()*0.5,ScrH()*0.1,color1,TEXT_ALIGN_CENTER)
		draw.DrawText("\n"..line2.."\n\n\n","CloseCaption_Bold",ScrW()*0.5,ScrH()*0.1,color2,TEXT_ALIGN_CENTER)
		draw.DrawText("\n\n"..line3.."\n\n","CloseCaption_Bold",ScrW()*0.5,ScrH()*0.1,color3,TEXT_ALIGN_CENTER)
		draw.DrawText("\n\n\n"..line4.."\n","CloseCaption_Bold",ScrW()*0.5,ScrH()*0.1,color4,TEXT_ALIGN_CENTER)
		draw.DrawText("\n\n\n\n"..line5.."","CloseCaption_Bold",ScrW()*0.5,ScrH()*0.1,color5,TEXT_ALIGN_CENTER)
end end)