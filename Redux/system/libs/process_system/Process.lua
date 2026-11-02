Process = {}
Process.__index = Process

Process.Status = {}
Process.Status.RUNNING = "running"
Process.Status.READY = "ready"
Process.Status.WAITING = "waiting"
Process.Status.DEAD = "dead"

function Process:init(fn)
    local obj = {}

    obj.status = Process.Status.READY
    obj.pid = ProcessSystem.ProcessManager:getNextPID()
    obj.coroutine = coroutine.create(fn)
    obj.timeout = 0

    setmetatable(obj, self)
    return obj
end

function Process:setStatus(status)
    self.status = tostring(status)
end

function Process:getStatus()
    if coroutine.status(self.coroutine) == "dead" then return Process.Status.DEAD end
    return self.status
end

function Process:run(args)
    if type(args) ~= "table" then args = {} end
    coroutine.resume(self.coroutine, table.unpack(args))
end

function Process:setTimeout(timeout)
    self.timeout = timeout
end

function Process:getTimeout()
    return self.timeout
end

function Process.yield(sleepEpoch ,...)
    if type(sleepEpoch) ~= "number" then sleepEpoch = 0
    else sleepEpoch = math.abs(math.floor(sleepEpoch))
    end

    local args = {...}
    coroutine.yield({waiting = sleepEpoch},table.unpack(args))
end