--[[
    Bombardment

    Author: Andrew Wang
    andrew01810@gmail.com
]]

-- external libraries
Class = require 'lib/class'
push = require 'lib/push'
Timer = require 'lib/knife.timer'
socket = require 'socket'

require 'src/constants'

-- network
require 'src/network/Client'
require 'src/network/PlayerClient'

-- states
require 'src/states/StateMachine'
require 'src/states/BaseState'

-- game states
require 'src/states/game/TitleState'

-- sounds
gSounds = {

}

-- images
gTextures = {
    -- https://pngtree.com/freebackground/human-cells-bacteria-and-other-biological-high-resolution-images_9000.html
    ['blue_cells'] = love.graphics.newImage('resources/graphics/backgrounds/blue_cells.png'),
}

-- texture quads
gFrames = {
    
}

-- fonts
gFonts = {
    -- http://www.fontspace.com/m%C3%A5ns-greb%C3%A4ck/caprica-sans-personal-use    
    ['CapricaSans64'] = love.graphics.newFont('resources/fonts/CapricaSans.ttf', 64),
    ['CapricaSans128'] = love.graphics.newFont('resources/fonts/CapricaSans.ttf', 128),
    ['CapricaSans256'] = love.graphics.newFont('resources/fonts/CapricaSans.ttf', 256),
}

    