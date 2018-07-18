GamePlayScene = {}

	NumbCond = 0

	GamePlayScene.initialize = function (...)
		-- body
	end
	------------------------------------------------------ main function

	GamePlayScene.draw = function (...)
		GamePlayScene.drawBG()
		GamePlayScene.drawBoard()
		GamePlayScene.drawDice()
		GamePlayScene.drawPlayer()
		GamePlayScene.RandomDice()
		-- body
		love.graphics.draw(Char1
,x1,y1,0,1,1,Char1:getWidth()/2,Char1:getHeight()/2)
		love.graphics.draw(Char2,x2,y2,0,1,1,Char2:getWidth()/2,Char2:getHeight()/2)
	end

	GamePlayScene.update = function (...)
		if suit.ImageButton(BtnClose_Normal, {hovered = BtnClose_Hovered, active = BtnClose_Active}, 1280, 20).hit then
        	love.event.quit()
    	end

    	if suit.ImageButton(BtnSpin_Normal, {hovered = BtnSpin_Hovered, active = BtnSpin_Active}, 952, 675).hit then
        	-- Action
        	print("-------------------------------------------------------")
        	print("kocokan dadu :", dice)
			NumbCond = 1
			server:send("dice")
			print("dice sent !")
    	end
		-- body

		  getPosition(tick)
	end

	GamePlayScene.listenerKeyPressed = function (key)
		GamePlayScene.keyPressed(key)
	end

	------------------------------------------------------ other function
	
	GamePlayScene.keyPressed = function (key)
		if key == "pagedown"  then
			changeScene(CounterSelectedScene -1)
		end
	end

	GamePlayScene.drawBG = function (...)
		love.graphics.draw(Bg_inGame, 0, 0)
	end

	GamePlayScene.RandomDice = function ()
		ImageArray = {
			Dice1, Dice2, Dice3, Dice4, Dice5, Dice6
		}

		ImageFile = love.math.random (1,6)

		if NumbCond == 1 then
			love.graphics.draw(ImageArray[ImageFile],1006,545)
			--DiceObj = ImageArray[dice]
			NumbCond = 2
		elseif NumbCond == 0 then
			GamePlayScene.drawDice()
		elseif NumbCond == 2 then
			love.graphics.draw(ImageArray[ImageFile],1006,545)
			NumbCond = 3
		elseif NumbCond == 3 then
			love.graphics.draw(ImageArray[ImageFile],1006,545)
			NumbCond = 4
		elseif NumbCond == 4 then
			love.graphics.draw(ImageArray[ImageFile],1006,545)
			NumbCond = 5
		elseif NumbCond == 5 then
			love.graphics.draw(ImageArray[ImageFile],1006,545)
			NumbCond = 6
		elseif NumbCond == 6 then
			love.graphics.draw(ImageArray[dice],1006,545)
			NumbCond = 7
		elseif NumbCond == 7 then
			NumbCond = 8
		end
	end

	GamePlayScene.drawBoard = function (...)
		love.graphics.draw(Board_InGame, 140, 14)
	end

	GamePlayScene.drawDice = function (...)
		love.graphics.draw(Dice1, 1006, 545)
	end

	GamePlayScene.drawPlayer = function (...)
		love.graphics.draw(Player1, 935, 30)
		love.graphics.draw(Position_Panel, 925, 158)
		love.graphics.draw(Player2, 1110, 30)
		love.graphics.draw(Position_Panel, 1100, 158)
		love.graphics.draw(Player3, 935, 215)
		love.graphics.draw(Position_Panel, 925, 342)
		love.graphics.draw(Player4, 1100, 215)
		love.graphics.draw(Position_Panel, 1100, 342)
	end