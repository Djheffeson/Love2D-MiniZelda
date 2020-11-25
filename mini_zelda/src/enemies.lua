enemies = {}

require 'src/enemies/overworld/octoroks'
require 'src/enemies/overworld/zoras'
require 'src/enemies/overworld/tektikes'
require 'src/enemies/overworld/leevers'
require 'src/enemies/overworld/peahat'

require 'src/enemies/dungeons/keeses'

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

    if keeses ~= nil then
        keeses:update(dt)
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

    if keeses ~= nil then
        keeses:draw()
    end

end

function enemiesPerRoom()
    if Map.type == 'overworld' then
        if enemies_room[currentOverworldRoom][1] ~= nil then
            spawnEnemy(enemies_room[currentOverworldRoom][1], 'red_octorok')
        end

        if enemies_room[currentOverworldRoom][2] ~= nil then
            spawnEnemy(enemies_room[currentOverworldRoom][2], 'blue_octorok')
        end

        if enemies_room[currentOverworldRoom][3] ~= nil then
            spawnEnemy(enemies_room[currentOverworldRoom][3], 'zora')
        end

        if enemies_room[currentOverworldRoom][4] ~= nil then
            spawnEnemy(enemies_room[currentOverworldRoom][4], 'red_tektike')
        end

        if enemies_room[currentOverworldRoom][5] ~= nil then
            spawnEnemy(enemies_room[currentOverworldRoom][5], 'blue_tektike')
        end

        if enemies_room[currentOverworldRoom][6] ~= nil then
            spawnEnemy(enemies_room[currentOverworldRoom][6], 'red_leever')
        end

        if enemies_room[currentOverworldRoom][7] ~= nil then
            spawnEnemy(enemies_room[currentOverworldRoom][7], 'blue_leever')
        end

        if enemies_room[currentOverworldRoom][8] ~= nil then
            spawnEnemy(enemies_room[currentOverworldRoom][8], 'peahat')
        end
    elseif Map.type == 'dungeon_1' then
        if enemiesDungeon1_rooms[currentDungeonRoom][1] ~= nil then
            spawnEnemy(enemiesDungeon1_rooms[currentDungeonRoom][1], 'keese')
        end
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

        if enemy == 'keese' then
            spawnKeese()
        end

    end
end

function deleteAllEntities()
    deleteOctoroks()
    deleteZoras()
    deleteTektikes()
    deleteLeevers()
    deletePeahats()
    deleteKeeses()
end
