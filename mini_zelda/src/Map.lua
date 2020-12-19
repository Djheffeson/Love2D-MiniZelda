Map = Class{}

room_1 = nil
room_2 = nil
room_3 = 'assets/tilemaps/overworld/room_3.lua'
room_4 = 'assets/tilemaps/overworld/room_4.lua'
room_5 = 'assets/tilemaps/overworld/room_5.lua'
room_6 = nil
room_7 = 'assets/tilemaps/overworld/room_7.lua'
room_8 = 'assets/tilemaps/overworld/room_8.lua'
room_9 = 'assets/tilemaps/overworld/room_9.lua'
room_10 = 'assets/tilemaps/overworld/room_10.lua'
room_11 = 'assets/tilemaps/overworld/room_11.lua'
room_12 = 'assets/tilemaps/overworld/room_12.lua'
room_13 = 'assets/tilemaps/overworld/room_13.lua'
room_14 = 'assets/tilemaps/overworld/room_14.lua'
room_15 = 'assets/tilemaps/overworld/room_15.lua'
room_16 = 'assets/tilemaps/overworld/room_16.lua'
room_17 = 'assets/tilemaps/overworld/room_17.lua'
room_18 = 'assets/tilemaps/overworld/room_18.lua'
room_19 = 'assets/tilemaps/overworld/room_19.lua'
room_20 = 'assets/tilemaps/overworld/room_20.lua'
room_21 = 'assets/tilemaps/overworld/room_21.lua'
room_22 = 'assets/tilemaps/overworld/room_22.lua'
room_23 = 'assets/tilemaps/overworld/room_23.lua'
room_24 = 'assets/tilemaps/overworld/room_24.lua'
room_25 = 'assets/tilemaps/overworld/room_25.lua'

overworldRooms = {
    room_1, room_2, room_3, room_4, room_5, 
    room_6, room_7, room_8, room_9, room_10,
    room_11, room_12, room_13, room_14, room_15,
    room_16, room_17, room_18, room_19, room_20,
    room_21, room_22, room_23, room_24, room_25
}

currentOverworldRoom = 23

dRoom_1 = nil
dRoom_2 = nil
dRoom_3 = nil
dRoom_4 = nil
dRoom_5 = 'assets/tilemaps/dungeon_1/room_5.lua'
dRoom_6 = 'assets/tilemaps/dungeon_1/room_6.lua'
dRoom_7 = 'assets/tilemaps/dungeon_1/room_7.lua'
dRoom_8 = 'assets/tilemaps/dungeon_1/room_8.lua'
dRoom_9 = 'assets/tilemaps/dungeon_1/room_9.lua'
dRoom_10 = 'assets/tilemaps/dungeon_1/room_10.lua'
dRoom_11 = 'assets/tilemaps/dungeon_1/room_11.lua'
dRoom_12 = nil
dRoom_13 = nil
dRoom_14 = 'assets/tilemaps/dungeon_1/room_14.lua'
dRoom_15 = 'assets/tilemaps/dungeon_1/room_15.lua'
dRoom_16 = 'assets/tilemaps/dungeon_1/room_16.lua'
dRoom_17 = nil
dRoom_18 = nil
dRoom_19 = nil
dRoom_20 = nil
dRoom_21 = 'assets/tilemaps/dungeon_1/room_21.lua'
dRoom_22 = nil
dRoom_23 = nil
dRoom_24 = nil
dRoom_25 = nil
dRoom_26 = 'assets/tilemaps/dungeon_1/room_26.lua'
dRoom_27 = 'assets/tilemaps/dungeon_1/room_27.lua'
dRoom_28 = 'assets/tilemaps/dungeon_1/room_28.lua'
dRoom_29 = nil
dRoom_30 = nil

dungeon1Rooms = {
    dRoom_1, dRoom_2, dRoom_3, dRoom_4, dRoom_5, dRoom_6,
    dRoom_7, dRoom_8, dRoom_9, dRoom_10, dRoom_11, dRoom_12,
    dRoom_13, dRoom_14, dRoom_15, dRoom_16, dRoom_17, dRoom_18,
    dRoom_19, dRoom_20, dRoom_21, dRoom_22, dRoom_23, dRoom_24,
    dRoom_25, dRoom_26, dRoom_27, dRoom_28, dRoom_29, dRoom_30
}

currentDungeonRoom = 27

cRoom = 'assets/tilemaps/cavern/cavern.lua'

-- 0: empty
-- 1: sword cavern
-- 2: bow cavern
currentCavernRoom = 0

colliders = {}

function respawnOverworld()
    deleteRoomCollisions()
    currentOverworldRoom = 23
    Map:init()
end

function respawnDungeon1()
    deleteRoomCollisions()
    currentDungeonRoom = 27
    changeMap('dungeon_1')
    Player.enter = true
    clearDoors()
    doorsSpawn()
end

function Map:init()

    mapX = 0
    mapY = 0 

    tmpMapX = 0
    tmpMapY = 0

    Map.type = 'overworld'

    tmpMap = sti(overworldRooms[currentOverworldRoom], { 'box2d' })
    map = sti(overworldRooms[currentOverworldRoom], { 'box2d' })

    Map.nextMap = ''
    changing_room = false
    direct = ''

    createRoomCollisions()
    enemiesPerRoom()

    Map.timer = 0
    Map.timer1 = 0

end

function Map:update(dt)

    if gameState == 'shardCollected' then
        endGame.start = true
    end

    if Player.enter ~= true and Player.out ~= true and Player.state ~= 'dead' and gameState ~= 'shardCollected' then
        if Map.type == 'overworld' then
            sounds.dungeonTheme:stop()
            sounds.overworldTheme:play()
        elseif Map.type == 'dungeon_1' then
            sounds.overworldTheme:stop()
            sounds.dungeonTheme:play()
        else
            sounds.overworldTheme:stop()
            sounds.dungeonTheme:stop()
        end
    else
        sounds.dungeonTheme:stop()
        sounds.overworldTheme:stop()
    end


    if Map.type == 'cavern' then
        if currentCavernRoom == 1 then
            if #NPCs == 0 and Player.slot1 == nil then
                npcSpawn(120, 121, 1)
            elseif Player.slot1 ~= nil then
                clearPhrases()
                npcDisappear()
            end
        elseif currentCavernRoom == 2 then
            if #NPCs == 0 and Player.slot2 == nil then
                npcSpawn(120, 121, 2)
            elseif Player.slot2 ~= nil then
                clearPhrases()
                npcDisappear()
            end
        end
    end
    
    roomsLogic()

    -- check if is not the dungeon exit for not activate the "changing_room"
    local isNotDungeon1Exit = not (Map.type == 'dungeon_1' and currentDungeonRoom == 27)

    if Player.y <= 62 and love.keyboard.isDown('up') and Player.direction == 'up' then
        direct = 'up'
        changing_room = true

    elseif Player.y >= 226 and love.keyboard.isDown('down') and Player.direction == 'down' 
            and isNotDungeon1Exit then

        direct = 'down'
        changing_room = true

    elseif Player.x <= 6 and love.keyboard.isDown('left') and Player.direction == 'left' then
        direct = 'left'
        changing_room = true
    elseif Player.x >= 250 and love.keyboard.isDown('right') and Player.direction == 'right' then
        direct = 'right'
        changing_room = true
    end

    if gameState == 'death' then
        return
    end

    -- Prevents player to move when the room is changing
    if changing_room then
        gameState = 'changingRoom'
        Map.timer = Map.timer + 1 * dt
        if Map.timer >= 0.5 then
            nextRoom(direct)
        end
        Map.timer1 = 0
    elseif gameState ~= 'running' and gameState ~= 'shardCollected' then
        gameState = 'animation'
    elseif gameState ~= 'shardCollected' then
        gameState = 'running'
    end
end

function Map:draw()

    if gameState == 'shardCollected' or gameState == 'death' then
        return
    end
    
    if gameState == 'changingRoom' then
        tmpMap:draw(tmpMapX, tmpMapY+56)
    end
    map:draw(mapX, mapY+56)
    love.graphics.setShader()
end

function Map:drawDungeonWalls()

    if gameState == 'changingRoom' and tmpMap.layers[3].name == 'Wall_layer' then
        local x = tmpMap.layers[3].x
        local y = tmpMap.layers[3].y

        tmpMap.layers[3].x = tmpMapX
        tmpMap.layers[3].y = tmpMapY+56

        tmpMap:drawLayer(tmpMap.layers[3])

        tmpMap.layers[3].x = x
        tmpMap.layers[3].y = y
    end

    local x = map.layers[3].x
    local y = map.layers[3].y

    map.layers[3].x = mapX
    map.layers[3].y = mapY+56

    map:drawLayer(map.layers[3])

    map.layers[3].x = x
    map.layers[3].y = y

end

function changeMap(type_map)
    deleteItems()
    deleteNPCs()
    clearPhrases()
    Map.type = type_map
    if type_map == 'overworld' then
        loading = true
        
        Player.collider:setPosition(120, 129)
        Player.x, Player.y = Player.collider:getPosition()

        map = sti(overworldRooms[currentOverworldRoom], { 'box2d' })
        deleteRoomCollisions()
        createRoomCollisions()
        deleteAllEntities()
        enemiesPerRoom()
    end

    if type_map == 'dungeon_1' then

        Player.collider:setPosition(128, 231)
        Player.x, Player.y = Player.collider:getPosition()

        map = sti(dungeon1Rooms[currentDungeonRoom], { 'box2d' })
        deleteRoomCollisions()
        createRoomCollisions()
        deleteAllEntities()
        enemiesPerRoom()
        clearDoors()
        doorsSpawn()
    end

    if type_map == 'cavern' then

        Player.collider:setPosition(128, 231)
        Player.x, Player.y = Player.collider:getPosition()

        map = sti(cRoom, { 'box2d' })
        deleteRoomCollisions()
        createRoomCollisions()
        deleteAllEntities()
    end
    
    doorsCreated = false
end

function nextRoom(direction)

    local nxRoom
    if Map.type == 'overworld' then
        if direction == 'up' then
            nxRoom = currentOverworldRoom - 5

        elseif direction == 'down' then
            nxRoom = currentOverworldRoom + 5

        elseif direction == 'left' then
            nxRoom = currentOverworldRoom - 1

        elseif direction == 'right' then
            nxRoom = currentOverworldRoom + 1
        end

    elseif Map.type == 'dungeon_1' then
        if direction == 'up' then
            nxRoom = currentDungeonRoom - 6

        elseif direction == 'down' then
            nxRoom = currentDungeonRoom + 6

        elseif direction == 'left' then
            nxRoom = currentDungeonRoom - 1

        elseif direction == 'right' then
            nxRoom = currentDungeonRoom + 1
        end
    end
    deleteAllEntities()
    deleteItems()
    moveRoom(nxRoom, direction)
end

function moveRoom(room, direction)
    deleteRoomCollisions()
    local speed
    if Map.type == 'overworld' then
        tmpMap = sti(overworldRooms[room], { 'box2d' })
        speed = 4
    elseif Map.type == 'dungeon_1' then
        tmpMap = sti(dungeon1Rooms[room], { 'box2d' })
        speed = 2
        createTmpDoors(room)
    end

    tmpMapX = 0
    tmpMapY = 0

    if direction == 'down' then
        for i = 1, speed, 1 do
            mapY = mapY - 1
            tmpMapY = mapY + 168
            
            if Player.y >= 66 then
                Player.y = Player.y - 1
                Player.collider:setPosition(Player.x, Player.y)
            end

            if Map.type == 'dungeon_1' then
                for i, door in ipairs(currentDoors) do
                    door.y = door.y - 1
                end

                for i, door in ipairs(tmpDoors) do
                    door.y = door.y - 1
                end
            end

            if mapY <= -168 then
                changeRoom(room)
            end
        end

    elseif direction == 'up' then
        for i = 1, speed, 1 do
            mapY = mapY + 1
            tmpMapY = mapY - 168

            if Player.y <= 225 then
                Player.y = Player.y + 1
                Player.collider:setPosition(Player.x, Player.y)
            end

            if Map.type == 'dungeon_1' then
                for i, door in ipairs(currentDoors) do
                    door.y = door.y + 1
                end

                for i, door in ipairs(tmpDoors) do
                    door.y = door.y + 1
                end
            end

            if mapY >= 168 then
                changeRoom(room)
            end
        end

    elseif direction == 'right' then
        for i = 1, speed, 1 do
            mapX = mapX - 1
            tmpMapX = mapX + 256

            if Player.x >= 8 then
                Player.x = Player.x - 1
                Player.collider:setPosition(Player.x, Player.y)
            end

            if Map.type == 'dungeon_1' then
                for i, door in ipairs(currentDoors) do
                    door.x = door.x - 1
                end

                for i, door in ipairs(tmpDoors) do
                    door.x = door.x - 1
                end
            end

            if mapX <= -256 then
                changeRoom(room)
            end
        end

    elseif direction == 'left' then
        for i = 1, speed, 1 do
            mapX = mapX + 1
            tmpMapX = mapX - 256

            if player.x <= 249 then
                Player.x = Player.x + 1
                Player.collider:setPosition(Player.x, Player.y)
            end

            if Map.type == 'dungeon_1' then
                for i, door in ipairs(currentDoors) do
                    door.x = door.x + 1
                end

                for i, door in ipairs(tmpDoors) do
                    door.x = door.x + 1
                end
            end
            
            if mapX >= 256 then
                changeRoom(room)
            end
        end
    end
end

function changeRoom(room)
    deleteNPCs()
    clearPhrases()
    changing_room = false
    mapX = 0
    mapY = 0 
    
    if Map.type == 'overworld' then
        currentOverworldRoom = room
        map = sti(overworldRooms[currentOverworldRoom], { 'box2d' })
    elseif Map.type == 'dungeon_1' then
        currentDungeonRoom = room
        map = sti(dungeon1Rooms[currentDungeonRoom], { 'box2d' })

        Player.enterInUndergroundRoom = true
        Player.walkDistance = 16
    end
    
    deleteRoomCollisions()
    createRoomCollisions()
    enemiesPerRoom()

    if Map.type == 'dungeon_1' then
        clearDoors()
        doorsSpawn()
    end
end

function createRoomCollisions()
    collideLayer = map.layers[4].objects
    for i, j in pairs(collideLayer) do
        -- Get the X and Y of the object for collide
        local collideObjectX = map.layers[4].objects[i].x
        local collideObjectY = map.layers[4].objects[i].y
        -- Create a collide box in the position of the object "collide"
        collideBox = world:newRectangleCollider(
            collideObjectX,
            collideObjectY-8+56,
            8,
            8
        )
        collideBox:setCollisionClass('Wall')
        collideBox:setType('static')

        table.insert(colliders, collideBox)
    end
    map:removeLayer('Collide')

    map:addCustomLayer('Walls', 5)
    map.layers[5] = copyTable(map.layers[3])

end

function deleteRoomCollisions()
    for i, v in ipairs(colliders) do
        v:destroy()
    end
    colliders = {}
    clearDoorsCollisions()
end

function roomsLogic()

    if Map.type == 'dungeon_1' and gameState ~= 'changingRoom' then
        if currentDungeonRoom == 5 then
            if enemiesDungeon1_rooms[currentDungeonRoom][6] == 0 and heartContainer1Collected == false then
                if heartContainer1Spawn == false then
                    spawnItem(4, 193, 138)
                    heartContainer1Spawn = true
                end
            end
            
        elseif currentDungeonRoom == 6 then
            if shard1Spawn == false and shard1Collected == false then
                spawnItem(5, 118, 143)
                shard1Spawn = true
            end

        elseif currentDungeonRoom == 9 and Player.hasMap1 == false then
            if map1Spawn == false then
                spawnItem(8, 196, 136)
                map1Spawn = true
            end

        elseif currentDungeonRoom == 11 and key11Collected == false and key11Spawn == false then
            spawnItem(2, 160, 180)
            key11Spawn = true

        elseif currentDungeonRoom == 15 and key15Collected == false then
            if enemiesDungeon1_rooms[currentDungeonRoom][3] <= 0 and key15Spawn == false then
                spawnItem(2, 144, 100)
                key15Spawn = true
            end

        elseif currentDungeonRoom == 16 and Player.hasCompass1 == false then
            if compass1Spawn == false then
                spawnItem(9, 192, 136)
                compass1Spawn = true
            end

        elseif currentDungeonRoom == 26 and key26Collected == false then
            if enemiesDungeon1_rooms[currentDungeonRoom][1] <= 0 and key26Spawn == false then
                spawnItem(2, 160, 180)
                key26Spawn = true
            end

        elseif currentDungeonRoom == 28 and key28Collected == false then
            if enemiesDungeon1_rooms[currentDungeonRoom][3] <= 0 and key28Spawn == false then
                spawnItem(2, 192, 132)
                key28Spawn = true
            end
        end

        if currentDungeonRoom == 7 and gameState == 'running' then
            if #NPCs == 0 then
                npcSpawn(120, 121, 3)
            end
        end

    elseif Map.type == 'overworld' and gameState ~= 'changingRoom' then

        if currentOverworldRoom == 5 and #fairies == 0 then
            spawnFairy(124, 118)
        end

    end

    if gameState == 'changingRoom' then
        key11Spawn = false
        key15Spawn = false
        key26Spawn = false
        key28Spawn = false
        map1Spawn = false
        compass1Spawn = false
        heartContainer1Spawn = false
    end
end

function checkLayer(layer, x, y)
    local x = math.floor(x)
    local y = math.floor(y)

    if map.layers[layer].data[y-6][x+1] ~= nil then
        local tileID = map.layers[layer].data[y-6][x+1].gid
        if layer == 'Ground_layer' then
            
            if tileID == 5 then
                return 'sand'

            elseif tileID == 428 and Map.type == 'dungeon_1' then
                return 'dungeon_brick'
            end

        elseif layer == 'Water_layer' then
            watersID = {
                289, 290, 291, 292, 293, 294,
                325, 326, 327, 328, 329, 330,
                361, 362, 363, 364, 365, 366,
                397, 398, 399, 400, 401, 402,
                433, 434, 435, 436, 437, 438,
                469, 470, 471, 472, 473, 474,

                301, 302, 303, 304, 305, 306, 
                337, 338, 339, 340, 341, 342, 
                373, 374, 375, 376, 377, 378, 
                409, 410, 411, 412, 413, 414, 
                445, 446, 447, 448, 449, 450, 
                481, 482, 483, 484, 485, 486,
            }

            if contains(tileID, watersID) then
                return 'water'
            end
        end
    else
        return 'none'
    end
end
