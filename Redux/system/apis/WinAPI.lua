local function toboolean(value)
    if value then return true end
    return false
end

require("system/libs/rendering/Window")

WinAPI = {}

function WinAPI.builder()
    return WinBuilder:init()
end

function WinAPI.retrieve(x, y, width, height, eventConfig, runnable, killCallback, parentPID, isFullScreen, backgroundCol, textCol, actionBarCol)
    local process = Process:init(runnable, killCallback)

    if ProcessSystem.Manager.getProcess(parentPID) then ProcessSystem.Manager.registerProcess(process,parentPID)
    else ProcessSystem.Manager.registerProcess(process)
    end

    EventSystem.Manager.registerProcess(process:getPID(), eventConfig)

    return Window:open(process:getPID(), x, y, width, height, isFullScreen, backgroundCol, textCol, actionBarCol)
end

function WinAPI.retrieveFromProcess(x, y, width, height, eventConfig, process, isFullScreen, backgroundCol, textCol, actionBarCol)
    EventSystem.Manager.registerProcess(process:getPID(), eventConfig)
    return Window:open(process:getPID(), x, y, width, height, isFullScreen, backgroundCol, textCol, actionBarCol)
end

WinBuilder = {}
WinBuilder.__index = WinBuilder

local outWidth, outHeight = outputPeripheral.getSize()

function WinBuilder:init()
    local obj = {}

    obj.x = 1
    obj.y = 1

    obj.width = 5
    obj.height = 5

    obj.isFullScreen = false
    obj.isFocusedUponOpening = false

    obj.bgColor = colors.black
    obj.fgColor = colors.white
    obj.barColor = colors.gray

    obj.eventConfig = EventSystem.EventConfig:init()
    :addType("mouse_click"):setOnFocused("mouse_click", true)
    :addType("mouse_drag"):setOnFocused("mouse_drag", true)

    obj.killCallback = nil --just here to remind me it's there ;)

    setmetatable(obj, self)
    return obj
end

function WinBuilder:setPos(x,y) --idk checks happen later
    if type(x) ~= "number" or type(y) ~= "number" then return
    elseif x < 1 or x > outWidth or y < 1 or y > outHeight then return
    end

    x = math.floor(x)
    y = math.floor(y)

    self.x = x
    self.y = y
end

function WinBuilder:setSize(width,height)
    if type(width) ~= "number" then width = 5
    elseif width < 5 then width = 5
    elseif width > outWidth then width = outWidth
    else width = math.floor(width) end

    if type(height) ~= "number" then height = 5
    elseif height < 5 then height = 5
    elseif height > outHeight then height = outHeight
    else height = math.floor(height) end

    self.width = width
    self.height = height
end

function WinBuilder:setFullScreen(isFullscreen)
    self.isFullScreen = toboolean(isFullscreen)
end

function WinBuilder:setFocusedUponOpening(focusedUponOpening)
    self.isFocusedUponOpening = toboolean(focusedUponOpening)
end

function WinBuilder:setColors(backgroundColor, textColor, actionBarColor)
    if type(backgroundColor) == "number" then self.bgColor = backgroundColor end
    if type(textColor) == "number" then self.fgColor = textColor end
    if type(actionBarColor) == "number" then self.barColor = actionBarColor end
end

function WinBuilder:addTerminationLambda(func)
    if type(func) ~= "function" then return end
    self.killCallback = func
end

function WinBuilder:listenToEvent(eventType, onlyOnFocus)
    self.eventConfig:addType(eventType):setOnFocused(eventType, onlyOnFocus)
end

function WinBuilder:stopListeningToEvent(eventType)
    self.eventConfig:removeType(eventType)
end

function WinBuilder:build(runnable,parentPID)
    if type(runnable) ~= "function" then error("runnable has to be your window's main code") end

    local process = Process:init(runnable, self.killCallback)

    if ProcessSystem.Manager.getProcess(parentPID) then ProcessSystem.Manager.registerProcess(process,parentPID)
    else ProcessSystem.Manager.registerProcess(process)
    end

    EventSystem.Manager.registerProcess(process:getPID(), self.eventConfig)

    local window = Window:open(process:getPID(), self.x, self.y, self.width, self.height, self.isFullScreen, self.bgColor, self.fgColor, self.barColor)
    process:addToLocalScope("Window",window)

    if self.isFocusedUponOpening then ProcessSystem.Manager.setFocused(process:getPID()) end

    return window
end