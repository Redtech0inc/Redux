ProcessManager = {}
ProcessManager.__index = ProcessManager

local pid = -1

function ProcessManager:init()
    local obj = {}

    obj.processes = {}
    obj.minProcessId = 0
    obj.maxProcessId = 0

    setmetatable(obj, self)
    return obj
end

function ProcessManager:getNextPID()
    pid = pid + 1
    return pid
end

function ProcessManager:run()
    parallel.waitForAll(function ()
        while true do
            local event = {os.pullEventRaw()}
            EventSystem.Manager:dispatchEvent(Event.new(event[1], table.unpack(event, 2)))
        end
    end,function ()
        while true do
            for pid, process in pairs(self.processes) do
                if process:getStatus() == ProcessSystem.Process.Status.WAITING then
                    if os.epoch("utc") >= process:getTimeout() then
                        process:setStatus(ProcessSystem.Process.Status.READY)
                    end
                end

                if process:getStatus() ~= ProcessSystem.Process.Status.WAITING and co:getStatus() ~= ProcessSystem.Process.Status.DEAD then
                    process:setStatus(ProcessSystem.Process.Status.RUNNING)

                    local result = {process:run(process)}
                    local hasTimeout = false

                    if type(result[1]) == "table" then
                        if type(result[1].waiting) == "number" then
                            if result[1].waiting > 0 then
                                process:setTimeout(os.epoch("utc")+result[1].waiting)
                                hasTimeout = true
                            end
                        end
                    end

                    if hasTimeout then process:setStatus(ProcessSystem.Process.Status.WAITING)
                    else process:setStatus(ProcessSystem.Process.Status.READY)
                    end

                    EventSystem.Manager.dispatchEvent(Event.new("process_yielded", pid, process))
                end
                if process:getStatus() == ProcessSystem.Process.Status.DEAD then
                    self.processes[pid] = nil
                end
                sleep(0.1)
            end
        end
    end)
end