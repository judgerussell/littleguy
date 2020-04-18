LittleGuy = GameObject:extend()

function LittleGuy:new(area, x, y, opts)
    LittleGuy.super.new(self, area, x, y, opts)
    self.animations = animx.newActor('img/tamagotchisprites.png')
    self.animations = self.animations:loopAll()
    self.animations:switch('normal')

    self.hunger = 100
    self.boredom = 100
    self.sleep = 100
    self.stepcount = 0

    input:bind('e', 'eat')
    input:bind('t', 'tunes')
    input:bind('g', 'game')

    timer:every(.25, function()
        print(self.stepcount)
        if math.random(-1, 1) < 0 then
            self.animations:switch('walking')
            if text == nil then 
                self.stepcount = self.stepcount + 1
            end
            if math.random(-1, 1) < 0 then
                self.x = self.x - 5
            else
                self.x = self.x + 5
            end
        else
            self.animations:switch('normal')
        end
    end)

    timer:every(1, function () 
        self.hunger = self.hunger - 1
        self.boredom = self.boredom - 1
        self.sleep = self.sleep - 1
    end)
end 

function LittleGuy:update(dt)
    LittleGuy.super.update(dt)

    if input:pressed('eat') then 

    elseif input:pressed('tunes') then
    
    elseif input:pressed('game') then

    end
end

function LittleGuy:draw()
    love.graphics.print("Hunger: "..self.hunger, 350, 66)
    love.graphics.print("Boredom: "..self.boredom, 350, 102)
    love.graphics.print("Sleep: "..self.sleep, 550, 66)
    self.animations:draw(self.x, self.y, 0, 6, 6, self.animations:getWidth() / 2, self.animations:getHeight() / 2)
end