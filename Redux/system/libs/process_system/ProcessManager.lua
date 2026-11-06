ProcessManager = {}
ProcessManager.__index = ProcessManager

local pid = -1
local focusedPID = -1
local processes = {}
local minProcessId = 0
local maxProcessId = -1

require("system/libs/helpers/Helpers")

function ProcessManager.registerProcess(process,parentPID)
    if not Helpers.validateObj(process, ProcessSystem.Process) then return end

    local pid = process:getPID()
    processes[pid] = process

    if pid > maxProcessId then maxProcessId = pid
    elseif pid < minProcessId then minProcessId = pid
    end

    if type(parentPID) == "number" then
        if type(processes[parentPID]) == "table" then
            processes[parentPID]:addChildRoutine(pid)
        end
    end
end

function ProcessManager.getProcess(pid)
    if type(pid) ~= "number" then error(pid.." has to be a number") end

    return processes[pid]
end

function ProcessManager.terminateProcess(pid)
    if pid == 0 then error("cannot kill process #0, since that is Redux's main process")
    elseif not processes[pid] then error("process #"..pid.." doesn't exist")
    end

    local process = processes[pid]

    local childRoutines = process.childRoutines
    for i=1,#childRoutines do
        if processes[childRoutines[i]] then ProcessManager.terminateProcess(childRoutines[i]) end
    end

    process:terminate(process)
    EventSystem.Manager.unregisterProcess(pid) --this makes sure that any events received are gone
    processes[pid] = nil --terminated
end

function ProcessManager.getNextPID()
    pid = pid + 1
    return pid
end

function ProcessManager.setFocused(pid)
    if not processes[pid] then error("process #"..pid.." doesn't exist") end

    focusedPID = pid
end

--[[function ProcessManager:getFocusedPID()
    return focusedPID
end]]

function ProcessManager.isFocused(pid)
    return pid == focusedPID
end

function ProcessManager.run()
    parallel.waitForAll(function()
        while true do
            local event = {os.pullEventRaw()}
            EventSystem.Manager.dispatchEvent(EventSystem.Manager.convertNativeToReduxEvent(event))
        end
    end,function()
        while true do
            for pid, process in pairs(processes) do
                if process:getStatus() == ProcessSystem.Process.Status.WAITING then
                    if os.epoch("utc") >= process:getTimeout() then
                        process:setStatus(ProcessSystem.Process.Status.READY)
                    end
                end

                if process:getStatus() ~= ProcessSystem.Process.Status.WAITING and process:getStatus() ~= ProcessSystem.Process.Status.DEAD then
                    process:setStatus(ProcessSystem.Process.Status.RUNNING)

                    local result = {process:run(process)}
                    local hasTimeout = false

                    if type(result[2]) == "table" then
                        if type(result[2].waiting) == "number" then
                            if result[2].waiting > 0 then
                                process:setTimeout(os.epoch("utc")+result[2].waiting)
                                hasTimeout = true
                            end
                        end
                    end

                    if hasTimeout then process:setStatus(ProcessSystem.Process.Status.WAITING)
                    else process:setStatus(ProcessSystem.Process.Status.READY)
                    end

                    if pid ~= 0 then EventSystem.Manager.dispatchEvent(Event.new("process_yielded", pid, process)) end
                end
                if process:getStatus() == ProcessSystem.Process.Status.DEAD then
                    EventSystem.Manager.dispatchEvent(Event.new("process_dead", pid, process)) --0 doesn't matter here cause if that stops your pc shuts down
                    processes[pid] = nil
                end
            end
            sleep(0.001)
        end
    end)
end