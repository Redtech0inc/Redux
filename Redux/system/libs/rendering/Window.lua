Window = {}
Window.__index = Window

local function toboolean(value)
    if value then return true end
    return false
end

local outWidth, outHeight = outputPeripheral.getSize()

function Window:open(pid,x,y,width,height,isFullScreen,backgroundColor,textColor,barColor)
    local obj = {}

    if type(width) ~= "number" then width = 5
    elseif width < 5 then width = 5
    elseif width > outWidth then width = outWidth
    else width = math.floor(width) end

    if type(height) ~= "number" then height = 5
    elseif height < 5 then height = 5
    elseif height > outHeight then height = outHeight-1 --make sure the bar at the top is visible in non full screen mode
    else height = math.floor(height) end

    if type(x) ~= "number" then x = 1
    elseif x < 1 or x > outWidth then x = 1
    else x = math.floor(x) end

    if type(y) ~= "number" then y = 1
    elseif y < 1 or y > outHeight then y = 1
    else y = math.floor(y) end

    obj.pid = pid

    obj.gfx = Graphics.VerGL:new1(x,y,width,height,outputPeripheral,backgroundColor,textColor)

    obj.size = {
        width = width,
        height = height,
        orgWidth = width,
        orgHeight = height
    }

    obj.pos = {
        x = x,
        y = y
    }

    obj.colors = {
        bgCol = backgroundColor,
        fgCol = textColor,
        brCol = barColor
    }

    obj.isFullScreen = toboolean(isFullScreen)

    obj.windowCollider = Graphics.Collider:new2D(Vector2:new(obj.pos.x,obj.pos.y),Vector2:new(0,0),Vector2:new(obj.size.width, obj.size.height))

    setmetatable(obj, self)
    return obj
end

function Window:close()
    ProcessSystem.Manager.terminateProcess(self.pid)
    self = nil
end

function Window:setSize(width,height)
    if type(width) ~= "number" then return
    elseif width > outWidth then width = outWidth
    elseif width < 5 then width = 5
    end

    if type(height) ~= "number" then return
    elseif height > outHeight then height = outHeight
    elseif height < 5 then height = 5
    end

    if height < outHeight and self.isFullScreen then self.isFullScreen = false end
    if width < outWidth and self.isFullScreen then self.isFullScreen = false end

    self.size.width = width
    self.size.height = height

    if height < outHeight then --is enough to see the action bar again
        self.size.orgWidth = width
        self.size.orgHeight = height
    end

    local VerGLWin = self.gfx:getWindow()
    VerGLWin:setBuffer(Graphics.VerGLBuffer:new(width,height,self.colors.bgCol,self.colors.fgCol))
end

function Window:setFullScreen(fullScreen)
    if self.isFullScreen and not fullScreen then
        self:setSize(self.size.orgWidth, self.size.orgHeight) --reset to init size
    elseif fullScreen and not self.isFullScreen then
        self:setSize(outWidth, outHeight) --set to full size
    end
end

function Window:getGfx()
    return self.gfx
end

function Window:applyEvents(events)
    for i=1,#events do
        local event = events[i]
        if event.type == "mouse_click" then
            local x,y = event.args[2], event.args[3]

            if self.windowCollider:isCollidingWithPoint({x=x,y=y}) then
                ProcessSystem.Manager.setFocused(self.pid)
            end

            if y == self.pos.y then --is in top bar
                if x == self.size.width then
                    ProcessSystem.Manager.terminateProcess(self.pid)
                end
                --TODO: make work
            end
        end
    end
end

function Window:getProcess() --utility method for using this handle to get the process
    return ProcessSystem.Manager.getProcess(self.pid)
end

function Window:getEvents() --another utility method for using this handle to get all events
    local events = EventSystem.Manager.getEvents(self.pid)
    self:applyEvents(events)
    return events
end

function Window:stop()
    ProcessSystem.Manager.terminateProcess(self.pid)
end

function Window:render()
    self.gfx:blitToBuffer()
    local buffer = self.gfx:getWindow():getBuffer()

    if not self.isFullScreen then
        for i=1,self.size.width do
            if i == self.size.width then
                buffer:blit(1,1,colors.red,colors.white,"x")
            else
                buffer:blit(i,1,self.colors.brCol)
            end
        end
    end

    self.gfx:flipBuffer()
end