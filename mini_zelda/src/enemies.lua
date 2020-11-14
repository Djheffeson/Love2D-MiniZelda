enemies = {}

function enemies:update(dt)
    if octoroks ~= nil then
        octoroks:update(dt)
    end
end

function enemies:draw()
    if octoroks ~= nil then
        octoroks:draw()
    end
end

function enemiesPerRoom()

    if enemies_room[currentRoom][1] ~= nil then
        spawnEnemy(enemies_room[currentRoom][1], 'red_octorok')
    end

    if enemies_room[currentRoom][2] ~= nil then
        spawnEnemy(enemies_room[currentRoom][2], 'blue_octorok')
    end

end

function spawnEnemy(quantity, enemy)
    for i = 1, quantity, 1 do
        if enemy == 'red_octorok' then
            spawnOctorok('red')
        elseif enemy == 'blue_octorok' then
            spawnOctorok('blue')
        end
    end
end

function deleteAllEntities()
    deleteOctoroks()
end