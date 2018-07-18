-- ###### POLITEKNIK ELEKTRONIKA NEGERI SBY
-- ###### PRAKTIKUM GAME MULTIPLAYER ONLINE 
-- ###### TEKNOLOGI GAME 2014
-- ###### NRP : 4210141003, 4210141019, 42100141020, 4210141021 

require "assets/scripts/loadProcedure"
suit = require 'suit'
require "movements"
require "enet"

-- scene
require "assets/scripts/scenes/SloadScreen"
require "assets/scripts/scenes/SCredit"
require "assets/scripts/scenes/SmainMenu"
require "assets/scripts/scenes/SgamePlay"

--------------------------------------------- main function

function love.load()
	loadImages()
	loadSounds()
	loadFonts()
	createGlobalVariables()
    initializeScene(1)
    	
end

function love.draw()
	Scenes[CounterSelectedScene].draw()
	suit.draw()
end

function love.update (dt)
    event = host:service(100)
    Scenes[CounterSelectedScene].update()
    print(love.keypressed(key))

    if event then
        if event.type == "receive" then
            print("-------------------------------------------------------")
            print("Got message: ",  event.data)         
            print("data lenght : ", string.len(event.data))
            --print(tanggaReceive(dataLadder))

            if string.len(event.data) >=21 and string.len(event.data) <= 36 then
                dataLadder = event.data
                print("Got ladder: ", event.data)
                changeScene(CounterSelectedScene +1 )
            elseif string.len(event.data) >=9 and string.len(event.data) <=20 then
                dataTurn = event.data
                infoReceive(event.data)
                print("Got info: ", event.data)
                    if playerMove == 1 and turn == 1 then                           
                        setTargetMovement(tilePos1,dice)
                        tilePos1 = tilePos1 + dice
                        print ("posisi player1 ada di : ".. tilePos1)
                        turn = 2                        
                    elseif playerMove == 2 and turn == 2 then
                        setTargetMovement(tilePos2,dice)
                        tilePos2 = tilePos2 + dice
                        print ("posisi player2 ada di : ".. tilePos2)
                        turn = 1
                    end 
                ladderCheck(playerMove,playerTurn,tangga)
                snakeCheck(playerMove,playerTurn,ular)  
            elseif string.len(event.data) == 7 then
                dataPlayer = event.data
                print("you are ", event.data)
                if dataPlayer == "player1" then
                    playerMove = 1
                elseif dataPlayer == "player2" then                 
                    playerMove = 2
                end
            else
                otherData = event.data
                print("Got Data: ", event.data)             
            end
        end     
    end

    tick = dt

end

function love.keypressed(key)
    Scenes[CounterSelectedScene].listenerKeyPressed(key)
    if key == "escape" then
        love.event.quit()
    end
    suit.keypressed(key)
end

---------------------------------------------- other function

function initializeScene (index)
    if index==0 then
        Scenes[CounterSelectedScene].initialize()
    else
        for i=1,#Scenes do
            Scenes[i].initialize() 
        end
    end
end

function changeScene(index) -- buat ganti ganti scene masukin langung scene target
    CounterSelectedScene = index
    initializeScene(index)
end

function getTableSize(T)
    local count = 0
    for _ in pairs(T) do 
        count = count +1
    end

    return count -- menghitung panjang table
end

------------------------------------------------ Other Function
------------------------------------------------

-- fungsi untuk mengubah tile menjadi posisi
function tiletoPosition(tile)
    local tiles = tile
    local posx = 0
    local posy = 0
    local mendatar = {185,258,330,403,477,550,622,695,768,840}
    local menurun  = {714,641,568,495,422,350,277,204,131,59}

    
    -- 1 sampai 10
    if tiles >0 and tiles<11 then 
        posx = mendatar[tiles]
        posy = menurun[1]

    -- 11 sampai 20
    elseif tiles>10 and tiles<21 then -- 
            
        if tiles%10 == 0 then
            posx = mendatar[1]
        else 
            posx = mendatar[11-(tiles%10)]
        end
        posy = menurun[2]

    -- 21 sampai 30
    elseif tiles>20 and tiles<31 then
        if tiles%10 == 0 then
            posx = mendatar[10]
        else 
            posx = mendatar[tiles%10]
        end
        posy = menurun[3]

    -- 31 sampai 40
    elseif tiles>30 and tiles<41 then
        if tiles%10 == 0 then
            posx = mendatar[1]
        else 
            posx = mendatar[11-(tiles%10)]
        end
        posy = menurun[4]

    -- 41 sampai 50
    elseif tiles>40 and tiles<51 then
        if tiles%10 == 0 then
            posx = mendatar[10]
        else 
            posx = mendatar[tiles%10]
        end
        posy = menurun[5]

    -- 51 sampai 60 
    elseif tiles>50 and tiles<61 then
        if tiles%10 == 0 then
            posx = mendatar[1]
        else 
            posx = mendatar[11-(tiles%10)]
        end
        posy = menurun[6]

    -- 61 sampai 71
    elseif tiles>60 and tiles<71 then
        if tiles%10 == 0 then
            posx = mendatar[10]
        else 
            posx = mendatar[tiles%10]
        end
        posy = menurun[7]

    --71 sampai 80
    elseif tiles>70 and tiles<81 then
        if tiles%10 == 0 then
            posx = mendatar[1]
        else 
            posx = mendatar[11-(tiles%10)]
        end
        posy = menurun[8]

    -- 81 sampai 90
    elseif tiles>80 and tiles<91 then
        if tiles%10 == 0 then
            posx = mendatar[10]
        else 
            posx = mendatar[tiles%10]
        end
        posy = menurun[9]

    -- 91 sampai 100
    elseif tiles>90 and tiles<101 then
        if tiles%10 == 0 then
            posx = mendatar[1]
        else 
            posx = mendatar[11-(tiles%10)]
        end
        posy = menurun[10]
    end
    return posx,posy--Konversi tile ke posisi 
end

-- fungsi untuk menjalankan karakter dengan dadu
function setTargetMovement(posisi,dadu)
    local pos0 = posisi
    local dice = dadu
    local pos1 = posisi + 1
    local targetTile = posisi + dice
    print (targetTile)


    local x0,y0 = 0,0
    local x1,y1 = 0,0

    local stepBack = 0

    local on100 = false

    local i = 0

    if targetTile <= 100  then
        for i=0, dice do
            pos1 = pos0 + i 
            movementOnce(pos1)      
        end
    elseif targetTile > 100 then
        local a = targetTile - dice
         for i=0, a do
            pos1 = pos0 + i
            movementOnce(pos1)
         end
    end 
    -- target dari dadu-- target dengan dadu    
end

-- fungsi untuk menjalankan karakter dengan tangga atau ular
function setTarget(posisi, target)
    local pos0 = posisi
    local pos1 = target

    
    if playerMove == 1 then 
        move1:setTarget(tiletoPosition(pos1)) -- target dengan hulu tangga
    elseif playerMove == 2 then
        move2:setTarget(tiletoPosition(pos1)) -- target dengan hulu tangga
    end 
end

-- fungsi untuk menjalankan sekali
function movementOnce(posisi)
    local t0 = posisi
    local t1 = posisi +1
    
    if playerMove == 1 then 
        move1:setTarget(tiletoPosition(t0))
    elseif playerMove == 2 then
        move2:setTarget(tiletoPosition(t0))
    end
end

-- fungsi untuk mendapatkan posisi tiap karakter
function getPosition(dt)
    x1,y1 = move1:getPosition() 
    move1:advance(dt)

    x2,y2 = move2:getPosition()
    move2:advance(dt)   
end

-- fungsi untuk menerima data tangga dari server dan menerjemahkan mejadi data yang dibutuhkan
function tanggaReceive(tanggaString)
    local dataTangga = ""
    local tileTangga = {}
    local a = 1
    local b = 1
    local c = 1

    dataTangga = tanggaString

    for i in string.gmatch(dataTangga,"%S+") do
            tileTangga[a] = tonumber(i)
            --print("tangga ke ", a, ":" ,tonumber(tileTangga[a])) --debug
            a = a+1
    end

    for i in pairs(tileTangga) do
        if i >= 1 and i<=6 then
            if i%2 == 1 then
                hilirLadder[b] = tileTangga[i]
                --print("hilirLadder "..tostring(b).."= "..tostring(hilirLadder[b])) -- debug
            elseif i%2 == 0 then
                huluLadder[b] = tileTangga[i]
                --print("huluLadder  "..tostring(b).."= "..tostring(huluLadder[b])) -- debug
            end
            b = b + 1
        elseif i>=7 and i<=12 then
            if i%2 == 1 then 
                huluSnake[c] = tileTangga[i]
                --print("huluSnake   "..tostring(c).."= "..tostring(huluSnake[c])) -- debug
            elseif i%2 == 0 then
                hilirSnake[c] = tileTangga[i]
                --print("hilirSnake  "..tostring(c).."= "..tostring(hilirSnake[c])) -- debug
            end
            c = c + 1       
        end     
    end

    --changescene
    --return tileTangga
end

-- fungsi untuk menerima info tiap putaran pemain
function infoReceive(infoString)
    local dataInfo = ""
    local pemain = 0
    local info = {}
    local dadu = 0
    local ularID = -1
    local tanggaID = -1
    local status1 = false

    dataInfo = infoString

    local a = 1

    for i in string.gmatch(infoString, "%S+") do
         if a == 1 then
            pemain = tonumber(i)
            playerMove = pemain         
         elseif a == 2 then
            dadu = tonumber(i)
            dice = dadu         
         elseif a == 3 then 
            tanggaID = tonumber(i)
            tangga = tanggaID           
         elseif a == 4 then
            ularID = tonumber(i)
            ular = ularID           
         elseif a == 5 then
            if i == "true" then
                status1  = true
            else
                status1 = false
            end
            status = status1            
         end
                
        a = a +1
    end
    print ("informasi didapatkan= ".."|turn : "..tostring(pemain).."|dadu : "..tostring(dadu).."|idtangga : "..tostring(tanggaID).."|idUlar : "..tostring(ularID).."|status : "..tostring(status1).."|")

    --return dadu, ularID, tanggaID, status
end

-- fungsi untuk mengecek status menang
function winCheck()
    if tilePos1 == 100 then

    elseif tilePos2 == 100 then

    end


end

-- fungsi untuk setting variable ke nilai semula
function normalize()
    playerMove = 0-- player turn
    dice = 0-- Dadu
    tangga = 0 
    ular = 0
    status = 0
end

-- fungsi untuk pengecekan tangga
function ladderCheck(PLAYERMOVE,TURN,LADDERID)
    local giliranPlayer = PLAYERMOVE
    local giliranSekarang = TURN
    local idLadder = LADDERID

    if giliranPlayer == 1 and giliranSekarang == 2 then
        if idLadder > 0 then
            setTarget(hilirLadder[idLadder],huluLadder[idLadder])
        end
    elseif giliranPlayer == 2 and giliranSekarang == 1 then
        if idLadder > 0 then
            setTarget(hilirLadder[idLadder],huluLadder[idLadder])
        end
    end
end

-- fungsi untuk pengecekan ular
function snakeCheck(PLAYERMOVE,TURN,SNAKEID)
    local giliranPlayer = PLAYERMOVE
    local giliranSekarang = TURN
    local idSnake = SNAKEID

    if giliranPlayer == 1 and giliranSekarang == 2 then
        if idLadder > 0 then
            setTarget(huluSnake[idSnake],hilirSnake[idLadder])
        end 
    elseif giliranPlayer == 2 and giliranSekarang == 1 then
        if idLadder > 0 then
            setTarget(huluSnake[idSnake],hilirSnake[idLadder])
        end 
    end
end
