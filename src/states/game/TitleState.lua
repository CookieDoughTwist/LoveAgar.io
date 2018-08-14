--[[

]]

TitleState = Class{__includes = BaseState}

function TitleState:init()

    self.canInput = true
    self.titleAlpha = 0
    self.enterAlpha = 0
    
    Timer.after(TITLE_DELAY, function()
        Timer.tween(TITLE_FADE_IN, {
            [self] = {titleAlpha = 1}
        })
    end)
    
    Timer.after(ENTER_DELAY, function()
        Timer.tween(ENTER_FADE_IN, {
            [self] = {enterAlpha = 1}
        })
        :finish(function()
            Timer.tween(ENTER_PERIOD, {
                [self] = {enterAlpha = 100/255}
            })
            Timer.every(ENTER_PERIOD, function()
                newEnterAlpha = self.enterAlpha > 200/255 and
                    100/255 or 1
                Timer.tween(ENTER_PERIOD, {
                    [self] = {enterAlpha = newEnterAlpha}
                })
            end)
        end)
    end)
    
end

function TitleState:update(dt)
        
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
    
    if self.canInput then
        if love.wasPressed('select') then
            self.canInput = false
            gStateMachine:change('select')
        end
    end
end

function TitleState:render()
    
    love.graphics.setColor(FULL_COLOR)
    love.graphics.draw(gTextures['blue_cells'], 0, 0)
    
    love.graphics.setFont(gFonts['CapricaSans256'])
    
    love.graphics.setColor(0, 0, 0, self.titleAlpha)
    love.graphics.printf('LoveAgar.io', SHADOW_OFFSET, VIRTUAL_HEIGHT / 4 - 40 + SHADOW_OFFSET, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(1, 1, 1, self.titleAlpha)
    love.graphics.printf('LoveAgar.io', 0, VIRTUAL_HEIGHT / 4 - 40, VIRTUAL_WIDTH, 'center')
    
    love.graphics.setFont(gFonts['CapricaSans128'])
    
    love.graphics.setColor(0, 0, 0, self.enterAlpha)
    love.graphics.printf('Press Enter', SHADOW_OFFSET, VIRTUAL_HEIGHT / 2 + 167 + SHADOW_OFFSET, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(1, 1, 1, self.enterAlpha)
    love.graphics.printf('Press Enter', 0, VIRTUAL_HEIGHT / 2 + 167, VIRTUAL_WIDTH, 'center')
end
