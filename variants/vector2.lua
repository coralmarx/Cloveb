
Vector2 = {}
Vector2.__index = Vector2

--- @param x number
--- @param y number
function Vector2.new ( x, y )

    local vector = {}

    setmetatable(vector, Vector2)

    vector.x, vector.y = x, y

    return vector

end

-- Aadddinggg stuff :3 i love vectors --

function Vector2.__unm ( a )    return Vector2.new( 0 - a.x, 0 - a.y )     end
function Vector2.__add ( a, b ) if type(a) == "number" then return Vector2.new( b.x + a, b.y + a ) elseif type(b) == "table" then return Vector2.new( a.x + b.x, a.y + b.y ) else return Vector2.new( a.x + b, a.y + b ) end end
function Vector2.__sub ( a, b ) if type(a) == "number" then return Vector2.new( b.x - a, b.y - a ) elseif type(b) == "table" then return Vector2.new( a.x - b.x, a.y - b.y ) else return Vector2.new( a.x - b, a.y - b ) end end
function Vector2.__mul ( a, b ) if type(a) == "number" then return Vector2.new( b.x * a, b.y * a ) elseif type(b) == "table" then return Vector2.new( a.x * b.x, a.y * b.y ) else return Vector2.new( a.x * b, a.y * b ) end end
function Vector2.__div ( a, b ) if type(a) == "number" then return Vector2.new( b.x / a, b.y / a ) elseif type(b) == "table" then return Vector2.new( a.x / b.x, a.y / b.y ) else return Vector2.new( a.x / b, a.y / b ) end end
function Vector2.__pow ( a, b ) if type(a) == "number" then return Vector2.new( b.x ^ a, b.y ^ a ) elseif type(b) == "table" then return Vector2.new( a.x ^ b.x, a.y ^ b.y ) else return Vector2.new( a.x ^ b, a.y ^ b ) end end

function Vector2.__eq ( a, b ) return a.x == b.x and a.y == b.y end
function Vector2.__lt ( a, b ) return a.x <  b.x and a.y <  b.y end
function Vector2.__le ( a, b ) return a.x <= b.x and a.y <= b.y end

function Vector2.__tostring ( v ) return "(" .. v.x .. ", " .. v.y .. ")" end

function Vector2.ceil  ( self ) return Vector2.new( math.ceil( self.x ),        math.ceil( self.y ) )        end
function Vector2.floor ( self ) return Vector2.new( math.floor( self.x ),       math.floor( self.y ) )       end
function Vector2.round ( self ) return Vector2.new( math.floor( self.x + 0.5 ), math.floor( self.y + 0.5 ) ) end

-- MATH ENDS HERE !!! YAAAY --

function Vector2.getMousePosition () return Vector2.new( love.mouse.getX(), love.mouse.getY() ) end


function Vector2.snapped ( self, snap ) return ( self / snap ):round() * snap end
function Vector2.length ( self ) return math.sqrt( self.x ^ 2 + self.y ^ 2 ) end
function Vector2.lengthSquared ( self ) return self.x ^ 2 + self.y ^ 2 end
function Vector2.distance ( self, other ) return ( self - other ):length() end
function Vector2.distanceSquared ( self, other ) return ( self - other ):lengthSquared() end
function Vector2.absolute ( self ) return Vector2.new( math.abs( self.x ), math.abs( self.y ) ) end
function Vector2.normalized ( self ) if self:length() > 0 then return self / self:length() else return Vector2.new( 0, 0 ) end end
function Vector2.interpolate( self, to, weight ) return self * ( 1 - weight) + to * weight end