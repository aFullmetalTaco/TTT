AddCSLuaFile("autorun/client/cl_adminreport.lua")

--Deal with report getting using net messages so we can use >255 chars.

CreateConVar("reports_msg_delay", 10)
CreateConVar("reports_expiry_mins", 60)
CreateConVar("reports_msg_text", "!report")


util.AddNetworkString( "SendReport" )

local Reports={}
Reports.Open={}
Reports.Open.CurIndex=1

function Reports.Initialize()
	if not file.Exists("adminreports","DATA") then
		file.CreateDir("adminreports")
		file.Write("adminreports/closed.txt","")
	end
	if file.Exists("adminreports/open.txt","DATA")  then
		Reports.Open=util.JSONToTable(file.Read("adminreports/open.txt","DATA"))
	end
end

hook.Add("Initialize","ReportFileMake",function()
	Reports.Initialize()
	
end)

function Reports.SaveOpen()
	file.Write("adminreports/open.txt",util.TableToJSON(Reports.Open))
end

util.AddNetworkString( "reportchatnotify" )
function Reports.SendMsg(plr,msg,withchat)
	plr:PrintMessage(HUD_PRINTCONSOLE,msg)

	if withchat then
		net.Start("reportchatnotify")
		net.WriteString(msg)
		net.Send(plr)
	end
end

function Reports.Create(plr,msg,index)
	Reports.Open[index]={steam=plr:SteamID(),name=plr:Nick(),time=math.floor(os.time()),datetime=os.date(),text=msg}
	Reports.AddOnlinePeople(Reports.Open[index])
end

function Reports.List(plr)
	for i,v in pairs(Reports.Open) do 
		if type(v)~="number" then --Not looking at the Reports.CurIndex!
		
			Reports.SendMsg(plr,tostring(i)..": "..Reports.GetExpiry(i).."m|"..v.steam.."|"..string.sub(v.name,1,15).."|"..v.text)
		end
	end
end

function Reports.Close(index,plr)
	index=tonumber(index)
	local report=Reports.Open[index]
	
	if report~=nil then
		if plr then
			Reports.SendMsg(plr,"Report "..tostring(index).." closed.")
		end
		Reports.Open[index]=nil
		file.Append("adminreports/closed.txt","-----------\n"..tostring(index)..": "..report.datetime.."|"..report.steam.."|"..report.name.."|"..report.text.."\n")
		Reports.SaveOpen()
		
	else
		if plr then
			Reports.SendMsg(plr,"Could not find report "..tostring(index))

		end
	end
end

function Reports.GetExpiry(index)
	local report=Reports.Open[index]
	local expirymins=(GetConVar("reports_expiry_mins"):GetInt())*60
	
	return math.ceil(expirymins-((os.time()-report.time)/60))
end

function Reports.View(index,plr)
	index=tonumber(index)
	local report=Reports.Open[index]
	if report~=nil then
		Reports.SendMsg(plr,"Viewing "..tostring(index)..": "..report.datetime.."|"..Reports.GetExpiry(index).."m|"..report.steam.."|"..report.name.."|"..report.text)
	else
		Reports.SendMsg(plr,"Could not find report "..tostring(index))
	end
end


util.AddNetworkString("reportstablesync")

function Reports.AddOnlinePeople(report)
	
	for i,report in pairs(Reports.Open) do
		if type(report)~="number" then --Filter CurIndex
			
			local AdminTable={}
			local PlayersTable={}
			for i,v in pairs(player.GetHumans()) do
				if v:IsAdmin() then
					table.insert(AdminTable,{name=v:Nick(),steamid=v:SteamID()})
				end
				table.insert(PlayersTable,{name=v:Nick(),steamid=v:SteamID()})

			end
			report.adminsonline=AdminTable
			report.playersonline=PlayersTable
		end
	end
	
end

function Reports.SyncWithPlr(plr)
	local SendTable={}
	for i,report in pairs(Reports.Open) do
		if type(report)~="number" then --Filter CurIndex
			SendTable[i]=report
			report.expiry=Reports.GetExpiry(i) --So client can see expiry properly
		end
	end
	net.Start("reportstablesync")
	net.WriteTable(SendTable)
	net.Send(plr)
end

concommand.Add("rept",function(plr,comm,args)
	if not plr:IsAdmin() then return end

	if args[1] then

		if args[1]=="list" then
			if args[2] then
				if args[2]=="ui" then
					Reports.SyncWithPlr(plr)
				end
			else
				Reports.List(plr)
			end
		elseif args[1]=="close" then
			Reports.Close(args[2],plr)
		elseif args[1]=="view" then
			Reports.View(args[2],plr)
		
		end
	end
end)



local lastthought=0
hook.Add("Think","ReportExpire",function()
	if lastthought+60<CurTime() then
	
		lastthought=CurTime()
		

		--if #Reports.Open>0 then
			for i,v in pairs(Reports.Open) do
				
				if type(v)~="number" then --It must be a table!
					
					local expirytime=GetConVar("reports_expiry_mins"):GetInt()*60
					if v.time+expirytime<os.time() then
						ServerLog("Purging Report: "..tostring(i).."\n")
						Reports.Close(i,nil)
					end
				end
			end
		--end	
	end

end)




function Reports.NotifyAdmins() --Tell all online admins we just got a report
	for i,v in pairs(player.GetHumans()) do
		if v:IsAdmin() then
			Reports.SendMsg(v,"New Ticket ID "..tostring(Reports.Open.CurIndex).." Logged",true)
		end
	end
end

net.Receive( "SendReport", function( length, plr )
	if not plr.LastReport then
		plr.LastReport=0 --Avoid any problems with no last report timer
	end
	local ReportTimer=GetConVar("reports_msg_delay"):GetInt()
	
	if plr.LastReport+ReportTimer < CurTime() then
		local reportstr=net.ReadString()
	
		
		Reports.Create(plr,reportstr,Reports.Open.CurIndex)
		Reports.NotifyAdmins()
		Reports.Open.CurIndex=Reports.Open.CurIndex+1
		Reports.SaveOpen()
		
		Reports.SendMsg(plr,"Thank you for contacting an admin, your ticket ID is #"..Reports.Open.CurIndex,true)
		
		
		
		plr.LastReport=CurTime()
	else
		Reports.SendMsg(plr,"Report sent too recently. Wait another "..tostring(math.ceil((ReportTimer+plr.LastReport)-CurTime())).." seconds.",true)
	end
end)

hook.Add("PlayerSay","AdminMakeReport",function(plr,text)
	local reportstring=GetConVar("reports_msg_text"):GetString()
	
	if string.sub(text,1,string.len(reportstring))==reportstring then --First however letters are the !report thing
		plr:ConCommand("makereport "..string.sub(text,string.len(reportstring)+1)) --Not the ideal way to do it ping ponging back and forth I know.
		return ""
	end
	
end)
		


		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		