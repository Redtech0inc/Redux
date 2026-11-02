EventManager = {}
EventManager.__index = EventManager

require("system/libs/helpers/Helpers")
require("system/libs/helpers/Queue")
require("system/libs/event_system/Event")
require("system/libs/event_system/EventConfig")
require("system/libs/process_system/ProcessManager")

function EventManager:init()
    local obj = {}

    obj.configs = {}
    obj.queues = {}

    setmetatable(obj, self)
    return obj
end

function EventManager:registerProcess(pid, config)
    if self.configs[pid] then error("process #"..pid.." is still active")
    elseif not Helpers.validateObj(config, EventConfig) then error("config is not a config object")
    end
    self.configs[pid] = config
    self.queues[pid] = Queue:new(16)
end

function EventManager:unregisterProcess(pid)
    self.configs[pid] = nil
    self.queues[pid] = nil
end

function EventManager:dispatchEvent(event)
    for k, v in pairs(self.configs) do
        --TODO: make work
    end
end