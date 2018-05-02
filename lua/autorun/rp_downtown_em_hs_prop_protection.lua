local function func()
	if !string.StartWith(game.GetMap(),"rp_downtown_em_hs_") then return end
	local map_ents={--any ent classes in this list cannot be touched in any way except for +use
		["func_breakable"]=true,
		["func_breakable_surf"]=true,
		["func_button"]=true,
		["func_door"]=true,
		["func_door_rotating"]=true,
		["func_tracktrain"]=true,
		["func_wall"]=true,
		["func_wall_toggle"]=true,
		["func_water_analog"]=true,
		["prop_door"]=true,
		["prop_door_rotating"]=true,
	}
	hook.Add("PhysgunPickup","_rp_downtown_em_hs_lua",function(Ply,Ent)
		if Ent and Ent:IsValid() and map_ents[Ent:GetClass()] then return false end
	end)
	hook.Add("CanDrive","_rp_downtown_em_hs_lua",function(Ply,Ent)
		if Ent and Ent:IsValid() and map_ents[Ent:GetClass()] then return false end
	end)
	hook.Add("CanTool","_rp_downtown_em_hs_lua",function(Ply,trace,tool)
		if !trace then return false end
		local Ent=trace.Entity
		if Ent and Ent:IsValid() and map_ents[Ent:GetClass()] then return false end
	end)
	hook.Add("CanProperty","_rp_downtown_em_hs_lua",function(Ply,property,Ent)
		if Ent and Ent:IsValid() and map_ents[Ent:GetClass()] then return false end
	end)
	hook.Add("CanEditVariable","_rp_downtown_em_hs_lua",function(Ent,Ply)
		if Ent and Ent:IsValid() and map_ents[Ent:GetClass()] then return false end
	end)
	hook.Add("OnPhysgunReload","_rp_downtown_em_hs_lua",function(Physgun,Ply)
		if !(Ply and Ply:IsValid()) then return false end
		local trace=Ply:GetEyeTrace()
		if !trace then return false end
		local Ent=trace.Entity
		if Ent and Ent:IsValid() and map_ents[Ent:GetClass()] then return false end
	end)
	hook.Add("PlayerUse","_rp_downtown_em_hs_lua",function(Ply,Ent)
--		if Ent and Ent:IsValid() and map_ents[Ent:GetClass()] then return false end
	end)
	hook.Add("CanPlayerUnfreeze","_rp_downtown_em_hs_lua",function(Ply,Ent,PhysObj)
		if Ent and Ent:IsValid() and map_ents[Ent:GetClass()] then return false end
	end)
end
hook.Add("Initialize","_rp_downtown_em_hs_lua",func)
if loaded then func() end