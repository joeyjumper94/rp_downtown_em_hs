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

local zones={
	{--spawn area 1
		Vector(-561,-1976,-273),
		Vector(-162,-1353,-93)
	},
	{--tunnel to surface from spawn 1
		Vector(-180,-1736,-273),
		Vector(334,-1600,86)
	},

	{--spawn area 2
		Vector(-2171,1764,-277),
		Vector(-1782,1999,-183)
	},

	{--spawn area 3
		Vector(1526,1740,-276),
		Vector(2318,1998,-24)
	},
	{--tunnel to surface from spawn 3
		Vector(1595,1740,-67),
		Vector(2426,2272,236)
	},
}
--local version=tonumber(string.Split(game.GetMap(),"rp_downtown_em_hs_")[2])\
local MAP=game.GetMap()
local version=MAP:StartWith("rp_downtown_em_hs_") and tonumber(MAP:Split("_")[5])
if !version then return end
if version>10 then--the tunnel from spawn 3 is shorter in version 11
	zones[5][1]=Vector(1660.1062011719,1747.7432861328,-67.052406311035)
end
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