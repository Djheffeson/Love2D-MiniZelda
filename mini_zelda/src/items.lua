items = {}
-- id = item
-- 1 = recovery heart

function spawnItem(id, x, y)
    local item = {}
    item.id = id
    item.x = x
    item.y = y
    item.collected = false
    item.timer = 0
    if id == 1 then
        item.sprite = sprites.recoverHeart
        local itemGrid = anim8.newGrid(7, 8, 
            sprites.recoverHeart:getWidth(), sprites.recoverHeart:getHeight())
        item.spriteAnim = anim8.newAnimation(itemGrid('1-2', 1), 0.1)

        item.x = item.x + item.sprite:getWidth() / 2 - 3
        item.y = item.y + item.sprite:getHeight() / 2
    end

    table.insert(items, item)
end

function items:update(dt)
    for i = #items, 1, -1 do
        local currentItem = items[i]
        if currentItem.collected == true then
            table.remove(items, i)
        end

        -- timer for item despawn
        currentItem.timer = currentItem.timer + 1 * dt
        if currentItem.timer >= 8.100 then
            currentItem.timer = 0
            table.remove(items, i)
        end

        currentItem.spriteAnim:update(dt)
    end
end

function items:draw()
    love.graphics.setColor(1, 1, 1, 1)
    for i, itemd in ipairs(items) do
        itemd.spriteAnim:draw(itemd.sprite, itemd.x, itemd.y)
    end
end

function deleteItems()
    for i = 1, #items, 1 do 
        table.remove(items, i)
    end
end
