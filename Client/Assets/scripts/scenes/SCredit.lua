CreditScene = {}

	CreditScene.initialize = function ()

	end
	------------------------------------------------------ main function

	CreditScene.draw = function ()
		CreditScene.drawBgCredit()		
	end


	CreditScene.update = function ()
		if suit.ImageButton(BtnBack_Normal, {hovered = BtnBack_Hovered, active = BtnBack_Active}, 32, 630).hit then
        	CounterSelectedScene = 1
        	changeScene(CounterSelectedScene)
    	end
	end

	CreditScene.listenerKeyPressed = function (key)
		LoadScreenScene.keyPressed(key)
	end

	------------------------------------------------------ other function 
	
	CreditScene.drawBgCredit = function ()
		love.graphics.draw(Bg_Credit,0,0)
	end