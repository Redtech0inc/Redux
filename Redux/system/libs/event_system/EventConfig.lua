EventConfig = {}
EventConfig.__index = EventConfig

local function toboolean(value)
    if value then return true end
    return false
end

function EventConfig:init()
    local obj = {}

    obj.eventTypes = {}
    obj.onlyOnFocus = {}

    setmetatable(obj, self)
    return obj
end

--builder functions
function EventConfig:addType(type)
    if type(type) ~= "string" then return self end
    self.eventTypes[type] = true
    return self
end

function EventConfig:setOnFocused(type)
    if type(type) ~= "string" or not self.eventTypes[type] then return self end
    self.onlyOnFocus[type] = true
    return self
end

--logic stuff
function EventConfig:isAcceptedType(type)
    return toboolean(self.eventTypes[type])
end

function EventConfig:isOnlyOnFocus(type)
    return toboolean(self.onlyOnFocus[type])
end

function EventConfig:applies(type, isFocused)
    if self.eventTypes[type] and not isFocused then
        return true
    end
    return toboolean(self.eventTypes[type] and (self.onlyOnFocus[type] and isFocused))
end