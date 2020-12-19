NPCs = {}
firesVisible = false

local fireGrid = anim8.newGrid(16, 16, sprites.fire:getWidth(), sprites.fire:getHeight())
fireAnim = anim8.newAnimation(fireGrid('1-2', 1), 0.1)

-- Types:
-- 1: oldman
function npcSpawn(x, y, type)

    local npc = {}
    npc.x = x
    npc.y = y
    npc.type = type
    npc.disappearing = false
    npc.exists = true

    if npc.type == 1 then
        npc.sprite = sprites.oldman
    elseif npc.type == 2 then
        npc.sprite = sprites.merchant
    elseif npc.type == 3 then
        npc.sprite = sprites.oldmanDungeon
    end

    npc.timerDisappear = 0

    table.insert(NPCs, npc)
end

function NPCs:update(dt)

    if Map.type == 'cavern' or currentDungeonRoom == 7 and gameState == 'running' then
        fireAnim:update(dt)
        firesVisible = true
    else
        firesVisible = false
    end

    if gameState == 'changingRoom' then
        deleteNPCs()
    end

    for i, npc in ipairs(NPCs) do

        if currentCavernRoom == 1 and Player.slot1 == nil then
            writeHere(1, "it's dangerous to go\n  alone! take this.", 48, 96, 0.1)
            if checkIfItemExist(10) == false then
                spawnItem(10, 108, 118)
            end
        end

        if currentCavernRoom == 2 and Player.slot2 == nil then
            writeHere(1, "take this bow,", 72, 96, 0.1)
            writeHere(2, "it should help you.", 56, 104, 0.1)
            if checkIfItemExist(11) == false then
                spawnItem(11, 124, 160)
            end
        end

        if currentDungeonRoom == 7 then
            writeHere(1, "eastmost penninsula\n   is the secret.", 52, 96, 0.1)
        end

        if npc.disappearing then
            npc.timerDisappear = npc.timerDisappear + 1 * dt
            if npc.timerDisappear >= 1 then
                npc.disappearing = false
                deleteNPCs()
            end
        end

    end
end

function NPCs:draw()
     
    if firesVisible then
        fireAnim:draw(sprites.fire, 72, 121)
        fireAnim:draw(sprites.fire, 168, 121)
    end

    for i, npc in ipairs(NPCs) do

        if npc.disappearing == true then
            if math.floor(math.cos(love.timer.getTime() * 1000 % 2 * math.pi)) == 0 then
                love.graphics.draw(npc.sprite, npc.x, npc.y)
            end
        else
            love.graphics.draw(npc.sprite, npc.x, npc.y)
        end
        
    end
end

function npcDisappear()
    for i, npc in ipairs(NPCs) do
        npc.disappearing = true
    end
end

function deleteNPCs()
    for i, npc in ipairs(NPCs) do
        table.remove(NPCs, i)
    end
end
