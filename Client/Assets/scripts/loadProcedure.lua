-- fungsi ini memudahkan untuk melakukan load assets secara benar

function loadImages(...)
    Bg_inGame = love.graphics.newImage("assets/sprites/Bg_inGame.png")
    Bg_Credit = love.graphics.newImage("assets/sprites/Bg_Credit.png")
    Bg_MainMenu = love.graphics.newImage("assets/sprites/Bg_MainMenu.png")
    Bg_LoadScreen = love.graphics.newImage("assets/sprites/Bg_LoadScreen.png")

    --Button
    BtnClose_Normal = love.graphics.newImage("assets/sprites/BtnClose_Normal.png")
    BtnClose_Hovered = love.graphics.newImage("assets/sprites/BtnClose_Hovered.png")
    BtnClose_Active = love.graphics.newImage("assets/sprites/BtnClose_Active.png")
    BtnSpin_Normal = love.graphics.newImage("assets/sprites/BtnSpin_Normal.png")
    BtnSpin_Hovered = love.graphics.newImage("assets/sprites/BtnSpin_Hovered.png")
    BtnSpin_Active = love.graphics.newImage("assets/sprites/BtnSpin_Active.png")
    BtnCancel_Normal = love.graphics.newImage("assets/sprites/BtnCancel_Normal.png")
    BtnCancel_Hovered = love.graphics.newImage("assets/sprites/BtnCancel_Hovered.png")
    BtnCancel_Active = love.graphics.newImage("assets/sprites/BtnCancel_Active.png")
    BtnPlay_Normal = love.graphics.newImage("assets/sprites/BtnPlay_Normal.png")
    BtnPlay_Hovered = love.graphics.newImage("assets/sprites/BtnPlay_Hovered.png")
    BtnPlay_Active = love.graphics.newImage("assets/sprites/BtnPlay_Active.png")
    BtnCredit_Normal = love.graphics.newImage("assets/sprites/BtnCredit_Normal.png")
    BtnCredit_Hovered = love.graphics.newImage("assets/sprites/BtnCredit_Hovered.png")
    BtnCredit_Active = love.graphics.newImage("assets/sprites/BtnCredit_Active.png")
    BtnQuit_Normal = love.graphics.newImage("assets/sprites/BtnQuit_Normal.png")
    BtnQuit_Hovered = love.graphics.newImage("assets/sprites/BtnQuit_Hovered.png")
    BtnQuit_Active = love.graphics.newImage("assets/sprites/BtnQuit_Active.png")
    BtnBack_Normal = love.graphics.newImage("assets/sprites/BtnBack_Normal.png")
    BtnBack_Hovered = love.graphics.newImage("assets/sprites/BtnBack_Hovered.png")
    BtnBack_Active = love.graphics.newImage("assets/sprites/BtnBack_Active.png")

    --Dadu
    Dice1 = love.graphics.newImage("assets/sprites/Dice1.png")
    Dice2 = love.graphics.newImage("assets/sprites/Dice2.png")
    Dice3 = love.graphics.newImage("assets/sprites/Dice3.png")
    Dice4 = love.graphics.newImage("assets/sprites/Dice4.png")
    Dice5 = love.graphics.newImage("assets/sprites/Dice5.png")
    Dice6 = love.graphics.newImage("assets/sprites/Dice6.png")

    --Rocket, Black hole and planet to teleport
    BlackHole_InGame = love.graphics.newImage("assets/sprites/BlackHole_InGame.png")
    Rocket_InGame = love.graphics.newImage("assets/sprites/Rocket_InGame.png")
    Board_InGame = love.graphics.newImage("assets/sprites/Board_InGame.png")
    Planet1 = love.graphics.newImage("assets/sprites/Planet1.png")
    Planet2 = love.graphics.newImage("assets/sprites/Planet2.png")
    Planet3 = love.graphics.newImage("assets/sprites/Planet3.png")


    Load_Logo = love.graphics.newImage("assets/sprites/Load_Logo.png")

    --Player and position panel while there is not player
    Player_None = love.graphics.newImage("assets/sprites/Player_None.png")
    Position_None = love.graphics.newImage("assets/sprites/Position_None.png")

    --Player and position panel while there is a player
    Player1 = love.graphics.newImage("assets/sprites/Player1.png")
    Player2 = love.graphics.newImage("assets/sprites/Player2.png")
    Player3 = love.graphics.newImage("assets/sprites/Player3.png")
    Player4 = love.graphics.newImage("assets/sprites/Player4.png")
    Position_Panel = love.graphics.newImage("assets/sprites/Position_Panel.png")

    --Player in Board
    Char1 = love.graphics.newImage("assets/sprites/Player1game.png")
    Char2 = love.graphics.newImage("assets/sprites/Player2game.png")
    Char3 = love.graphics.newImage("assets/sprites/Player3game.png")
    Char4 = love.graphics.newImage("assets/sprites/Player4game.png")
end

function loadSounds(...)
	-- body
end

function loadFonts(...)
	
end

function createGlobalVariables ()
    -- put all your scenes here.
    Scenes = {MainMenuScene, LoadScreenScene, GamePlayScene, CreditScene}
    CounterSelectedScene = 1

    x1,y1 = 185,714 -- tile ke 1
    x2,y2 = 185, 714 -- tile ke 2
    tilePos1 = 1 -- Posisi Tile Semula
    tilePos2 = 1
    turn = 1


    playerMove = 0 -- player turn
    dice = 0-- Dadu
    tangga =  0
    ular = 0
    status = ""

    speed1 = 500
    acceleration1 = 250
    deceleration1 = 0

    speed2 = 500
    acceleration2 = 250
    deceleration2 = 0

    moving = false

    dataPlayer = "" --string

    playerTurn = ""
    dataLadder = ""
    dataTurn = ""
    otherData = ""
    tileLadder = {}

    hilirLadder = {}
    huluLadder = {}
    huluSnake = {}
    hilirSnake = {}
    winStatus = false

    host = enet.host_create()
    server = host:connect("192.168.1.102:5678")

    tick = 0

    NumbCond = 0   
    
    move1 = mega.movements.newMove(acceleration1,deceleration1,speed1,x1,y1)
    move2 = mega.movements.newMove(acceleration2,deceleration2, speed2, x2,y2)
end