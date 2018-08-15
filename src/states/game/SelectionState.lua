--[[
    -- Selection State --
]]


SelectionState = Class{__includes = BaseState}

function SelectionState:init()

    -- currently selected menu item
    self.currentMenuItem = 1

    self.transitionAlpha = 0
    
    self.options = SELECTIONS_START
    
    self.canInput = true

    --gSounds['reselect']:setVolume(0.2)
end

function SelectionState:enter(params)

end

function SelectionState:update(dt)

    if love.keyboard.wasPressed('escape') then
        gStateMachine:change('title')
    end

    if self.canInput then
        
        -- change menu selection
        if love.keyboard.wasPressed('up') and
            self.currentMenuItem ~= 1 then
            self.currentMenuItem = self.currentMenuItem - 1
            --gSounds['reselect']:stop()
            --gSounds['reselect']:play()
        end
        
        if love.keyboard.wasPressed('down') and
            self.currentMenuItem ~= #self.options then
            self.currentMenuItem = self.currentMenuItem + 1
            --gSounds['reselect']:stop()
            --gSounds['reselect']:play()
        end
        
        -- switch to another state via one of the menu options
        if love.wasPressed('select') then
            if self.currentMenuItem > #self.options then
                gStateMachine:change('start')
            else                
                -- tween, using Timer, the transition rect's alpha to 255, then
                -- transition to the BeginGame state after the animation is over
                Timer.tween(T_TRANSITION, {
                    [self] = {transitionAlpha = 255}
                }):finish(function()
                    gStateMachine:change('play', {
                        index = self.currentMenuItem
                    })
                end)
            end

            self.canInput = false
        end
    end
end

function SelectionState:render()
   
    -- TODO: render background here 7/24/18 -AW
   
    -- keep the background darker than normal
    love.graphics.setColor(0, 0, 0, 128)
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)

    SelectionState.drawTitle('MAIN MENU', gFonts['CapricaSans128'], VIRTUAL_HEIGHT / 6)
    SelectionState.drawSelections(
        self.options, self.currentMenuItem, gFonts['CapricaSans64'], VIRTUAL_HEIGHT_2)

    -- draw our transition rect; is normally fully transparent, unless we're moving to a new state
    love.graphics.setColor(255, 255, 255, self.transitionAlpha)
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
end

function SelectionState.drawTitle(title, font, y)
    love.graphics.setFont(font)

    local textWidth = font:getWidth(title)
    local textHeight = font:getHeight(title)
    
    love.graphics.setColor(200, 0, 200, 255)
    love.graphics.printf(title, 0, y, VIRTUAL_WIDTH, 'center')
end

function SelectionState.drawSelections(options, currentOption, font, y)
    love.graphics.setFont(font)

    for k, tag in pairs(options) do        
        
        height = y + MENU_TEXT_JUMP * (k - 1)        

        if currentOption == k then
            love.graphics.setColor(SLATE_BLUE)
        else
            love.graphics.setColor(48, 96, 130, 255)
        end
        
        love.graphics.printf(tag, 0, height, VIRTUAL_WIDTH, 'center')
    end
end