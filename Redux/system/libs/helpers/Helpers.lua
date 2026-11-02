Helpers = {}
function Helpers.validateObj(obj,metatable)
    if type(obj)~="table" then return false
    elseif getmetatable(obj)~=metatable then return false
    end
    return true
end