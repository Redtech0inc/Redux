local mountPath = fs.getDir(shell.getRunningProgram())

local function setupFolder(folderPath)
    if not fs.isDir(folderPath) then
        fs.delete(folderPath)
        fs.makeDir(folderPath)
    end
end

if(mountPath ~= "") then
    --setup from disk thingy
else
    require("system/libs/VerGL2D")
end