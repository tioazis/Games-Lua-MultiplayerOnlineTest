

function CreateGameObject(nm,img,posx,posy,rot,sclx,scly,offx,offy,behav)
	local temporaryObject = {}
	temporaryObject.Name = nm
	temporaryObject.Image = img
	temporaryObject.PositionX = posx
	temporaryObject.PositionY = posy
	temporaryObject.Rotation = rot 
	temporaryObject.ScaleX = sclx 
	temporaryObject.ScaleY = scly
	temporaryObject.OffsetX = offx
	temporaryObject.OffsetY = offy 
	temporaryObject.Behaviour = behav

	temporaryObject.Move = function ( ... )
		
		-- body
	end

	return temporaryObject
	-- body
end