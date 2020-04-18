LittleGuy = GameObject:extend()

function LittleGuy:new(area, x, y, opts)
    LittleGuy.super.new(self, area, x, y, opts)
    self.animations = animx.newActor('img/tamagotchisprites.png')
    self.animations = self.animations:loopAll()
    self.animations:switch('normal')

    self.action = false
    self.hunger = 100
    self.content = 100
    self.energy = 100
    self.happiness = 100
    self.lights = true
    self.stepcount = 0

    input:bind('e', 'eat')
    input:bind('t', 'tunes')
    input:bind('g', 'game')

    timer:every(.25, function()
        if not self.action then 
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
        end
    end)

    timer:every(1, function () 
        if not self.action and not text then
            self.hunger = self.hunger - 1
            self.content = self.content - 1
            self.energy = self.energy - 1
            if self.hunger < 1 then self.hunger = 0 end
            if self.content < 1 then self.content = 0 end
            if self.energy < 1 then self.energy = 0 end
            if self.happiness < 1 then self.happiness = 0 end

            if self.hunger < 10 or self.content < 10 or self.energy < 10 then
                camera:shake(6, 60, .4)
                self.happiness = self.happiness - 5
            end

            local rand = love.math.random(0, 100)
            if self.energy < 25 and rand < 40 then
                self:sleep(math.random(10, 15))
            elseif rand < 1 then
                self:sleep(math.random(3, 10))
            end
        end
    end)
end 

function LittleGuy:update(dt)
    LittleGuy.super.update(self, dt)
    if self.hunger > 99 then self.hunger = 100 end
    if self.content > 99 then self.content = 100 end
    if self.energy > 99 then self.energy = 100 end
    if self.happiness > 99 then self.happiness = 100 end

    if littleguy_increment ~= 0 then 
        self.happiness = self.happiness + littleguy_increment 
        littleguy_increment = 0
    end
end

function LittleGuy:draw()
    love.graphics.print("Hunger: "..self.hunger, 350, 66)
    love.graphics.print("Entertainment: "..self.content, 350, 102)
    love.graphics.print("Energy: "..self.energy, 650, 66)
    love.graphics.print("Happiness: "..self.happiness, 650, 102)
    self.animations:draw(self.x, self.y, 0, 6, 6, self.animations:getWidth() / 2, self.animations:getHeight() / 2)
end

function LittleGuy:eat()
    if not self.action then
        self.action = true
        self.hunger = self.hunger + 25
        self.energy = self.energy + 5
        self.animations:switch('eat')
        timer:after(2, function () self.action = false end) 
    end
end

function LittleGuy:tunes()
    if not self.action then
        self.action = true
        self.content = self.content + 15
        self.hunger = self.hunger - 5
        self.energy = self.energy - 10
        self.animations:switch('dance')
        timer:after(2, function () 
            self.action = false 
            run("scripts/music1.lua")
        end)
    end
end

function LittleGuy:play()
    if not self.action then
        self.content = self.content + 25
        self.hunger = self.hunger - 15
        self.energy = self.energy - 15
        self.action = true
        timer:after(2, function () self.action = false end)
    end
end

function LittleGuy:sleep(time)
    if not self.action then
        self.action = true
        self.energy = self.energy + 6 * time
        self.animations:switch('side')
        timer:every(1, function () 
            if not self.lights then 
                self.happiness = self.happiness + 2
            else
                self.happiness = self.happiness - 2
            end
        end, time) 
        timer:after(time, function () self.action = false end)
    end
end

function LittleGuy:talk()
    if not self.action then
        run('scripts/FoodScript.lua')
    end
end

function LittleGuy:lightswitch()
    self.lights = not self.lights
end

function LittleGuy:increaseValues(vals)
    self.hunger = self.hunger + (vals.hunger or 0)
    self.energy = self.energy + (vals.energy or 0)
    self.content = self.content + (vals.content or 0)
    self.happiness = self.happiness + (vals.happiness or 0)
end