Object = require 'libraries/classic/classic'
Input = require 'libraries/boipushy/Input'
Timer = require 'libraries/hump/timer'
M = require 'libraries/Moses/moses'
Camera = require 'libraries/hump/camera'
HC = require 'libraries/HardonCollider'
--vector = require 'libraries/hump/vector'
--list = require 'libraries/ListBox/listbox'
animx = require 'libraries/animX'
scale = 1

-- for dialogue
text = nil
routine = nil
orientation = nil
character = nil
emotion = nil
string_ptr = 2
opt_flag = false
answer = nil

sprites = {}

function love.load()
	local object_files = {}
	recursiveEnumerate('objects', object_files)
	requireFiles(object_files)

	font = love.graphics.newFont("fonts/Helvetica-bold-italic.ttf", 32)
	love.graphics.setFont(font)

	camera = Camera()
	
	input = Input()
	
	input:bind('f1', print_garbage_info)
    input:bind('f2', function() goToRoom('Game') end)
	input:bind('f3', 'delete')
	
	input:bind('mouse1', 'click')
	
	love.graphics.setDefaultFilter('nearest')
	love.graphics.setLineStyle('rough')
	resize(scale)
    
	timer = Timer()
	goToRoom("Game")

end

function love.update(dt)
	
    if current_room then current_room:update(dt) end
    
    camera:update(dt)
    
    if input:pressed('delete') then 
		current_room:destroy() 
		current_room=nil
	end
    
end

function love.draw()
	if current_room then current_room:draw() end
end

function love.keypressed(key, isRepeat)
	if _G.text and key == "space" or key == "z" then
		if routine and coroutine.status(routine) ~= "dead" then
			coroutine.resume(routine)
			string_ptr = 2
		end
	end
end

function ask(str, c, o, e, s, opts, convo_options)
	say(str, c, o, e, s)
	_G.character = c
	_G.orientation = o
	_G.emotion = e
	_G.text = ""
	_G.opt_flag = true
	_G.text = opts
	_G.answer = 1
	coroutine.yield()
	_G.opt_flag = false
	convo_options[answer]()
	_G.text = nil
	_G.character = nil
	_G.orientation = nil
	_G.emotion = nil
	_G.answer = nil
end

function say(str, c, o, e, s)
	length = str:len()
	if length > 64 then
		_G.text = ""
		lines = math.ceil(length / 64)
		for i = 1, lines do
			_G.text = _G.text..str:sub((i - 1) * 64 + 1, i * 64 + 1).."\n"
		end
	else
		_G.text = str
	end
	_G.character = c
	_G.orientation = o
	_G.emotion = e
	if s then camera:shake(10, 60, .4) end
    coroutine.yield()
	_G.text = nil
	_G.character = nil
	_G.orientation = nil
	_G.emotion = nil
end

function run(script)
	local f, err = loadfile(script)
    routine = coroutine.create(f)

    coroutine.resume(routine)
end

function goToRoom(room_type, ...)
	if current_room and current_room.destroy then current_room:destroy() end
	text = nil
	routine = nil
	current_room = _G[room_type](...)
end

function recursiveEnumerate(folder, file_list)
	local items = love.filesystem.getDirectoryItems(folder)
	for _, item in ipairs(items) do
		if item == "scripts" then goto continue end
		local path = folder .. '/' .. item
		if love.filesystem.getInfo(path, 'file') then
			table.insert(file_list, path)
		elseif love.filesystem.getInfo(path, 'directory') then
			recursiveEnumerate(path, file_list)
		end
		:: continue ::
	end
end

function requireFiles(files) 
	for _, file in ipairs(files) do
		local file = file:sub(1, -5)
		require(file)
	end
end

function resize(s)
	love.window.setMode(s*gw, s*gh)
	sx, sy = s, s
end

function count_all(f)
    local seen = {}
    local count_table
    count_table = function(t)
        if seen[t] then return end
            f(t)
	    seen[t] = true
	    for k,v in pairs(t) do
	        if type(v) == "table" then
		    count_table(v)
	        elseif type(v) == "userdata" then
		    f(v)
	        end
	end
    end
    count_table(_G)
end

function type_count()
    local counts = {}
    local enumerate = function (o)
        local t = type_name(o)
        counts[t] = (counts[t] or 0) + 1
    end
    count_all(enumerate)
    return counts
end

global_type_table = nil
function type_name(o)
    if global_type_table == nil then
        global_type_table = {}
            for k,v in pairs(_G) do
	        global_type_table[v] = k
	    end
	global_type_table[0] = "table"
    end
    return global_type_table[getmetatable(o) or 0] or "Unknown"
end

function print_garbage_info()
	print("Before collection: " .. collectgarbage("count")/1024)
	collectgarbage()
	print("After collection: " .. collectgarbage("count")/1024)
	print("Object count: ")
	local counts = type_count()
	for k, v in pairs(counts) do print(k, v) end
	print("-------------------------------------")
end


