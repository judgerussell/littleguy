MenuItem = GameObject:extend()

function MenuItem:new(area, x, y, opts) 
    MenuItem.super.new(self, area, x, y, opts)
    self.r = opts.r
    self.collider = self.area.collider:circle(x, y, self.r, "MenuItem")
    self.func = opts.func
    self.collision = false
end

function MenuItem:update(dt)
    MenuItem.super.update(self, dt)

    for i, obj in ipairs(self.area:getGameObjects(function (o) return o.collider and o.collider.class == "Cursor" end)) do
        self.collision = self.collider:collidesWith(obj.collider)
    end

    if self.collision and input:pressed("click") then
        self.func()
    end

end

function MenuItem:draw()
    if self.collision then
        love.graphics.setColor(1, 0, 0)
    else
        love.graphics.setColor(0, 0, 0)
    end
    self.collider:draw('fill')
    love.graphics.setColor(1, 1, 1)
end