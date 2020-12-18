arrows = {}

function shootArrow()

    local arrow = {}

    arrow.x = Player.x 
    arrow.y = Player.y 
    arrow.sx = 1
    arrow.sy = 1
    arrow.rotation = 0
    arrow.direction = Player.direction
    arrow.sprite = sprites.arrow
    arrow.state = 'moving'
    arrow.damage = 1

    if arrow.direction == 'up' then
        arrow.x = arrow.x - 3
        arrow.y = arrow.y - 31
        arrow.sy = 1
        Player.currentAnimation = Player.attackUp
        arrow.collider = world:newRectangleCollider(arrow.x+2.5, arrow.y+8, 5, 16)

    elseif arrow.direction == 'down' then
        arrow.sy = -1
        arrow.x = arrow.x - 3
        arrow.y = arrow.y + 24
        Player.currentAnimation = Player.attackDown
        arrow.collider = world:newRectangleCollider(arrow.x+2.5, arrow.y-8, 5, 16)

    elseif arrow.direction == 'left' then
        arrow.x = arrow.x - 28
        arrow.y = arrow.y - 1
        arrow.rotation = math.rad(-90)
        Player.currentAnimation = Player.attackLeft
        arrow.collider = world:newRectangleCollider(arrow.x+8, arrow.y-2, 16, 5)

    elseif arrow.direction == 'right' then
        arrow.x = arrow.x + 28
        arrow.y = arrow.y - 4
        arrow.rotation = math.rad(90)
        Player.currentAnimation = Player.attackRight
        arrow.collider = world:newRectangleCollider(arrow.x-8, arrow.y+2, 16, 5)
    end

    arrow.collider:setCollisionClass('Arrow')
    arrow.colliderExists = true

    arrow.timer = 0
    table.insert(arrows, arrow)

    Player.money = Player.money - 1
    Player.state = 'attacking'

    if math.random(2) == 1 then
        sounds.text:play()
    else
        sounds.arrowSound:play()
    end
end

function arrows:update(dt)
    for i, arrow in ipairs(arrows) do 

        if arrow.state == 'moving' then
            if arrow.direction == 'up' then
                arrow.y = arrow.y - 3
                arrow.collider:setPosition(arrow.x+2.5, arrow.y+8)

            elseif arrow.direction == 'down' then
                arrow.y = arrow.y + 3
                arrow.collider:setPosition(arrow.x+2.5, arrow.y-8)

            elseif arrow.direction == 'left' then
                arrow.x = arrow.x - 3
                arrow.collider:setPosition(arrow.x+8, arrow.y-2)

            elseif arrow.direction == 'right' then
                arrow.x = arrow.x + 3
                arrow.collider:setPosition(arrow.x-8, arrow.y+2)
            end
        elseif arrow.state == 'collide' then
            arrow.sprite = sprites.splash
            arrowDestroy(i, dt)
        end
        
        if arrow.x >= VIRTUAL_WIDTH or arrow.x <= 0 then
            arrow.state = 'collide'
        elseif arrow.y >= VIRTUAL_HEIGHT or arrow.y <= 56 then
            arrow.state = 'collide'
        end

        if arrow.collider:enter('Enemy') or arrow.collider:enter('IgnoreWallEnemy') and arrow.colliderExists then
            arrow.state = 'collide'
        end

    end
end

function arrows:draw()
    for i, arrow in ipairs(arrows) do 
        love.graphics.draw(arrow.sprite, arrow.x, arrow.y, arrow.rotation, arrow.sx, arrow.sy)
    end
end

function arrowDestroy(index, dt)
    local arrow = arrows[index]
    arrow.timer = arrow.timer + 1 * dt 
    if arrow.colliderExists == true then
        arrow.collider:destroy()
        arrow.colliderExists = false
    end
    if arrow.timer >= 0.03 then
        table.remove(arrows, i)
    end
end
