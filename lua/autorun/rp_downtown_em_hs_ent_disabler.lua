if CLIENT then return end--server only
local remove={
	--sewer_grate_button=true,--grate entrance to the sewer
	--bridge_control_panel="press",--bridge control manual downbutton
	--upbutton="press",--bridge control manual upbutton
	--autobutton="press",--bridge control, sets bridge to automatic
	--shop_panic_button=true,--panic button in the shops
}
local actions={
	--bridge_control_panel="press",--bridge control manual downbutton
	--upbutton="press",--bridge control manual upbutton
	--autobutton="press",--bridge control, sets bridge to automatic
}
local func=function()
	for k,v in ipairs(ents.GetAll()) do
		if v and v:IsValid() then
			local name=v:GetName()
			local action=actions[name]
			if action then
				v:Fire(action)
			end
			if remove[name] then
				v:Remove()
			end
		end
	end
end
hook.Add("PostCleanUpMap","rp_downtown_em_hs_banned_ents",func)--when game.CleanUpMap was called, AKA cleaning up the map
hook.Add("Initialize","rp_downtown_em_hs_banned_ents",func)--when the gamemode has finished loading
if GAMEMODE and GAMEMODE.Config or player.GetAll()[1] then func() end--reloading the file