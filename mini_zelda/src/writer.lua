writer = {}
phrases = {}

writing = false

function writeHere(id, txt, x, y, time)

    for i, phrase in ipairs(phrases) do
        if id == phrase.id then
            return
        end
    end

    local phrase = {}

    phrase.type = 'phrase'

    phrase.id = id
    phrase.completeTxt = txt
    phrase.x = x
    phrase.y = y

    phrase.txt = ''
    phrase.timer = 0
    phrase.letters = 0
    phrase.letterTimer = time

    phrase.finish = false
    
    table.insert(phrases, phrase)
end

function textWait(id, time)

    for i, wait in ipairs(phrases) do
        if id == wait.id then
            return
        end
    end
    local wait = {}

    wait.type = 'wait'

    wait.id = id
    wait.timer = 0
    wait.letterTimer = time
    wait.finish = false

    table.insert(phrases, wait)
end

function writer:update(dt)

    for i, phrase in ipairs(phrases) do
        writing = true
        if phrase.finish == true then goto continue end

        if phrase.type == 'phrase' then

            phrase.timer = phrase.timer + 1 * dt
            if phrase.timer >= phrase.letterTimer then
                phrase.timer = 0
                phrase.letters = phrase.letters + 1
                sounds.text:play()
            end

            phrase.txt = phrase.completeTxt:sub(1, phrase.letters)

            if phrase.letters >= #phrase.completeTxt then
                phrase.finish = true
            end

        elseif phrase.type == 'wait' then
            phrase.timer = phrase.timer + 1 * dt
            if phrase.timer >= phrase.letterTimer then
                phrase.finish = true
            end
        end

        if phrase.finish == false then
            return
        end

        ::continue::
        writing = false
    end
end

function writer:draw()
    for i, phrase in ipairs(phrases) do
        if phrase.type == 'phrase' and (gameState == 'running' or gameState == 'shardCollected') then
            love.graphics.print(phrase.txt, phrase.x, phrase.y+guiY)
        end
    end
end

function clearPhrases()
    phrases = {}
end
