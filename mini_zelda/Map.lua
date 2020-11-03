Map = Class{}

local sti = require 'sti'
local SCROLL_SPEED = 50

windfield = require 'windfield'

function Map:init()
    map = sti('tilemaps/testmap.lua')
    world = windfield.newWorld()

    testWall = world:newRectangleCollider(48, 130, 16, 16)
    testWall:setType('static')
end

function Map:update(dt)

end

function Map:draw()
end
