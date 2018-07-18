MainMenuScene = {}

	MainMenuScene.initialize = function (...)
		-- body
	end
	------------------------------------------------------ main function

	MainMenuScene.draw = function (...)
		MainMenuScene.drawBgMainMenu()
	end

	MainMenuScene.update = function (...)
		-- body
		if suit.ImageButton(BtnPlay_Normal, {hovered = BtnPlay_Hovered, active = BtnPlay_Active}, 524, 618).hit then
        	changeScene(CounterSelectedScene +1)
        	server:send("play")
			print("play sent !")
    	end

    	if suit.ImageButton(BtnCredit_Normal, {hovered = BtnCredit_Hovered, active = BtnCredit_Active}, 170, 538).hit then
        	CounterSelectedScene = 4
        	changeScene(CounterSelectedScene)
    	end

    	if suit.ImageButton(BtnQuit_Normal, {hovered = BtnQuit_Hovered, active = BtnQuit_Active}, 930, 538).hit then
        	love.event.quit()
    	end
	end

	MainMenuScene.listenerKeyPressed = function (key)
		LoadScreenScene.keyPressed(key)
	end

	------------------------------------------------------ other function

	MainMenuScene.drawBgMainMenu = function ()
		love.graphics.draw(Bg_MainMenu, 0, 0)
	end