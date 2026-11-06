Process = {}
Process.__index = Process

Process.Status = {}
Process.Status.RUNNING = "running"
Process.Status.READY = "ready"
Process.Status.WAITING = "waiting"
Process.Status.DEAD = "dead"

local function customSleep(time)
    if type(time)~="number" then error("sleep requires a number")
    elseif time < 0.001 then error("any number smaller than 0.001 won't work")
    end
    time = math.floor(time*1000) --make into milliseconds to work with Redux's system
    return Process.yield(time)
end

local function customQueueEvent(eventName, ...)
    EventSystem.Manager.dispatchEvent(Event.new(eventName, ...))
end

local function addToEnv(envTbl,nativeTbl)
    for k, v in pairs(nativeTbl) do
        envTbl[k] = v
    end
end

local function getFuncEnv()
    local fnEnv = {
        sleep = customSleep
    }
    fnEnv.os = {}
    addToEnv(fnEnv.os,os)
    fnEnv.os.sleep = customSleep
    fnEnv.os.queueEvent = customQueueEvent

    setmetatable(fnEnv,{__index = _G})

    return fnEnv
end

local function filterEnv(env)
    local output = {}
    for k,v in pairs(env) do
        if v ~= _G[k] then
            output[k] = v
        end
    end
    return output
end

function Process:init(fn, terminationCallBack)
    if type(fn) ~= "function" then error("argument 1 has to be a function") end
    local obj = {}

    if type(terminationCallBack) ~= "function" then terminationCallBack = nil end

    obj.pid = ProcessSystem.Manager:getNextPID()

    obj.status = Process.Status.READY

    obj.env = getFuncEnv()

    local eventPuller = function() return EventSystem.Manager.popEvent(obj.pid) end
    obj.env.os.pullEventRaw = eventPuller
    obj.env.os.pullEvent = eventPuller

    local eventsPuller = function() return EventSystem.Manager.getEvents(obj.pid) end
    obj.env.os.pullEvents = eventsPuller
    obj.env.os.pullEventsRaw = eventsPuller

    obj.coroutine = coroutine.create(setfenv(fn,obj.env))
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

function Process:addToLocalScope(key,value)
    self.env[key] = value
    return self
end

function Process:run(...)
    return coroutine.resume(self.coroutine, ...)
end

function Process:terminate(pid)
    if self.killCallback then self.killCallback(pid,filterEnv(self.env)) end
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

function Process.yield(sleepEpoch, ...)
    if type(sleepEpoch) ~= "number" then sleepEpoch = 0
    else sleepEpoch = math.abs(math.floor(sleepEpoch))
    end

    coroutine.yield({waiting = sleepEpoch},...)
end