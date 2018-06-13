
local line1="rp_downtown_em_hs spawn zone"
local color1=Color(255,255,255,255)
local line2="you are free of all damage"
local color2=Color(255,255,255,255)

local line3=""
local color3=Color(255,255,255,255)

local line4=""
local color4=Color(255,255,255,255)

local line5=""
local color5=Color(255,255,255,255)

if !string.StartWith(game.GetMap(),"rp_downtown_em_hs_") then return end

local zones={
	{--spawn area 1
		Vector(-560.38995361328,-1975.9627685547,-272.96875),
		Vector(-162.82833862305,-1353.9140625,-93.018577575684)
	},
	{--tunnel to surface from spawn 1
		Vector(-180.01263427734,-1735.3952636719,-272.96875),
		Vector(333.34872436523,-1600.4302978516,85.239929199219)
	},

	{--spawn area 2
		Vector(-2170.1730957031,1764.0361328125,-276.73941040039),
		Vector(-1782.4295654297,1998.9268798828,-183.59820556641)
	},

	{--spawn area 3
		Vector(1526.4609375,1818.2749023438,-275.86782836914),
		Vector(2317.7595214844,1997.5577392578,-24.06760597229)
	},
	{--tunnel to surface from spawn 3
		Vector(1595.1062011719,1747.7432861328,-67.052406311035),
		Vector(2425.7951660156,2271.5703125,235.75886535645)
	},
}
local function InZone(ply)
	if ply and ply:IsValid() then
		for k,box in ipairs(zones) do
			if ply:GetPos():WithinAABox(box[1],box[2]) then
				return true
			end
		end
	end
	return false
end
local function getattacker(CTakeDamageInfo)
	local Entity=CTakeDamageInfo:GetAttacker()
	if Entity:GetMoveType()==MOVETYPE_VPHYSICS then--the Entity is a prop
		local owner=Entity:CPPIGetOwner()
		if owner and owner:IsValid() then
			return owner
		end
	end
	return Entity
end
hook.Add("EntityTakeDamage","rp_downtown_em_hs_spawn",function(ply,CTakeDamageInfo)
	if InZone(ply) then--is the player in spawn?
		CTakeDamageInfo:SetDamage(0) -- block damage
		CTakeDamageInfo:SetDamageType(DMG_FALL) -- fall damage doesn't take away armor
		return true
	elseif InZone(getattacker(CTakeDamageInfo)) then--is the attacker in spawn?
		CTakeDamageInfo:SetDamage(0) -- prevent spawn abuse
		CTakeDamageInfo:SetDamageType(DMG_FALL) -- fall damage doesn't take away armor
		return true
	end
end)
hook.Add("HUDPaint","rp_downtown_em_hs_spawn",function()
	if InZone(LocalPlayer()) then
		draw.DrawText(""..line1.."\n\n\n\n","CloseCaption_Bold",ScrW()*0.5,ScrH()*0.1,color1,TEXT_ALIGN_CENTER)
		draw.DrawText("\n"..line2.."\n\n\n","CloseCaption_Bold",ScrW()*0.5,ScrH()*0.1,color2,TEXT_ALIGN_CENTER)
		draw.DrawText("\n\n"..line3.."\n\n","CloseCaption_Bold",ScrW()*0.5,ScrH()*0.1,color3,TEXT_ALIGN_CENTER)
		draw.DrawText("\n\n\n"..line4.."\n","CloseCaption_Bold",ScrW()*0.5,ScrH()*0.1,color4,TEXT_ALIGN_CENTER)
		draw.DrawText("\n\n\n\n"..line5.."","CloseCaption_Bold",ScrW()*0.5,ScrH()*0.1,color5,TEXT_ALIGN_CENTER)
	end
end)