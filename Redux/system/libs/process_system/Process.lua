Process = {}
Process.__index = Process

Process.Status = {}
Process.Status.RUNNING = "running"
Process.Status.READY = "ready"
Process.Status.WAITING = "waiting"
Process.Status.DEAD = "dead"

function Process:init(fn, terminationCallBack)
    local obj = {}

    if type(terminationCallBack) ~= "function" then terminationCallBack = nil end

    obj.pid = ProcessSystem.Manager:getNextPID()

    obj.status = Process.Status.READY
    obj.coroutine = coroutine.create(fn)
    obj.timeout = 0

    obj.childRoutines = {}

    obj.killCallback = terminationCallBack

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

function Process:getPID()
    return self.pid
end

function Process:addChildRoutine(pid)
    self.childRoutines[#self.childRoutines+1] = pid
end

function Process:terminate(pid)
    if self.killCallback then self.killCallback(pid) end
end

function Process.yield(sleepEpoch ,...)
    if type(sleepEpoch) ~= "number" then sleepEpoch = 0
    else sleepEpoch = math.abs(math.floor(sleepEpoch))
    end

    local args = {...}
    coroutine.yield({waiting = sleepEpoch},table.unpack(args))
end