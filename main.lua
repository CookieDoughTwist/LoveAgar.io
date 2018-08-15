--[[
    LoveAgar.io

    Author: Andrew Wang
    andrew01810@gmail.com    
]]

-- requires and resource initializations
require 'src/Dependencies'

textInput = ''

function love.load()
    
    -- window bar title
    love.window.setTitle('LoveAgar.io')

    -- seed the RNG
    math.randomseed(os.time())

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        vsync = true,
        resizable = true,
        canvas = false
    })

    gStateMachine = StateMachine {
        ['title'] = function() return TitleState() end,
        ['select'] = function() return SelectionState() end,
        ['play'] = function() return PlayState() end,
    }

    gStateMachine:change('title')

    -- initialize input table
    love.keyboard.keysPressed = {}
    love.mouse.buttonsPressed = {}
    love.bindings = {}
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.textinput(text)
    textInput = textInput .. text
end

function love.keypressed(key)
    
    if key == "backspace" then
        -- get the byte offset to the last UTF-8 character in the string.
        local byteoffset = utf8.offset(textInput, -1)
 
        if byteoffset then
            -- remove the last UTF-8 character.
            -- string.sub operates on bytes rather than UTF-8 characters, so we couldn't do string.sub(text, 1, -2).
            textInput = string.sub(textInput, 1, byteoffset - 1)
        end
    end

    -- add to our table of keys pressed this frame
    love.keyboard.keysPressed[key] = true
    if key == 'enter' or key == 'return' or key == 'kpenter' then
        love.bindings['input'] = true
    end
    if love.bindings['input'] or key == 'space' then
        love.bindings['select'] = true
    end
    if key == '=' or key == 'kp+' then
        love.bindings['increment'] = true
    end
    if key == '-' or key == 'kp-' then
        love.bindings['decrement'] = true
    end
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

function love.mousepressed(x, y, button)    
    gameX, gameY = push:toGame(x, y)
    love.mouse.buttonsPressed[button] = {gameX, gameY}
end

function love.mouse.wasPressed(button)
    return love.mouse.buttonsPressed[button]
end

function love.wheelmoved(x, y)
    if y > 0 then
        love.mouse.buttonsPressed['wheelup'] = y
        love.bindings['increment'] = true
    elseif y < 0 then
        love.mouse.buttonsPressed['wheeldown'] = y
        love.bindings['decrement'] = true
    end
end

function love.wasPressed(key)
    return love.bindings[key]
end

function love.update(dt)

    gStateMachine:update(dt)

    -- initialize input table
    love.keyboard.keysPressed = {}
    love.mouse.buttonsPressed = {}
    love.bindings = {}

    -- update global tween timer
    Timer.update(dt)
end

function love.draw()
    
    push:start()
    
    gStateMachine:render()
    
    push:finish()
end