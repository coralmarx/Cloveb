-- Alright lets do this!

-- Requires

require("lldebugger").start()

require("variants.vector2")

require("libraries.mui")

-- Variables

G = 100

-- Functions

function love.load ()

    love.window.setMode(800, 600, { vsync = true, msaa = 0, highdpi = true })

    local mainTheme = Mui.newTheme( {0.5,0.5,0.5}, {0.25,0.25,0.25}, 4, 4, 1, 0, love.graphics.newFont("fonts/AlteHaasGroteskRegular.ttf") )

    local debugMenu = Mui.newTabbar( RootContainer, Vector2.new( 0, 0 ), Vector2.new( 400, 400 ), mainTheme )

end

function love.draw ()

    Mui:draw()

end

function love.update ( delta )

    Mui:update()

end

function love.mousepressed ( x, y, key )
    
    Mui:mousePressed()

end