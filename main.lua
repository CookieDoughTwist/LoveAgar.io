--[[
    LoveAgar.io

    Author: Andrew Wang
    andrew01810@gmail.com    
]]

-- requires and resource initializations
--require 'src/Dependencies'

function love.load()
    
    -- window bar title
    love.window.setTitle('LoveAgar.io')

    -- seed the RNG
    math.randomseed(os.time())

    -- initialize input table
    love.keyboard.keysPressed = {}
    love.mouse.buttonsPressed = {}
    love.bindings = {}
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
    
    -- add to our table of keys pressed this frame
    love.keyboard.keysPressed[key] = true
    if key == 'enter' or key == 'return' or key == 'kpenter' or key == 'space' then
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
    
    -- update global tween timer
    Timer.update(dt)
end

function love.draw()
    
    push:start()
    
    gStateMachine:render()
    
    push:finish()
end