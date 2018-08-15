--[[
    -- Selection State --
]]


SelectionState = Class{__includes = BaseState}

function SelectionState:init()

    -- currently selected menu item
    self.currentMenuItem = 1

    self.transitionAlpha = 0
    
    self.options = SELECTIONS_START
    
    self.nameInputMode = false

    self.canInput = true
end

function SelectionState:enter(params)

end

function SelectionState:update(dt)

    if love.keyboard.wasPressed('escape') then
        if self.nameInputMode then
            self.nameInputMode = false
        else
            gStateMachine:change('title')
        end
    end

    if self.canInput then
        
        if self.nameInputMode then
            if love.wasPressed('input')  then
                gStateMachine:change('play', {name = textInput})
            end
        else
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
                if self.currentMenuItem == 1 then
                    self.nameInputMode = true
                    textInput = ''
                else
                end
            end
        end
    end
end

function SelectionState:render()
   
    -- TODO: render background here 7/24/18 -AW
   
    -- keep the background darker than normal
    love.graphics.setColor(0, 0, 0, 128)
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)

    if self.nameInputMode then
        SelectionState.drawTextInput(gFonts['CapricaSans64'], VIRTUAL_HEIGHT_2)
    else
        SelectionState.drawTitle('MAIN MENU', gFonts['CapricaSans128'], VIRTUAL_HEIGHT / 6)
        SelectionState.drawSelections(
            self.options, self.currentMenuItem, gFonts['CapricaSans64'], VIRTUAL_HEIGHT_2)
    end

    -- draw our transition rect; is normally fully transparent, unless we're moving to a new state
    love.graphics.setColor(255, 255, 255, self.transitionAlpha)
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
end

function SelectionState.drawTitle(title, font, y)
    love.graphics.setFont(font)

    local textWidth = font:getWidth(title)
    local textHeight = font:getHeight(title)
    
    love.graphics.setColor(DARK_MAGENTA)
    love.graphics.printf(title, 0, y, VIRTUAL_WIDTH, 'center')
end

function SelectionState.drawSelections(options, currentOption, font, y)
    love.graphics.setFont(font)

    for k, tag in pairs(options) do        
        
        height = y + MENU_TEXT_JUMP * (k - 1)        

        if currentOption == k then
            love.graphics.setColor(SLATE_BLUE)
        else
            love.graphics.setColor(COOL_BLUE)
        end
        
        love.graphics.printf(tag, 0, height, VIRTUAL_WIDTH, 'center')
    end
end

function SelectionState.drawTextInput(font, y)
    love.graphics.setFont(font)
    love.graphics.setColor(SLATE_BLUE)
    love.graphics.printf(textInput, 0, y, VIRTUAL_WIDTH, 'center')
end