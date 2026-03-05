Mui = {}
Mui.__index = Mui

Mui.draw = function ( self ) RootContainer:draw() end
Mui.update = function ( self ) RootContainer:update( delta ) end
Mui.mousePressed = function ( self, mouseX, mouseY, key ) RootContainer:mousePressed( mouseX, mouseY, key ) end

RootContainer = { parent = "Window", position = Vector2.new( 0, 0 ), rawPosition = Vector2.new( 0, 0 ), elements = {}, draw = function ( self ) for index,element in ipairs( self.elements ) do if element.visible then element:draw() end end end, update = function ( self, delta ) for index,element in ipairs( self.elements ) do element:update( delta ) end end, mousePressed = function ( self, mouseX, mouseY, key) for index,element in ipairs( self.elements ) do element:mousePressed( mouseX, mouseY, key ) end end}

Mui.newTheme = function ( buttonColor, panelColor, buttonRounding, panelRounding, buttonOutline, panelOutline, font )

    local newTheme = {}

    newTheme.font = font

    newTheme.button = {
        base =      {0.5,0.5,0.5},
        pressed =   {0.2,0.2,0.2},
        highlight = {0.75, 0.75, 0.75},

        rounding = 4,
        outline = 1.5,
    }

    newTheme.panel = {
        base =   {0.2, 0.2, 0.2},

        rounding = 4,
        outline = 1.5,
    }

    newTheme.font:setFilter("nearest", "nearest")

    return newTheme

end

Mui.newContainer = function ( parent, position )

    local newContainer = {}

    newContainer.parent = parent or RootContainer

    newContainer.position = position or Vector2.new(0,0)

    newContainer.rawPosition = newContainer.position + parent.rawPosition
    
    newContainer.elements = {}

    newContainer.draw = function ( self ) for index,element in ipairs( self.elements ) do if element.visible then element:draw() end end end
    
    newContainer.update = function ( self, delta ) for index,element in ipairs( self.elements ) do element:update( delta ) end end

    newContainer.mousePressed = function ( self, mouseX, mouseY, key) for index,element in ipairs( self.elements ) do element:mousePressed( mouseX, mouseY, key ) end end

    newContainer.visible = parent.visible or true

    table.insert(newContainer.parent.elements, newContainer)

    return newContainer

end

Mui.newPanel = function ( parent, position, size, theme )

    local newPanel = {}

    newPanel.parent = parent or RootContainer

    newPanel.position = position or Vector2.new(0,0)
    newPanel.size = size or Vector2.new(10,10)
    newPanel.theme = theme

    newPanel.rawPosition = newPanel.position + parent.rawPosition

    newPanel.elements = {}

    newPanel.visible = parent.visible or true

    newPanel.draw = function ( self ) 

        love.graphics.setColor(self.theme.panel.base); love.graphics.rectangle("fill", self.position.x, self.position.y, self.size.x, self.size.y, self.theme.panelRounding)

        if self.theme.panelOutline > 0 then love.graphics.setColor(1,1,1); love.graphics.setLineWidth(self.theme.panelOutline); love.graphics.rectangle("line", self.position.x, self.position.y, self.size.x, self.size.y, self.theme.panelRounding) end

        for index,element in ipairs( self.elements ) do if element.visible then element:draw() end end

    end

    newPanel.update = function ( self, delta ) for index,element in ipairs( self.elements ) do element:update( delta ) end; self.rawPosition = self.position + parent.rawPosition end
    
    newPanel.mousePressed = function ( self, mouseX, mouseY, key) 
        for index,element in ipairs( self.elements ) do element:mousePressed( mouseX, mouseY, key ) end
    end
    
    table.insert(newPanel.parent.elements, newPanel)

    return newPanel

end

--- @param script function Script
--- @param position table Vector2
--- @param size table Vector2
--- @param theme table Theme
Mui.newButton = function (parent, position, size, theme, label, script )

    local newButton = {}

    newButton.script = script or function () print("No Script Given :/") end
    newButton.position = position or Vector2.new(100,100)
    newButton.size = size or Vector2.new(110, 80)
    newButton.label = label or "NULL"
    newButton.theme = theme or { color = {1,1,1} }
    newButton.parent = parent or RootContainer
    newButton.visible = parent.visible or true

    newButton.rawPosition = newButton.position + parent.rawPosition

    newButton.elements = {}

    newButton.touchingMouse = function ( self ) return Vector2.getMousePosition() >= self.rawPosition and Vector2.getMousePosition() <= self.rawPosition + self.size end

    newButton.draw = function ( self )

        theme = self.theme.button
        
        if self:touchingMouse() and love.mouse.isDown(1) then love.graphics.setColor(theme.pressed) elseif self:touchingMouse() then love.graphics.setColor(theme.highlight) else love.graphics.setColor(theme.base) end

        love.graphics.rectangle("fill", self.rawPosition.x, self.rawPosition.y, size.x, size.y, self.theme.buttonRounding)

        if self.theme.buttonOutline > 0 then love.graphics.setColor(1,1,1); love.graphics.setLineWidth(self.theme.buttonOutline); love.graphics.rectangle("line", parent.position.x + position.x, parent.position.y + position.y, size.x, size.y, self.theme.buttonRounding) end

        love.graphics.printf(self.label, ( self.rawPosition.x ), ( self.size.y / 2 ) + ( ( self.rawPosition.y ) - ( self.theme.font:getHeight(self.label) / 2 ) ), self.size.x, "center" )

        for index,element in ipairs( self.elements ) do if element.visible then element:draw() end end

    end

    newButton.update = function ( self, delta )

        self.rawPosition = self.position + parent.rawPosition

    end

    newButton.mousePressed = function ( self, mouseX, mouseY, key) 

        if self:touchingMouse() and self.visible then self:script() end

    end

    table.insert(newButton.parent.elements, newButton)

    return newButton

end

Mui.newTabbar = function ( parent, position, size, theme, tabs )

    local newTabbar = {}

    newTabbar.position = position
    newTabbar.size = size
    newTabbar.theme = theme
    newTabbar.parent = parent
    newTabbar.visible = parent.visible or true

    newTabbar.rawPosition = newTabbar.position + newTabbar.parent.rawPosition

    newTabbar.elements = {}

    newTabbar.draw = function ( self )
        print(1)
        love.graphics.rectangle("line", self.rawPosition.x, self.rawPosition.y, self.size.x, self.size.y)

        for index,element in ipairs( self.elements ) do if element.visible then element:draw() end end

    end

    newTabbar.update = function ( self, delta ) 
        self.rawPosition = self.position + parent.rawPosition
    end

    newTabbar.mousePressed = function ( mouseX, mouseY, key ) end

    table.insert(newTabbar.parent.elements, newTabbar)

    return newTabbar

end


