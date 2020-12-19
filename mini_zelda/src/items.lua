items = {}
itemsNotToDisappear = {2,4,5,8,9,10,11}

shard1Spawn = false
shard1Collected = false

key11Spawn = false
key11Collected = false
key15Spawn = false
key15Collected = false
key26Spawn = false
key26Collected = false
key28Spawn = false
key28Collected = false

map1Spawn = false
compass1Spawn = false

heartContainer1Spawn = false
heartContainer1Collected = false

-- id = item
-- 1 = recovery heart
-- 2 = key
-- 3 = orange rupee
-- 4 = heart container
-- 5 = triforce shard
-- 6 = blue rupee
-- 7 = fairy
-- 8 = map
-- 9 = compass
-- 10 = wooden sword
-- 11 = bow

function spawnItem(id, x, y)
    local item = {}
    item.id = id
    item.x = x
    item.y = y
    item.collected = false
    item.timer = 0
    if id == 1 then
        item.sprite = sprites.recoverHeart
        local itemGrid = anim8.newGrid(7, 8, item.sprite:getWidth(), item.sprite:getHeight())
        item.spriteAnim = anim8.newAnimation(itemGrid('1-2', 1), 0.1)

        item.x = item.x + item.sprite:getWidth() / 2 - 3
        item.y = item.y + item.sprite:getHeight() / 2

    elseif id == 2 then
        sounds.keyAppear:play()
        item.sprite = sprites.key
        local itemGrid = anim8.newGrid(8, 16, item.sprite:getWidth(), item.sprite:getHeight())
        item.spriteAnim = anim8.newAnimation(itemGrid(1, 1), 1)

        item.x = item.x + item.sprite:getWidth() / 2 
        item.y = item.y + item.sprite:getHeight() / 2 - 4
        
    elseif id == 3 then
        item.sprite = sprites.rupee
        local itemGrid = anim8.newGrid(16, 16, item.sprite:getWidth(), item.sprite:getHeight())
        item.spriteAnim = anim8.newAnimation(itemGrid('1-2', 1), 0.1)

        item.x = item.x + item.sprite:getWidth() / 2 - 16
        item.y = item.y + item.sprite:getHeight() / 2 - 8
    elseif id == 4 then
        item.sprite = sprites.heartContainer
        local itemGrid = anim8.newGrid(13, 13, item.sprite:getWidth(), item.sprite:getHeight())
        item.spriteAnim = anim8.newAnimation(itemGrid(1, 1), 1)

        item.x = item.x + item.sprite:getWidth() / 2 - 6.5
        item.y = item.y + item.sprite:getHeight() / 2 - 6.5

    elseif id == 5 then

        item.sprite = sprites.triforceShard
        local itemGrid = anim8.newGrid(10, 10, item.sprite:getWidth(), item.sprite:getHeight())
        item.spriteAnim = anim8.newAnimation(itemGrid('1-2', 1), 0.1)

        item.x = item.x + item.sprite:getWidth() / 2 - 5
        item.y = item.y + item.sprite:getHeight() / 2 - 5

    elseif id == 6 then
        item.sprite = sprites.rupee
        local itemGrid = anim8.newGrid(16, 16, item.sprite:getWidth(), item.sprite:getHeight())
        item.spriteAnim = anim8.newAnimation(itemGrid(2, 1), 0.1)

        item.x = item.x + item.sprite:getWidth() / 2 - 16
        item.y = item.y + item.sprite:getHeight() / 2 - 8

    elseif id == 7 then
        sounds.getItem:play()
        item.sprite = sprites.fairy
        local itemGrid = anim8.newGrid(8, 16, item.sprite:getWidth(), item.sprite:getHeight())
        item.spriteAnim = anim8.newAnimation(itemGrid('1-2', 1), 0.07)

        item.x = item.x + item.sprite:getWidth() / 2 - 4
        item.y = item.y + item.sprite:getHeight() / 2 - 8

    elseif id == 8 then
        item.sprite = sprites.map
        local itemGrid = anim8.newGrid(8, 16, item.sprite:getWidth(), item.sprite:getHeight())
        item.spriteAnim = anim8.newAnimation(itemGrid(1, 1), 1)

        item.x = item.x + item.sprite:getWidth() / 2 - 4
        item.y = item.y + item.sprite:getHeight() / 2 - 8

    elseif id == 9 then
        item.sprite = sprites.compass
        local itemGrid = anim8.newGrid(15, 16, item.sprite:getWidth(), item.sprite:getHeight())
        item.spriteAnim = anim8.newAnimation(itemGrid(1, 1), 1)

        item.x = item.x + item.sprite:getWidth() / 2 - 7.5
        item.y = item.y + item.sprite:getHeight() / 2 - 8
        
    elseif id == 10 then
        item.sprite = sprites.woodenSword
        item.spriteAnim = Sword.up

        item.x = item.x + item.sprite:getWidth() / 2 - 5
        item.y = item.y + item.sprite:getHeight() / 2 - 5
        
    elseif id == 11 then
        item.sprite = sprites.bow
        local itemGrid = anim8.newGrid(8, 16, item.sprite:getWidth(), item.sprite:getHeight())
        item.spriteAnim = anim8.newAnimation(itemGrid(1, 1), 0.1)

        item.x = item.x + item.sprite:getWidth() / 2 - 4
        item.y = item.y + item.sprite:getHeight() / 2 - 8
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
        if currentItem.timer >= 10 and not contains(currentItem.id, itemsNotToDisappear) then
            table.remove(items, i)
            currentItem.timer = 0
        end
        currentItem.spriteAnim:update(dt)
    end
end

function items:draw()
    love.graphics.setColor(1, 1, 1, 1)
    for i, item in ipairs(items) do
        item.spriteAnim:draw(item.sprite, item.x, item.y+guiY)
    end
end

function checkIfItemExist(id)
    for i, item in ipairs(items) do
        if item.id == id then
            return true
        end
    end
    return false
end

function deleteItems()
    for i = 1, #items, 1 do 
        table.remove(items, i)
    end
end
