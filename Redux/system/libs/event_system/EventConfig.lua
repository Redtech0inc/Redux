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
    obj.final = false

    setmetatable(obj, self)
    return obj
end

--builder.like functions
function EventConfig:addType(typeName)
    if type(typeName) ~= "string" or self.final then return self end
    self.eventTypes[typeName] = true
    return self
end

function EventConfig:setOnFocused(typeName, onFocused)
    if type(typeName) ~= "string" or self.final or not self.eventTypes[typeName] then return self end
    if onFocused then self.onlyOnFocus[typeName] = true
    else self.onlyOnFocus[typeName] = nil
    end
    return self
end

function EventConfig:removeType(typeName)
    if self.final then return self end
    self.eventTypes[typeName] = nil
    self.onlyOnFocus[typeName] = nil
end

function EventConfig:finish()
    self.final = true
end

function EventConfig:isFinished()
    return self.final
end

--logic stuff
function EventConfig:isAcceptedType(typeName)
    return toboolean(self.eventTypes[typeName])
end

function EventConfig:isOnlyOnFocus(typeName)
    return toboolean(self.onlyOnFocus[typeName])
end

function EventConfig:applies(typeName, isFocused)
    if self.eventTypes[typeName] and not isFocused then
        return true
    end
    return toboolean(self.eventTypes[typeName] and (self.onlyOnFocus[typeName] and isFocused))
end