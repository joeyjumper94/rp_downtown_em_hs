--local version=tonumber(string.Split(game.GetMap(),"rp_downtown_em_hs_")[2])\
local MAP=game.GetMap()
local version=MAP:StartWith("rp_downtown_em_hs_") and tonumber(MAP:Split("_")[5])
if !version then return end
local function func()
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
					v:SetNWBool('Untouchable',true)
				end
			end
		end)
	end
	SetUntouchable()
	hook.Add("InitPostEntity","_rp_downtown_em_hs_lua",SetUntouchable)
	local disabled_til=0
	if CLIENT then
		concommand.Add("rp_downtown_em_hs_disable_protection",function(ply,cmd,args)
			net.Start("rp_downtown_em_hs_disable_protection")
			net.WriteFloat(math.max(tonumber(args[1])or 10,30))
			net.SendToServer()
		end)
		net.Receive("rp_downtown_em_hs_disable_protection",function(len,ply)
			disabled_til=net.ReadFloat()
		end)
	else
		net.Receive("rp_downtown_em_hs_disable_protection",function(len,ply)
			if ply:IsSuperAdmin() or ply.IsListenServerHost and ply:IsListenServerHost() then
				disabled_til=CurTime()+(net.ReadFloat()or 30)
				net.Start("rp_downtown_em_hs_disable_protection")
				net.WriteFloat(disabled_til)
				net.Broadcast()
			end
		end)
		util.AddNetworkString("rp_downtown_em_hs_disable_protection")
	end
	hook.Add("PostCleanupMap","_rp_downtown_em_hs_lua",SetUntouchable)
	hook.Add("PhysgunPickup","_rp_downtown_em_hs_lua",function(Ply,Ent)
		if disabled_til>CurTime() then return end
		if Ent and Ent:IsValid() then if blacklist[Ent:GetClass()] or Ent:GetNWBool("Untouchable",false) then return false end end
	end)
	hook.Add("CanDrive","_rp_downtown_em_hs_lua",function(Ply,Ent)
		if disabled_til>CurTime() then return end
		if Ent and Ent:IsValid() then if blacklist[Ent:GetClass()] or Ent:GetNWBool("Untouchable",false) then return false end end
	end)
	hook.Add("CanTool","_rp_downtown_em_hs_lua",function(Ply,trace,tool)
		if disabled_til>CurTime() then return end
		if !trace then return false end
		local Ent=trace.Entity
		if Ent and Ent:IsValid() then if blacklist[Ent:GetClass()] or Ent:GetNWBool("Untouchable",false) then return false end end
	end)
	hook.Add("CanProperty","_rp_downtown_em_hs_lua",function(Ply,property,Ent)
		if disabled_til>CurTime() then return end
		if Ent and Ent:IsValid() then if blacklist[Ent:GetClass()] or Ent:GetNWBool("Untouchable",false) then return false end end
	end)
	hook.Add("CanEditVariable","_rp_downtown_em_hs_lua",function(Ent,Ply)
		if disabled_til>CurTime() then return end
		if Ent and Ent:IsValid() then if blacklist[Ent:GetClass()] or Ent:GetNWBool("Untouchable",false) then return false end end
	end)
	hook.Add("OnPhysgunReload","_rp_downtown_em_hs_lua",function(Physgun,Ply)
		if disabled_til>CurTime() then return end
		if !(Ply and Ply:IsValid()) then return false end
		local trace=Ply:GetEyeTrace()
		if !trace then return false end
		local Ent=trace.Entity
		if Ent and Ent:IsValid() then if blacklist[Ent:GetClass()] or Ent:GetNWBool("Untouchable",false) then return false end end
	end)
	hook.Add("PlayerUse","_rp_downtown_em_hs_lua",function(Ply,Ent)
--		if Ent and Ent:IsValid() then if blacklist[Ent:GetClass()] or Ent:GetNWBool("Untouchable",false) then return false end end
	end)
	hook.Add("CanPlayerUnfreeze","_rp_downtown_em_hs_lua",function(Ply,Ent,PhysObj)
		if disabled_til>CurTime() then return end
		if Ent and Ent:IsValid() then if blacklist[Ent:GetClass()] or Ent:GetNWBool("Untouchable",false) then return false end end
	end)
end
hook.Add("Initialize","_rp_downtown_em_hs_lua",func)
if GAMEMODE and GAMEMODE.Config or player.GetAll()[1] then func() end