EventManager = {}
EventManager.__index = EventManager

require("system/libs/helpers/Helpers")
require("system/libs/helpers/Queue")

local configs = {}
local queues = {}

function EventManager.registerProcess(pid, config)
    if configs[pid] then error("process #"..pid.." is still active")
    elseif not Helpers.validateObj(config, EventSystem.EventConfig) then error("config is not an EventConfig object")
    end
    configs[pid] = config
    queues[pid] = Queue:new()
end

function EventManager.unregisterProcess(pid)
    configs[pid] = nil
    queues[pid] = nil
end

function EventManager.receivesEvent(pid,eventType,isFocused)
    if not configs[pid] then error("process #"..pid.." doesn't exist") end

    return configs[pid]:applies(eventType, isFocused)
end

function EventManager.getEvents(pid)
    if not queues[pid] then error("process #"..pid.." doesn't exist") end

    local events = queues[pid]:totable()
    queues[pid]:clear() --resets for next go

    return events
end

function EventManager.popEvent(pid)
    if not queues[pid] then error("process #"..pid.." doesn't exist") end

    return queues[pid]:deQueue()
end

function EventManager.dispatchEvent(event)
    for pid, config in pairs(configs) do
        if config:applies(event.type, ProcessSystem.Manager.isFocused(pid)) then
            queues[pid]:queue(event)
        end
    end
end

function EventManager.convertNativeToReduxEvent(eventData)
    return EventSystem.Event.new(eventData[1], table.unpack(eventData,2))
end