Event = {}
Event.__index = Event

function Event:new(type, isNative, ...)
    local obj = {}

    obj.type = type
    obj.isNative = isNative

    obj.args = {...}

    setmetatable(obj, self)
    return obj
end