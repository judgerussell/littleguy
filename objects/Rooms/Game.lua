Game = Object:extend()

function Game:new(state)
	self.area = Area(self)
	self.area:addPhysicsWorld()
    self.main_canvas = love.graphics.newCanvas(gx, gy)
    input:bind("space", "talk")
    input:bind("z", "talk")
    input:bind("up", "choose-up")
    input:bind("down", "choose-down")


    sprites["n"] = {}
    sprites["n"]["n"] = love.graphics.newImage("img/ness.png")
    sprites["p"] = {}
    sprites["p"]["n"] = love.graphics.newImage("img/paula.png")
    sprites["j"] = {}
    sprites["j"]["n"] = love.graphics.newImage("img/jeff.png")

    self.background = love.graphics.newImage("img/background.png")

    self.area:addGameObject('LittleGuy', gw/2, gh/2, {})


end

function Game:update(dt)
	camera.smoother = Camera.smooth.damped(5)
    camera:lockPosition(dt, gw/2, gh/2)

    if input:pressed("talk") and not text then
        run("scripts/TestScript.lua")
    end

    updateText(dt)

    animx.update(dt)

    timer:update(dt)

end

function Game:draw()
    love.graphics.setCanvas(self.main_canvas)
    love.graphics.clear()
        camera:attach(0, 0, gw, gh)
        love.graphics.ellipse('fill', gw/2, gh/2, 600, 800)
        love.graphics.draw(self.background, 340, 60)
        self.area:draw()
        drawText()
        camera:detach()
    love.graphics.setCanvas()

    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.setBlendMode('alpha', 'premultiplied')
    love.graphics.draw(self.main_canvas, 0, 0, 0, sx, sy)
    love.graphics.setBlendMode('alpha')
end

function Game:destroy()
	self.area:destroy()
	self.area = nil
end

function drawText()
    if text then 
        if orientation == "l" then
            love.graphics.draw(sprites[character][emotion], 375, 250, 0, -1, 1)
        else
            love.graphics.draw(sprites[character][emotion], 900, 250)
        end

        love.graphics.setColor(0, 0, 0)
        love.graphics.rectangle('fill', 75, 525, 1130, 170)
        love.graphics.setColor(1, 1, 1)
        love.graphics.rectangle('line', 75, 525, 1130, 170)
        if opt_flag then
            for i, option in ipairs(text) do
                if answer == i then
                    love.graphics.print(option.." <-", 100, 550 + (i - 1) * 36)
                else
                    love.graphics.print(option, 100, 550 + (i - 1) * 36)
                end
            end
        else
            love.graphics.print(text, 100, 550)
        end
    end
end

function updateText(dt)
    if text and string_ptr < #text then
        string_ptr = string_ptr + dt * 20
    end

    if opt_flag and input:pressed("choose-up") then
        answer = answer - 1
        if answer < 1 then
            answer = #text
        end
    end 

    if opt_flag and input:pressed("choose-down") then
        answer = (answer % #text) + 1
    end
end