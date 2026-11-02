_G.RootPath = fs.getDir(shell.getRunningProgram())

local speaker = peripheral.find("speaker")

local function generateTone(frequency, duration, volume)
    if not speaker then return end
    local samples = {}

    for i = 0, 48000 * duration - 1 do --48000 = sample rate
        local t = i / 48000
        samples[#samples + 1] = math.floor(
            math.sin(2 * math.pi * frequency * t) * volume * 127
        )
    end

    speaker.playAudio(samples, 1)
end

term.clear()
term.setCursorPos(1,1)
generateTone(880, 0.08, 1)

local function filterEnv(env)
    local output = {}
    for k,v in pairs(env) do
        if v ~= _G[k] then
            output[k] = v
        end
    end
    return output
end


local function import(fileName)
    local env = setmetatable({},{__index = _G})
    local func = loadfile(fileName,"t",env)
    if type(func) ~= "function" then
        error("could not find "..fileName)
    end
    func()
    return filterEnv(env)
end

xpcall(
    function()
        local graphicsEnv = import(fs.combine(RootPath,"system/libs/rendering/VerGL2D.lua"))
        graphicsEnv.VerGL = graphicsEnv.VerGL2D
        graphicsEnv.VerGL2D = nil
        _G.Graphics = graphicsEnv

        require("system/libs/event_system/EventManager")

        _G.EventSystem = {}
        _G.EventSystem.Manager = EventManager:init()
        _G.EventSystem.Event = import(fs.combine(RootPath,"system/libs/event_system/Event.lua")).Event
        _G.EventSystem.EventConfig = import(fs.combine(RootPath,"system/libs/event_system/EventConfig.lua")).EventConfig

        local width, height = term.getSize();

        local startupFrame = Graphics.VerGL:new1(1,1,width,height)

        local startupImg = Graphics.ColorMatrix:loadImg(fs.combine(RootPath,"system/imgs/redux.nfp"))
        startupFrame:addRenderableObject0(Graphics.Sprite:new(
            Graphics.Vector2:new(
                math.floor((width-startupImg:getWidth())/2),
                math.floor((height-startupImg:getHeight())/2)
            ),
            startupImg
        ))
        startupFrame:blitToBuffer()
        startupFrame:flipBuffer()
    end,
    function(msg)
        sleep(0.1)
        generateTone(1760, 0.16, 1)
        sleep(0.1)
        term.setTextColor(colors.red)
        print("error during startup phase:\n"..msg)
        term.setTextColor(colors.white)
    end
)

--[[
local function setupFolder(folderPath)
    if not fs.isDir(folderPath) then
        fs.delete(folderPath)
        fs.makeDir(folderPath)
    end
end
local function recursiveCopy(originFolder)
end
setupFolder("users")
]]