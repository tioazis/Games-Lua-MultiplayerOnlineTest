LoadScreenScene = {}

	LoadScreenScene.initialize = function ()

	end
	------------------------------------------------------ main function

	LoadScreenScene.draw = function ()
		LoadScreenScene.drawBgLoadScreen()	
		LoadScreenScene.drawLoadLogo()		
	end


	LoadScreenScene.update = function ()
		if suit.ImageButton(BtnCancel_Normal, {hovered = BtnCancel_Hovered, active = BtnCancel_Active}, 554, 460).hit then
        	changeScene(CounterSelectedScene -1)
    	end
	end

	LoadScreenScene.listenerKeyPressed = function (key)
		LoadScreenScene.keyPressed(key)
	end

	------------------------------------------------------ other function 
	
	LoadScreenScene.drawBgLoadScreen = function ()
		love.graphics.draw(Bg_LoadScreen,0,0)
	end

	LoadScreenScene.drawLoadLogo = function ()
		love.graphics.draw(Load_Logo,554,165)
	end

	LoadScreenScene.keyPressed = function (key)
		if key == "pageup"  then
			changeScene(CounterSelectedScene +1)
		end
	end