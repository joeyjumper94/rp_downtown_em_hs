local loaded=loaded or GAMEMODE.Config or player.GetAll()[1]
local function func()
	if !game.GetMap():find("rp_downtown_em_hs") then return end
	local map_ents={
		["func_wall"]=true,
		["func_breakable"]=true,
		["func_breakable_surf"]=true,
		["func_button"]=true,
		["func_tracktrain"]=true,
		["func_door"]=true,
	}
	hook.Add("PhysgunPickup","_rp_downtown_em_hs_lua",function(Ply,Ent)
		if Ent and ent:IsValid() and map_ents[ent:GetClass()] then return false end
	end)
	hook.Add("CanDrive","_rp_downtown_em_hs_lua",function(Ply,Ent)
		if Ent and ent:IsValid() and map_ents[ent:GetClass()] then return false end
	end)
	hook.Add("CanTool","_rp_downtown_em_hs_lua",function(Ply,trace,tool)
		if !trace then return false end
		local Ent=trace.Entity
		if Ent and ent:IsValid() and map_ents[ent:GetClass()] then return false end
	end)
	hook.Add("CanProperty","_rp_downtown_em_hs_lua",function(Ply,property,Ent)
		if Ent and ent:IsValid() and map_ents[ent:GetClass()] then return false end
	end)
	hook.Add("CanEditVariable","_rp_downtown_em_hs_lua",function(Ent,Ply)
		if Ent and ent:IsValid() and map_ents[ent:GetClass()] then return false end
	end)
	hook.Add("OnPhysgunReload","_rp_downtown_em_hs_lua",function(Physgun,Ply)
		if !(Ply and Ply:IsValid() and Ply:GetEyeTrace()) then return false end
		local Ent=Ply:GetEyeTrace().Entity
		if Ent and ent:IsValid() and map_ents[ent:GetClass()] then return false end
	end)
	hook.Add("PlayerUse","_rp_downtown_em_hs_lua",function(Ply,Ent)
--		if Ent and ent:IsValid() and map_ents[ent:GetClass()] then return false end
	end)
	hook.Add("CanPlayerUnfreeze","_rp_downtown_em_hs_lua",function(Ply,Ent,PhysObj)
		if Ent and ent:IsValid() and map_ents[ent:GetClass()] then return false end
	end)
end
hook.Add("Initialize","_rp_downtown_em_hs_lua",func)
if loaded then func() end