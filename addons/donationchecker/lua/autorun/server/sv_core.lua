require("mysqloo")

DC = {}

DC.DB = mysqloo.connect("109.108.140.14","gamingv_gmod","Pa$$w0rd","gamingv_gmod",3306)

function DC.DB:onConnected()
	print("Connected to the database!")
end

function DC.DB:onConnectionFailed(err)

	for i=1,10 do
		print("FAILED TO CONNECT: "..err)
	end
	
end

DC.DB:connect()

hook.Add("PlayerSpawn","DC:CheckPly",function(ply)

	local query1 = DC.DB:query("SELECT * FROM ranks WHERE steamid = '"..ply:SteamID().."' ")
	function query1:onSuccess(q)
	
		if q[1] == nil then
			print(ply:Nick().." is not in the table, adding...")
			
			local query2 = DC.DB:query("INSERT INTO ranks (id,steamid,rank) VALUES('','"..ply:SteamID().."','user') ")
			function query2:onSuccess()
				print(ply:Nick().." added to database!")
				
				local query1 = DC.DB:query("SELECT * FROM ranks WHERE steamid = '"..ply:SteamID().."' ")
				function query1:onSuccess(q)
					
					if q[1] != nil then
					
						local rank = q[1].rank
						
							if ply:GetUserGroup() != rank then
					
								if ply:IsSuperAdmin() or ply:IsAdmin() then
								
								RunConsoleCommand("say","Thank you for donating")
								
								else
					
								RunConsoleCommand("ulx","adduser",ply:Nick(),rank)
								
								end
			
							end
			
						end
					
					end
					
				end
				function query2.onError(err)
					print("Error: "..err)
				end
				query1:start()
				
			end
			function query2:onError(err)
				print(err)
			end
			query2:start()
			end
		else
			
			local rank = q[1].rank
			
			end
			
		end
	end
	function query1:onError(err)
		print(err)
	end
	query1:start()
	
end)

