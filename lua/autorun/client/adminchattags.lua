--Chat Tags by Tyguy
CreateClientConVar("chat_tags_color_r", 255, true, false)
CreateClientConVar("chat_tags_color_g", 255, true, false)
CreateClientConVar("chat_tags_color_b", 255, true, false)
CreateClientConVar("chat_tags_color_a", 255, true, false)

local Tags = 
{
--Group    --Tag     --Color
{"member", "(Member) ", Color(255, 102, 178, 255) },
{"bronze", "(Bronze) ", Color(241, 202, 65, 255) },
{"silver", "(Silver) ", Color(241, 202, 65, 255) },
{"gold", "(Gold) ", Color(241, 202, 65, 255) },
{"platinum", "(Platinum) ", Color(241, 202, 65, 255) },
{"tempadmin", "(Temp. Admin) ", Color(0, 200, 46, 200) },
{"admin", "(Admin) ", Color(0, 200, 46, 200) },
{"superadmin", "(Senior Admin) ", Color(0, 102, 0, 255) },
{"owner", "(Owner) ", Color(5, 92, 255, 255) }
}

hook.Add("OnPlayerChat", "Tags", function(ply, strText, bTeamOnly)
	if IsValid(ply) and ply:IsPlayer() then
		for k,v in pairs(Tags) do
			if ply:IsUserGroup(v[1]) then
			local R = GetConVarNumber("chat_tags_color_r")
			local G = GetConVarNumber("chat_tags_color_g")
			local B = GetConVarNumber("chat_tags_color_b")
			local A = GetConVarNumber("chat_tags_color_a")
			local nickteam = team.GetColor(ply:Team())
				if !bTeamOnly then
				chat.AddText(v[3], v[2], nickteam, ply:Nick(), ": ", color_white, strText)
				return true
				else
				chat.AddText(v[3], v[2], nickteam, "(TEAM) ", ply:Nick(),": ", color_white, strText)
				return true
				end
			end
		end
	end
	if !IsValid(ply) and !ply:IsPlayer() then
	local ConsoleColor = Color(0, 255, 0) --Change this to change Console name color
	chat.AddText(ConsoleColor, "Console", color_white, ": ", strText)
	return true
	end
end )