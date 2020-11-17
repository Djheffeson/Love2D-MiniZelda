enemies = {}

require 'src/octoroks'
require 'src/zoras'
require 'src/tektikes'

function enemies:update(dt)
    if octoroks ~= nil then
        octoroks:update(dt)
    end

    if zoras ~= nil then
        zoras:update(dt)
    end

    if tektikes ~= nil then
        tektikes:update(dt)
    end
end

function enemies:draw()
    if octoroks ~= nil then
        octoroks:draw()
    end

    if zoras ~= nil then
        zoras:draw()
    end

    if tektikes ~= nil then
        tektikes:draw()
    end
end

function enemiesPerRoom()

    if enemies_room[currentRoom][1] ~= nil then
        spawnEnemy(enemies_room[currentRoom][1], 'red_octorok')
    end

    if enemies_room[currentRoom][2] ~= nil then
        spawnEnemy(enemies_room[currentRoom][2], 'blue_octorok')
    end

    if enemies_room[currentRoom][3] ~= nil then
        spawnEnemy(enemies_room[currentRoom][3], 'zora')
    end

    if enemies_room[currentRoom][4] ~= nil then
        spawnEnemy(enemies_room[currentRoom][4], 'red_tektike')
    end

    if enemies_room[currentRoom][5] ~= nil then
        spawnEnemy(enemies_room[currentRoom][5], 'blue_tektike')
    end

end

function spawnEnemy(quantity, enemy)
    for i = 1, quantity, 1 do

        if enemy == 'red_octorok' then
            spawnOctorok('red')
        elseif enemy == 'blue_octorok' then
            spawnOctorok('blue')
        end

        if enemy == 'zora' then
            spawnZora()
        end

        if enemy == 'red_tektike' then
            spawnTektike('red')
        elseif enemy == 'blue_tektike' then
            spawnTektike('blue')
        end
    end
end

function deleteAllEntities()
    deleteOctoroks()
    deleteZoras()
    deleteTektikes()
end
