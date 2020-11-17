world:addCollisionClass('Wall')
world:addCollisionClass('Player')
world:addCollisionClass('Enemy', {ignores = {'Enemy', 'Player'}})
world:addCollisionClass('WaterEnemy', {ignores = {'Enemy', 'Player', 'Wall'}})
world:addCollisionClass('Weapon', {ignores = {'Player', 'Wall', 'Enemy', 'WaterEnemy'}})
world:setQueryDebugDrawing(true)
