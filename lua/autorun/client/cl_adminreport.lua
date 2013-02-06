concommand.Add("makereport",function(plr,comm,args)
	if args[1] then
		net.Start("SendReport")
		net.WriteString(table.concat(args," "))
		net.SendToServer()
	end
end)

net.Receive("reportchatnotify",function()
	local writestr=net.ReadString()
	if writestr then
		chat.AddText(Color(255,0,0),writestr)
	end
end)

local Reports={}
local CurIndex=1
local CurrentDermaUI={}

local function PurgeUICache()
	for i,v in pairs(CurrentDermaUI) do
		if IsValid(v) then
			v:Close()
		end
	end
end

net.Receive("reportstablesync",function()
	Reports=net.ReadTable()
	RunConsoleCommand("adminreports_list")
end)

concommand.Add("gv_tickets",function()
	RunConsoleCommand("rept","list","ui")

end)

// Derma code below..
concommand.Add("adminreports_list",function()



local DermaPanel = vgui.Create( "DFrame" )
DermaPanel:SetPos( 50,50 )
DermaPanel:SetSize( 700, 700 )
DermaPanel:SetTitle( "List Reports" )
DermaPanel:SetVisible( true )
DermaPanel:SetDraggable( true )
DermaPanel:ShowCloseButton( true )
DermaPanel:MakePopup()
table.insert(CurrentDermaUI,DermaPanel)

 
local DermaListView = vgui.Create("DListView")
DermaListView:SetParent(DermaPanel)
DermaListView:SetPos(25, 50)
DermaListView:SetSize(650, 600)
DermaListView:SetMultiSelect(false)
DermaListView:AddColumn("ID")
DermaListView:AddColumn("Expiry")
DermaListView:AddColumn("SteamID")
DermaListView:AddColumn("Name")
DermaListView:AddColumn("Text")

DermaListView.Columns[1]:ResizeColumn(1) --ID
DermaListView.Columns[2]:ResizeColumn(1) --Expiry
DermaListView.Columns[3]:ResizeColumn(50) --SteamID
DermaListView.Columns[4]:ResizeColumn(50) --Name

local button = vgui.Create( "DButton", DermaPanel )
	button:SetSize( 100, 30 )
	button:SetPos( 30, 660 )
	button:SetText( "Refresh Tickets" )
	button.DoClick = function( button )
		PurgeUICache()
		RunConsoleCommand("gv_tickets")	
end

local button = vgui.Create( "DButton", DermaPanel )
	button:SetSize( 100, 30 )
	button:SetPos( 150, 660 )
	button:SetText( "Close Ticket" )
	button.DoClick = function( button )
		PurgeUICache()
		RunConsoleCommand("rept","close",CurIndex)
		RunConsoleCommand("gv_tickets")	
end

local button = vgui.Create( "DButton", DermaPanel )
	button:SetSize( 100, 30 )
	button:SetPos( 280, 660 )
	button:SetText( "View Ticket" )
	button.DoClick = function( button )
		RunConsoleCommand("adminreports_view")	
end

DermaListView.OnRowSelected=function(panel,line)
	CurIndex=panel:GetLine(line):GetValue(1)
	
end

DermaListView.DoDoubleClick = function(panel, index, line)
	CurIndex=panel:GetLine(index):GetValue(1)
	RunConsoleCommand("adminreports_view")	
	
end

for i,report in pairs(Reports) do
	DermaListView:AddLine(i,report.expiry,report.steam,report.name,report.text)
	
end



end) --end list concommand


concommand.Add("adminreports_view",function()
local CurReport=Reports[CurIndex]
if not CurReport then return end


local DermaPanel = vgui.Create( "DFrame" )
DermaPanel:SetPos( 50,50 )
DermaPanel:SetSize( 700, 700 )
DermaPanel:SetTitle( "View Reports" )
DermaPanel:SetVisible( true )
DermaPanel:SetDraggable( true )
DermaPanel:ShowCloseButton( true )
DermaPanel:MakePopup()
table.insert(CurrentDermaUI,DermaPanel)

local MainPanel = vgui.Create( "DPanel", DermaPanel )
MainPanel:SetPos( 25, 50 )
MainPanel:SetSize( 400, 600 )

local DermaListView = vgui.Create("DListView")
DermaListView:SetParent(DermaPanel)
DermaListView:SetPos(430, 50)
DermaListView:SetSize(260, 600)
DermaListView:SetMultiSelect(false)

DermaListView:AddColumn("SteamID")
DermaListView:AddColumn("Name")


for i,plr in pairs(CurReport.playersonline) do
	DermaListView:AddLine(plr.steamid,plr.name)
	
end
DermaListView:SortByColumn(2,false)

local button = vgui.Create( "DButton", DermaPanel )
	button:SetSize( 100, 30 )
	button:SetPos( 150, 660 )
	button:SetText( "Close Ticket" )
	button.DoClick = function( button )
		PurgeUICache()
		RunConsoleCommand("rept","close",CurIndex)
		RunConsoleCommand("gv_tickets")	
		
end

local label = vgui.Create("DLabel", MainPanel)
label:SetPos(10,20) // Position
label:SetFont("DefaultBold")
label:SetColor(Color(0,0,0,255))
label:SetText("Player Name: "..CurReport.name) 
label:SizeToContents()

local label = vgui.Create("DLabel", MainPanel)
label:SetPos(10,35) // Position
label:SetFont("DefaultBold")
label:SetColor(Color(0,0,0,255))
label:SetText("Player Steam: "..CurReport.steam) 
label:SizeToContents()

local label = vgui.Create("DLabel", MainPanel)
label:SetPos(10,50) // Position
label:SetFont("DefaultBold")
label:SetColor(Color(0,0,0,255))
label:SetText("Time Submitted: "..CurReport.datetime) 
label:SizeToContents()

local label = vgui.Create("DLabel", MainPanel)
label:SetPos(10,65) // Position
label:SetFont("DefaultBold")
label:SetColor(Color(0,0,0,255))
--label:SetWrap(true)
local AdminFormatter="\n"
for i,admin in pairs(CurReport.adminsonline) do
	AdminFormatter=AdminFormatter..admin.name.." ("..admin.steamid..")\n"
end
label:SetText("Admins Online: "..AdminFormatter) 
label:SizeToContents()

--label:SetSize(550,100)


local label = vgui.Create("DLabel", MainPanel)
label:SetPos(10,250) // Position
label:SetFont("DefaultBold")
label:SetColor(Color(0,0,0,255))
label:SetWrap(true)

label:SetText("Report: \n"..CurReport.text) 
label:SetSize(550,100)




end) --end view concommand