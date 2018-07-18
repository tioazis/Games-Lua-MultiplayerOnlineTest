--[[
POLITEKNIK ELEKTRONIKA NEGERI SURABAYA
PROGRAM STUDI TEKNOLOGI GAME 2014
PRAKTIKUM DESAIN MULTIPLAYER ONLINE SEMESTER 6
]]

require "enet"

local host = enet.host_create"*:5678"
local player = 0
local gameisplayed = false
local tanggahilir = {}
local tanggahulu = {}
local ularhilir = {}
local ularhulu = {}
local field = ""
local dice = 0
local player1 = 0
local player2 = 0
local pos_player_1 = 0
local pos_player_2 = 0
local tangga_id = -1
local ular_id = -1
local gameend = false
local info = ""

print ("Server Started")

function tanggaNaik(jarak) 
	local x = 0
	local y = 0
	local x1 = 0
	local y1 = 0
	local range = jarak
	local hilirtangga = 0
	local hulutangga = 0

	--dekat(1-3), sedang(4-6), jauh(7-9)	

	x = love.math.random(1,9)
	if range == 1 then 
		y = love.math.random(1,9)		
	elseif range == 2 then
		y = love.math.random(1,4)
	elseif range == 3 then
		y = 1
	end

	hilirtangga = y*10+x

	x1 = love.math.random(1,9)
	if range == 1 then
		y1 = y + love.math.random(1+3)
	elseif range == 2 then
		y1 = y + love.math.random(4,6)
	elseif range == 3 then 
		y1 = y + love.math.random(7,9)
	end
	hulutangga = y1*10+x1

	return hilirtangga,hulutangga

	-- fungsi untuk membuat tangga dari jarak yang diinginkan
	-- jarak ada 3 macam : dekat(1), sedang(2) dan jauh(2)

end

function ularTurun(jarak) --jarak adalah perpindahan antar baris dari sumbu y
	local x = 0
	local y = 0
	local x1 = 0
	local y1 = 0
	local range = jarak
	local huluular = 0
	local hilirular = 0

	--dekat(1-3), sedang(4-6), jauh(7-9)	

	x = love.math.random(1,9)
	if range == 1 then 
		y = love.math.random(1,9)		
	elseif range == 2 then
		y = love.math.random(1,4)
	elseif range == 3 then
		y = 1
	end

	huluular = y*10+x

	x1 = love.math.random(1,9)
	if range == 1 then
		y1 = y + love.math.random(1+3)
	elseif range == 2 then
		y1 = y + love.math.random(4,6)
	elseif range == 3 then 
		y1 = y + love.math.random(7,9)
	end
	hilirular = y1*10+x1

	return hilirular,huluular

	-- fungsi untuk membuat ular dari jarak yang diinginkan
	-- jarak ada 3 macam : dekat(1), sedang(2) dan jauh(2)

end

function generatefield()
	-- generate tangga dan ular
	local temp1,temp2,temp3,temp4
	for i=0, 2 do
		temp1,temp2 = tanggaNaik(love.math.random(1,3))
		tanggahilir[i] = temp1
		tanggahulu[i] = temp2
		temp3,temp4 = ularTurun(love.math.random(1,3))
		ularhilir[i] = temp3
		ularhulu[i] = temp4
	end	
end

function setfield()
	-- masukkan tangga hilir
	for i=0,2 do
		field = field..tostring(tanggahilir[i]).." "
	end
	-- masukkan tangga hulu
	for i=0,2 do
		field = field..tostring(tanggahulu[i]).." "
	end
	-- masukkan ular hilir
	for i=0,2 do
		field = field..tostring(ularhilir[i]).." "
	end
	-- masukkan ular hulu
	for i=0,2 do
		field = field..tostring(ularhulu[i]).." "
	end
end

function dicegenerator()
	dice = love.math.random(1,6)
end

function countdicetopos(which)
	local playermana = which
	if playermana==1 then
		pos_player_1 = pos_player_1 + dice
	elseif playermana==2 then
		pos_player_2 = pos_player_2 + dice
	end
end

function checkladder(which)
	local playermana = which
	if playermana==1 then
		for i=0,2 do
			if pos_player_1 == tanggahilir[i] then
				tangga_id = i
				if(pos_player_1<100) then
					pos_player_1 = tanggahulu[i]
				else
					pos_player_1 = pos_player_1 - (pos_player_1 - 100)
				end
				return true
			else
				return false	
			end
		end
	elseif playermana==2 then
		for i=0,2 do
			if pos_player_2 == tanggahilir[i] then
				tangga_id = i
				if(pos_player_2<100) then
					pos_player_2 = tanggahulu[i]
				else
					pos_player_2 = pos_player_2 - (pos_player_2 - 100)
				end
				return true
			else
				return false
			end
		end
	end
end

function checksnake(which)
	local playermana = which
	if playermana==1 then
		for i=0,2 do
			if pos_player_1 == ularhilir[i] then
				ular_id = i
				pos_player_1 = ularhulu[i]
				return true
			else
				return false	
			end
		end
	elseif playermana==2 then
		for i=0,2 do
			if pos_player_2 == ularhilir[i] then
				ular_id = i
				pos_player_2 = ularhulu[i]
				return true
			else
				return false
			end
		end
	end
end

function checkwin()
	if pos_player_1 == 100 or pos_player_2 == 100 then
		gameend = true
	end
end

function normalize()
	dice = 0
	tangga_id = -1
	ular_id = -1
	info = ""
end

while true do
	local event = host:service(100)
	if event then
		if event.type == "connect" then
			print("Client connected, info :", event.peer)
			host:broadcast("new client connected")
				if (player<2) then
					player = player + 1
					if player1 == 0 then
						player1 = event.peer
						event.peer:send("player1")
					elseif player2 == 0 then
						player2 = event.peer
						event.peer:send("player2")
					end
				end
		end
		if event.type == "receive" then
			print("receive : ",event.data, "from ", event.peer)
			if event.data == "play" and gameisplayed == false and player == 2 then
				gameisplayed = true
				generatefield()
				setfield()
				print("sending ladder", field)
				host:broadcast(field)
			end
			if event.data == "dice" and gameisplayed == true and player == 2 then
				dicegenerator()
				if event.peer == player1 then
					countdicetopos(1)
					checkladder(1)
					checksnake(1)
					checkwin()
					info = "1".." "..tostring(dice).." "..tostring(tangga_id).." "..tostring(ular_id).." "..tostring(gameend)
				elseif event.peer == player2 then
					countdicetopos(2)
					checkladder(2)
					checksnake(2)

					checkwin()
					info = "2".." "..tostring(dice).." "..tostring(tangga_id).." "..tostring(ular_id).." "..tostring(gameend)
				end
				host:broadcast(info)
				print("Sending ", info,"to ->", event.peer)
				normalize()
			end
		end
	end
end


-- perbaikan server
-- harusnnya pas play senjumlah 2 baru ngirim tangga, bukan ketika player connect 2
-- tangga id tidak terkirim 1 atau 2 nya