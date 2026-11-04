Window = {}
Window.__index = Window

local outWidth, outHeight = outputPeriph.getSize()

function Window:open(pid,x,y,width,height,isFullScreen,backgroundColor,textColor)
    local obj = {}

    if isFullScreen then
        width = outWidth
        height = outHeight
    end

    if type(width) ~= "number" then width = 5
    elseif width < 5 then width = 5
    else width = math.floor(width) end

    if type(height) ~= "number" then height = 5
    elseif height < 5 then height = 5
    elseif height >= outHeight and not isFullScreen then height = outHeight-1 --make sure the bar at the top is visible in non full screen mode
    else height = math.floor(height) end

    if type(x) ~= "number" then x = 1
    elseif x < 1 then x = 1
    elseif x > outWidth then x = 1
    else x = math.floor(x) end

    if type(y) ~= "number" then y = 1
    elseif y < 1 then y = 1
    elseif y > outHeight then y = 1
    else y = math.floor(y) end

    obj.pid = pid

    obj.gfx = Graphics.VerGL:new1(x,y,width,height,outputPeriph,backgroundColor,textColor)

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
        fgCol = textColor
    }

    obj.isFullScreen = isFullScreen and true

    setmetatable(obj, self)
    return obj
end

function Window:setSize(width,height)
    if width > outWidth then width = outWidth
    elseif width < outWidth and self.isFullScreen then self.isFullScreen = false
    end

    if height > outHeight then height = outHeight
    elseif height < outHeight and self.isFullScreen then self.isFullScreen = false
    end

    self.size.width = width
    self.size.height = height

    local VerGLWin = self.gfx:getWindow()
    VerGLWin:setBuffer(Graphics.VerGLBuffer:new(width,height,self.colors.bgCol,self.colors.fgCol))
end

function Window:setFullScreen(fullScreen)
    if self.isFullScreen and not fullScreen then
        self:setSize(self.size.orgWidth, self.size.orgHeight) --reset to init size
    elseif fullScreen and not self.isFullScreen then
        self:setSize(outHeight, outWidth) --set to full size
        self.isFullScreen = true
    end
end

function Window:getGfx()
    return self.gfx
end

function Window:applyEvents(events)
    for i=1,#events do
        local event = events[i]
        if event.type == "mouse_click" then
            if event.args[2] == self.pos.y then --is in top bar
                --TODO: make work
            end
        end
    end
end