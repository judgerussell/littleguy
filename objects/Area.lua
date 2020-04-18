Area = Object:extend()

function Area:new(room)
	self.room = room
	self.game_objects = {}
end

function Area:update(dt)

	for i = #self.game_objects, 1, -1 do
		local game_object = self.game_objects[i]
		game_object:update(dt)
		if game_object.dead then 
			game_object:destroy()
			table.remove(self.game_objects, i) 
		end
	end


	table.sort(self.game_objects, function (a, b)
			return a.depth < b.depth
	end)
end

function Area:draw()

	
	for _, game_object in ipairs(self.game_objects) do game_object:draw() end
end

function Area:addGameObject(game_object_type, x, y, opts)
	local opts = opts or {}
	local game_object = _G[game_object_type](self, x or 0, y or 0, opts)
	table.insert(self.game_objects, game_object)
	return game_object
end

function Area:killGameObject(i)
	local game_object = self.game_objects[i]
	game_object.dead = true
end

function Area:getGameObjects(func)
	return M.select(self.game_objects, func) or {}
end

function Area:queryCircleArea(x, y, radius, classes)
	local objects = {}
	
	for _, v in ipairs(self.game_objects) do
	
		correct_type = false
	
		for _, c in ipairs(classes) do
			if v.type == c then
				correct_type = true
			end
		end
	
		dist = math.sqrt((v.x - x)^2 + (v.y - y)^2)
		
		if correct_type and dist <= radius then
			table.insert(objects, v)
		end
	end
	
	return objects
end

function Area:getClosestObject(x, y, radius, classes)
	local object = {}
	shortest_dist = math.huge
	
	for _, v in ipairs(self.game_objects) do
	
		correct_type = false
	
		for _, c in ipairs(classes) do
			if v.type == c then
				correct_type = true
			end
		end
	
		dist = math.sqrt((v.x - x)^2 + (v.y - y)^2)
		
		if correct_type and dist <= radius then
			if not object or dist < shortest_dist then
				object = v
			end
		end
	end
	
	return object
end

function Area:addPhysicsWorld()
	self.collider = HC.new()
end

function Area:destroy()

	for i = #self.game_objects, 1, -1 do
		local game_object = self.game_objects[i]
		game_object:destroy()
		table.remove(self.game_objects, i) 
	end

	if self.collider then 
		self.collider:resetHash()
		self.collider = nil
	end
end

function Area:destroyAllGameObjects()

	for i = #self.game_objects, 1, -1 do
		local game_object = self.game_objects[i]
		game_object:destroy()
		table.remove(self.game_objects, i) 
	end

end