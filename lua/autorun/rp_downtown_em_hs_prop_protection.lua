local loaded=loaded or GAMEMODE and GAMEMODE.Config or player.GetAll()[1]
local function func()
	if !string.StartWith(game.GetMap(),"rp_downtown_em_hs_") then return end
	local blacklist={--any ent classes in this list cannot be touched in any way except for +use
		["func_breakable"]=true,
		["func_breakable_surf"]=true,
		["func_button"]=true,
		["func_door"]=true,
		["func_door_rotating"]=true,
		["func_reflective_glass"]=true,
		["func_tracktrain"]=true,
		["func_wall"]=true,
		["func_wall_toggle"]=true,
		["func_water_analog"]=true,
		["prop_door"]=true,
		["prop_door_rotating"]=true,
	}
	local whitelist={--any map created entities will not be protected by this script if their class is listed here
--		["func_wall"]=true,
	}
	local function SetUntouchable()
		if CLIENT then return end
		timer.Simple(0,function()
			for k,v in ipairs(ents.GetAll()) do
				if v:MapCreationID()!=-1 and !blacklist[v:GetClass()] and !whitelist[v:GetClass()] and v:GetPhysicsObject():IsValid() then
					v:SetNWBool("Untouchable",true)
				end
			end
		end)
	end
	SetUntouchable()
	hook.Add("PostCleanupMap","_rp_downtown_em_hs_lua",SetUntouchable)
	hook.Add("PhysgunPickup","_rp_downtown_em_hs_lua",function(Ply,Ent)
		if Ent and Ent:IsValid() and blacklist[Ent:GetClass()] then return false end
		if Ent and Ent:IsValid() and Ent:GetNWBool("Untouchable",false) then return false end
	end)
	hook.Add("CanDrive","_rp_downtown_em_hs_lua",function(Ply,Ent)
		if Ent and Ent:IsValid() and blacklist[Ent:GetClass()] then return false end
		if Ent and Ent:IsValid() and Ent:GetNWBool("Untouchable",false) then return false end
	end)
	hook.Add("CanTool","_rp_downtown_em_hs_lua",function(Ply,trace,tool)
		if !trace then return false end
		local Ent=trace.Entity
		if Ent and Ent:IsValid() and blacklist[Ent:GetClass()] then return false end
		if Ent and Ent:IsValid() and Ent:GetNWBool("Untouchable",false) then return false end
	end)
	hook.Add("CanProperty","_rp_downtown_em_hs_lua",function(Ply,property,Ent)
		if Ent and Ent:IsValid() and blacklist[Ent:GetClass()] then return false end
		if Ent and Ent:IsValid() and Ent:GetNWBool("Untouchable",false) then return false end
	end)
	hook.Add("CanEditVariable","_rp_downtown_em_hs_lua",function(Ent,Ply)
		if Ent and Ent:IsValid() and blacklist[Ent:GetClass()] then return false end
		if Ent and Ent:IsValid() and Ent:GetNWBool("Untouchable",false) then return false end
	end)
	hook.Add("OnPhysgunReload","_rp_downtown_em_hs_lua",function(Physgun,Ply)
		if !(Ply and Ply:IsValid()) then return false end
		local trace=Ply:GetEyeTrace()
		if !trace then return false end
		local Ent=trace.Entity
		if Ent and Ent:IsValid() and blacklist[Ent:GetClass()] then return false end
		if Ent and Ent:IsValid() and Ent:GetNWBool("Untouchable",false) then return false end
	end)
	hook.Add("PlayerUse","_rp_downtown_em_hs_lua",function(Ply,Ent)
--		if Ent and Ent:IsValid() and blacklist[Ent:GetClass()] then return false end
--		if Ent and Ent:IsValid() and Ent:GetNWBool("Untouchable",false) then return false end
	end)
	hook.Add("CanPlayerUnfreeze","_rp_downtown_em_hs_lua",function(Ply,Ent,PhysObj)
		if Ent and Ent:IsValid() and blacklist[Ent:GetClass()] then return false end
		if Ent and Ent:IsValid() and Ent:GetNWBool("Untouchable",false) then return false end
	end)
end
hook.Add("Initialize","_rp_downtown_em_hs_lua",func)
if loaded then func() end