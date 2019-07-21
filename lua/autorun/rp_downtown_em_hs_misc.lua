--local version=tonumber(string.Split(game.GetMap(),"rp_downtown_em_hs_")[2])\
local MAP=game.GetMap()
local version=MAP:StartWith("rp_downtown_em_hs_") and tonumber(MAP:Split("_")[5])
if !version then return end
local func=function()
	if SERVER then
		resource.AddWorkshop("1438745329")
		local dl={
			["rp_downtown_em_hs_12"]=1438751408,
			["rp_downtown_em_hs_13"]=1457551875,
			["rp_downtown_em_hs_14"]=1465927908,
			["rp_downtown_em_hs_15"]=1527420462,
			["rp_downtown_em_hs_16"]=1568720448,
			["rp_downtown_em_hs_17"]=1580922379,
			["rp_downtown_em_hs_18"]=1740842259,
			["rp_downtown_em_hs_19"]={
				716583740,--SG MLP Content Pack 1 Furniture
				895108486,--SG MLP Content Pack 2 Kitchen
				902712293,--SG MLP Content Pack 3 Nature
				910477327,--SG MLP Content Pack 4 Royal
				959375866,--SG MLP Content Pack 5 Commercial
				1734210618,--SG MLP Content Pack6 Map Resources
				1768580571,--RP DownTown EM HS 19
			},
			["rp_downtown_em_hs_20"]={
				716583740,--SG MLP Content Pack 1 Furniture
				895108486,--SG MLP Content Pack 2 Kitchen
				902712293,--SG MLP Content Pack 3 Nature
				910477327,--SG MLP Content Pack 4 Royal
				959375866,--SG MLP Content Pack 5 Commercial
				1734210618,--SG MLP Content Pack6 Map Resources
				1811327660,--RP DownTown EM HS 20
			},
		}
		local allowed={
			number=true,
			string=true,
		}
		dl=dl[MAP]
		if allowed[type(dl)] then
			resource.AddWorkshop(dl)
		elseif type(dl)=="table"then
			for k,v in pairs(dl)do
				if allowed[type(v)]then
					resource.AddWorkshop(v)
				end
			end
		else
			local size=file.Size("maps/"..game.GetMap()..".bsp","GAME")*0.000001
			if size<64 and size>GetConVar("net_maxfilesize"):GetFloat() then
				RunConsoleCommand("net_maxfilesize",math.ceil(size))
				RunConsoleCommand("sv_allowdownload","1")
			end
		end
	end
	if version>=16 and SERVER then
		hook.Add("PlayerUse","rp_downtown_em_hs_misc",function(ply,receiver)
			local tbl=receiver:GetClass()=="item_suitcharger" and receiver:GetSaveTable()
			if tbl and tbl.spawnflags==24576 then
				if RP_DOWNTOWN_EM_HS_BASEMENT_FLOODED then
					timer.Remove(receiver:EntIndex().."recharge_timer")
					return false
				end
				if receiver.m_iJuice!=tbl.m_iJuice then
					receiver.m_iJuice=tbl.m_iJuice
					timer.Create(receiver:EntIndex().."recharge_timer",120,1,function()
						if receiver and receiver:IsValid() and !RP_DOWNTOWN_EM_HS_BASEMENT_FLOODED then
							receiver:Fire"recharge"
						end
					end)
				end
			end
		end)
		rp_downtown_em_hs_sun=rp_downtown_em_hs_sun or {}
		rp_downtown_em_hs_sun.func=function()
			rp_downtown_em_hs_sun.sun=ents.FindByClass"light_environment"[1]
			rp_downtown_em_hs_sun.light=ents.FindByClass"light_environment"[1]
		end
		rp_downtown_em_hs_sun.nightfall=function()
			rp_downtown_em_hs_sun.status=0
			if !rp_downtown_em_hs_sun.light and !rp_downtown_em_hs_sun.sun then
				rp_downtown_em_hs_sun.func()
			end
			if rp_downtown_em_hs_sun.light then
				rp_downtown_em_hs_sun.light:Fire"turnoff"
			end
			if rp_downtown_em_hs_sun.sun then
				rp_downtown_em_hs_sun.sun:Fire"turnoff"
			end
		end
		rp_downtown_em_hs_sun.daybreak=function()
			rp_downtown_em_hs_sun.status=1
			if !rp_downtown_em_hs_sun.light and !rp_downtown_em_hs_sun.sun then
				rp_downtown_em_hs_sun.func()
			end
			if rp_downtown_em_hs_sun.light then
				rp_downtown_em_hs_sun.light:Fire"turnon"
			end
			if rp_downtown_em_hs_sun.sun then
				rp_downtown_em_hs_sun.sun:Fire"turnon"
			end
		end
		hook.Add("InitPostEntity","rp_downtown_em_hs_sun",rp_downtown_em_hs_sun.func)
		if !rp_downtown_em_hs_sun.light then
			rp_downtown_em_hs_sun.func()
		end
		hook.Add("PostCleanupMap","rp_downtown_em_hs_misc",function()
			rp_downtown_em_hs_sun.func()
			if rp_downtown_em_hs_sun.status==0 then
				rp_downtown_em_hs_sun.nightfall()
			end
		end)
		hook.Add("StormFox-Sunrise","rp_downtown_em_hs_sun",rp_downtown_em_hs_sun.daybreak)
		hook.Add("StormFox-Sunset","rp_downtown_em_hs_sun",rp_downtown_em_hs_sun.nightfall)
	end
end
if GAMEMODE and GAMEMODE.Config or player.GetAll()[1] then func() end
hook.Add("Initialize","rp_downtown_em_hs_misc",func)