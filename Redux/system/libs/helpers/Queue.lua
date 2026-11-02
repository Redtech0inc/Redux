Queue = {}
Queue.__index = Queue

function Queue:new(intialCap)
    if type(intialCap) ~= "number" then intialCap = 8
    elseif intialCap < 1 then intialCap = 8
    else intialCap = math.ceil(intialCap)
    end

    local obj = {}
    obj.ringQueue = {}
    obj.frontPtr = 0 --queueing place
    obj.backPtr = 1 --de-queueing place
    obj.length = intialCap
    obj.items = 0
    obj.reset = false

    setmetatable(obj, self)
    self.__index = self
    return obj
end

function Queue:queue(item)
    if item == nil then return end

    self.frontPtr = self.frontPtr + 1
    self.items = self.items + 1

    if self.frontPtr > self.length and not self.ringQueue[1] then
        self.frontPtr = 1
    end

    if self.frontPtr == self.backPtr and self.length >= self.frontPtr then
        table.insert(self.ringQueue, self.frontPtr, item)
        self.backPtr = self.backPtr + 1
        self.length = self.length + 1
    elseif self.frontPtr == self.backPtr then
        table.insert(self.ringQueue, self.frontPtr, item)
        self.length = self.length + 1
    else self.ringQueue[self.frontPtr] = item
    end

    if self.length < self.frontPtr then
        self.length = self.length + 1
    end
end

function Queue:deQueue()
    if self.items == 0 or self.length == 0 then return end

    if self.reset then
        self.backPtr = self.backPtr + 1
        self.reset = false

        if self.backPtr > self.length or self.backPtr == 0 then
            self.backPtr = 1
        end
    end

    local item = self.ringQueue[self.backPtr]
    self.ringQueue[self.backPtr] = nil

    self.backPtr = self.backPtr + 1
    self.items = self.items - 1

    if self.items == 0 then
        self.backPtr = self.frontPtr

        if self.backPtr == 0 then
            self.backPtr = self.length
        end

        self.reset = true
    elseif self.backPtr > self.length then
        self.backPtr = 1
    end

    return item
end