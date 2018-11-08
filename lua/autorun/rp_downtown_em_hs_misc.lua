local version=tonumber(string.Split(game.GetMap(),"rp_downtown_em_hs_")[2])
if !version then return end
local func=function()
	if SERVER then
		resource.AddWorkshop("1438745329")
		local dl={
			[12]=1438751408,
			[13]=1457551875,
			[14]=1465927908,
			[15]=1527420462,
		}
		dl=dl[version]
		if dl then
			resource.AddWorkshop(dl)
		else
			RunConsoleCommand("net_maxfilesize","64")
		end
	end
	if version>=16 and SERVER then
		hook.Add("AcceptInput","rp_downtown_em_hs_misc",function(receiver,input,starter,previous,data)
			local tbl=receiver:GetClass()=="item_suitcharger" && receiver:GetSaveTable()
			if tbl && tbl.spawnflags==24576 && tbl.m_flJuice!=tbl.m_iJuice then
				timer.Create(receiver:EntIndex().."recharge_timer",120,1,function()
					if receiver && receiver:IsValid() then
						receiver:Fire"recharge"
					end
				end)
			end
		end)
		rp_downtown_em_hs_sun=rp_downtown_em_hs_sun or {}
		rp_downtown_em_hs_sun.func=function()
			rp_downtown_em_hs_sun.sun=ents.FindByClass"light_environment"[1]
			rp_downtown_em_hs_sun.light=ents.FindByClass"light_environment"[1]
		end
		rp_downtown_em_hs_sun.nightfall=function()
			rp_downtown_em_hs_sun.status=0
			rp_downtown_em_hs_sun.light:Fire"turnoff"
			rp_downtown_em_hs_sun.sun:Fire"turnoff"
		end
		rp_downtown_em_hs_sun.daybreak=function()
			rp_downtown_em_hs_sun.status=1
			rp_downtown_em_hs_sun.light:Fire"turnon"
			rp_downtown_em_hs_sun.sun:Fire"turnon"
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