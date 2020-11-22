enemies = {}

require 'src/octoroks'
require 'src/zoras'
require 'src/tektikes'
require 'src/leevers'
require 'src/peahat'

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

    if leevers ~= nil then
        leevers:update(dt)
    end

    if peahats ~= nil then
        peahats:update(dt)
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

    if leevers ~= nil then
        leevers:draw()
    end

    if peahats ~= nil then
        peahats:draw()
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

    if enemies_room[currentRoom][6] ~= nil then
        spawnEnemy(enemies_room[currentRoom][6], 'red_leever')
    end

    if enemies_room[currentRoom][7] ~= nil then
        spawnEnemy(enemies_room[currentRoom][7], 'blue_leever')
    end

    if enemies_room[currentRoom][8] ~= nil then
        spawnEnemy(enemies_room[currentRoom][8], 'peahat')
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

        if enemy == 'red_leever' then
            spawnLeever('red')
        elseif enemy == 'blue_leever' then
            spawnLeever('blue')
        end

        if enemy == 'peahat' then
            spawnPeahat()
        end

    end
end

function deleteAllEntities()
    deleteOctoroks()
    deleteZoras()
    deleteTektikes()
    deleteLeevers()
    deletePeahats()
end
