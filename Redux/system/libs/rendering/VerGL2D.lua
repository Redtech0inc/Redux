--== Vector3.lh-begin ==--
local metatable0
Vector3={
add=function (self, vec)
if getmetatable(self)~=metatable0 then error("self is not a Vector3") end
if getmetatable(vec)==metatable0 then
return Vector3:new(self.x+vec.x,self.y+vec.y,self.z+vec.z)
elseif type(vec)=="number" then
return Vector3:new(self.x+vec,self.y+vec,self.z+vec)
else error("other argument is not a Vector3 or number") end
end,
sub=function (self, vec)
if getmetatable(self)~=metatable0 then error("self is not a Vector3") end
if getmetatable(vec)==metatable0 then
return Vector3:new(self.x-vec.x,self.y-vec.y,self.z-vec.z)
elseif type(vec)=="number" then
return Vector3:new(self.x-vec,self.y-vec,self.z-vec)
else error("other argument is not a Vector3 or number") end
end,
mul=function (self, vec)
if getmetatable(self)~=metatable0 then error("self is not a Vector3") end
if getmetatable(vec)==metatable0 then
return Vector3:new(self.x*vec.x,self.y*vec.y,self.z*vec.z)
elseif type(vec)=="number" then
return Vector3:new(self.x*vec,self.y*vec,self.z*vec)
else error("other argument is not a Vector3 or number") end
end,
div=function (self, vec)
if getmetatable(self)~=metatable0 then error("self is not a Vector3") end
if getmetatable(vec)==metatable0 then
return Vector3:new(self.x/vec.x,self.y/vec.y,self.z/vec.z)
elseif type(vec)=="number" then
return Vector3:new(self.x/vec,self.y/vec,self.z/vec)
else
error("other argument is not a Vector3 or number")
end
end,
unm=function (self)
if getmetatable(self)~=metatable0 then error("self is not a Vector3") end
return Vector3:new(-self.x,-self.y,-self.z)
end,
tostring=function (self)
if getmetatable(self)~=metatable0 then error("self is not a Vector3") end
return "{"..self.x..","..self.y..","..self.z.."}"
end,
equals=function (self, vec)
if getmetatable(self)~=metatable0 then error("self is not a Vector3") end
if getmetatable(vec)~=metatable0 then error("other argument is not a Vector3") end
if self.x~=vec.x then return false
elseif self.y~=vec.y then return false
elseif self.z~=vec.z then return false
else return true end
end,
lengthSqr=function (self)
if getmetatable(self)~=metatable0 then error("self is not a Vector3") end
return self.x*self.x+self.y*self.y+self.z*self.z
end,
length=function (self)
if getmetatable(self)~=metatable0 then error("self is not a Vector3") end
return math.sqrt(self:lengthSqr())
end,
normalize=function(self)
if getmetatable(self)~=metatable0 then error("self is not a Vector3") end
local len=self:length()
if len==0 then
return Vector3:new(0,0,0)
end
return self:mul(1/len)
end,
dot=function (self, vec)
if getmetatable(self)~=metatable0 then error("self is not a Vector3") end
if getmetatable(vec)~=metatable0 then error("other argument is not a Vector3") end
return self.x*vec.x+self.y*vec.y+self.z*vec.z
end,
cross=function (self, vec)
if getmetatable(self)~=metatable0 then error("self is not a Vector3") end
if getmetatable(vec)~=metatable0 then error("other argument is not a Vector3") end
return Vector3:new(
self.y*vec.z-self.z*vec.y,
self.z*vec.x-self.x*vec.z,
self.x*vec.y-self.y*vec.x
)
end,
distanceSqr=function (self, vec)
if getmetatable(self)~=metatable0 then error("self is not a Vector3") end
if getmetatable(vec)~=metatable0 then error("other argument is not a Vector3") end
local difX, difY, difZ=self.x-vec.x, self.y-vec.y, self.z-vec.z
return difX*difX+difY*difY+difZ*difZ
end,
distance=function (self, vec)
if getmetatable(self)~=metatable0 then error("self is not a Vector3") end
if getmetatable(vec)~=metatable0 then error("other argument is not a Vector3") end
return math.sqrt(self:distanceSqr(vec))
end,
floor=function (self)
if getmetatable(self)~=metatable0 then error("self is not a Vector3") end
return Vector3:new(math.floor(self.x),math.floor(self.y),math.floor(self.z))
end,
ceil=function (self)
if getmetatable(self)~=metatable0 then error("self is not a Vector3") end
return Vector3:new(math.ceil(self.x),math.ceil(self.y),math.ceil(self.z))
end,
copy=function (self)
if getmetatable(self)~=metatable0 then error("self is not a Vector3") end
return Vector3:new(self.x,self.y,self.z)
end,
totable=function(self)
return {self.x,self.y,self.z}
end,
getMetatable=function ()
return metatable0
end
}
metatable0={
__name="Vector3",
__index=Vector3,
__add=Vector3.add,
__sub=Vector3.sub,
__mul=Vector3.mul,
__div=Vector3.div,
__unm=Vector3.unm,
__tostring=Vector3.tostring,
__eq=Vector3.equals,
}
function Vector3:new(x,y,z)
local obj={}
obj.x=x
obj.y=y
obj.z=z
if type(obj.x)~="number" then obj.x=0 end
if type(obj.y)~="number" then obj.y=0 end
if type(obj.z)~="number" then obj.z=0 end
return setmetatable(obj, metatable0)
end
--== Vector3.lh-end ==--
--== Helpers.lh-begin ==--
local colorTable={}
colorTable["0"]=colors.white
colorTable["1"]=colors.orange
colorTable["2"]=colors.magenta
colorTable["3"]=colors.lightBlue
colorTable["4"]=colors.yellow
colorTable["5"]=colors.lime
colorTable["6"]=colors.pink
colorTable["7"]=colors.gray
colorTable["8"]=colors.lightGray
colorTable["9"]=colors.cyan
colorTable["a"]=colors.purple
colorTable["b"]=colors.blue
colorTable["c"]=colors.brown
colorTable["d"]=colors.green
colorTable["e"]=colors.red
colorTable["f"]=colors.black
colorTable["r"]=true
local reverseColorTable={}
reverseColorTable[colors.white]="0"
reverseColorTable[colors.orange]="1"
reverseColorTable[colors.magenta]="2"
reverseColorTable[colors.lightBlue]="3"
reverseColorTable[colors.yellow]="4"
reverseColorTable[colors.lime]="5"
reverseColorTable[colors.pink]="6"
reverseColorTable[colors.gray]="7"
reverseColorTable[colors.lightGray]="8"
reverseColorTable[colors.cyan]="9"
reverseColorTable[colors.purple]="a"
reverseColorTable[colors.blue]="b"
reverseColorTable[colors.brown]="c"
reverseColorTable[colors.green]="d"
reverseColorTable[colors.red]="e"
reverseColorTable[colors.black]="f"
local function getColor(letter)
local colorOut=colorTable[letter]
if colorOut then return colorOut end
return nil
end
local function toJsonStyleString(value)
if type(value)=="nil" then return "null"
elseif type(value)=="string" or type(value)=="thread" or type(value)=="userdata" then return "\""..tostring(value).."\"" end
return tostring(value)
end
local function isColor(value)
return type(reverseColorTable[value])=="string"
end
local function validateObj(obj,metatable)
if type(obj)~="table" then return false
elseif getmetatable(obj)~=metatable then return false
end
return true
end
local function toboolean(value)
if value then return true end
return false
end
--== Helpers.lh-end ==--
--== Vector2.lh-begin ==--
local metatable1
Vector2={
add=function (self, vec)
if getmetatable(self)~=metatable1 then error("self is not a Vector2") end
if getmetatable(vec)==metatable1 then
return Vector2:new(self.x+vec.x,self.y+vec.y)
elseif type(vec)=="number" then
return Vector2:new(self.x+vec,self.y+vec)
else error("other argument is not a Vector2 or number") end
end,
sub=function (self, vec)
if getmetatable(self)~=metatable1 then error("self is not a Vector2") end
if getmetatable(vec)==metatable1 then
return Vector2:new(self.x-vec.x,self.y-vec.y)
elseif type(vec)=="number" then
return Vector2:new(self.x-vec,self.y-vec)
else error("other argument is not a Vector2 or number") end
end,
mul=function (self, vec)
if getmetatable(self)~=metatable1 then error("self is not a Vector2") end
if getmetatable(vec)==metatable1 then
return Vector2:new(self.x*vec.x,self.y*vec.y)
elseif type(vec)=="number" then
return Vector2:new(self.x*vec,self.y*vec)
else error("other argument is not a Vector2 or number") end
end,
div=function (self, vec)
if getmetatable(self)~=metatable1 then error("self is not a Vector2") end
if getmetatable(vec)==metatable1 then
return Vector2:new(self.x/vec.x,self.y/vec.y)
elseif type(vec)=="number" then
return Vector2:new(self.x/vec,self.y/vec)
else
error("other argument is not a Vector2 or number")
end
end,
unm=function (self)
if getmetatable(self)~=metatable1 then error("self is not a Vector2") end
return Vector2:new(-self.x,-self.y)
end,
tostring=function (self)
if getmetatable(self)~=metatable1 then error("self is not a Vector2") end
return "{"..self.x..","..self.y.."}"
end,
equals=function (self, vec)
if getmetatable(self)~=metatable1 then error("self is not a Vector2") end
if getmetatable(vec)~=metatable1 then error("other argument is not a Vector2") end
if self.x~=vec.x then return false
elseif self.y~=vec.y then return false
else return true end
end,
lengthSqr=function (self)
if getmetatable(self)~=metatable1 then error("self is not a Vector2") end
return self.x*self.x+self.y*self.y
end,
length=function (self)
if getmetatable(self)~=metatable1 then error("self is not a Vector2") end
return math.sqrt(self:lengthSqr())
end,
normalize=function(self)
if getmetatable(self)~=metatable1 then error("self is not a Vector2") end
local len=self:length()
if len==0 then
return Vector2:new(0,0)
end
return self:mul(1/len)
end,
dot=function (self, vec)
if getmetatable(self)~=metatable1 then error("self is not a Vector2") end
if getmetatable(vec)~=metatable1 then error("other argument is not a Vector2") end
return self.x*vec.x+self.y*vec.y
end,
cross=function (self, vec)
if getmetatable(self)~=metatable1 then error("self is not a Vector2") end
if getmetatable(vec)~=metatable1 then error("other argument is not a Vector2") end
return self.x*vec.y-self.y*vec.x
end,
distanceSqr=function (self, vec)
if getmetatable(self)~=metatable1 then error("self is not a Vector2") end
if getmetatable(vec)~=metatable1 then error("other argument is not a Vector2") end
local difX, difY=self.x-vec.x, self.y-vec.y
return difX*difX+difY*difY
end,
distance=function (self, vec)
if getmetatable(self)~=metatable1 then error("self is not a Vector2") end
if getmetatable(vec)~=metatable1 then error("other argument is not a Vector2") end
return math.sqrt(self:distanceSqr(vec))
end,
floor=function (self)
if getmetatable(self)~=metatable1 then error("self is not a Vector2") end
return Vector2:new(math.floor(self.x),math.floor(self.y))
end,
ceil=function (self)
if getmetatable(self)~=metatable1 then error("self is not a Vector2") end
return Vector2:new(math.ceil(self.x),math.ceil(self.y))
end,
copy=function (self)
if getmetatable(self)~=metatable1 then error("self is not a Vector2") end
return Vector2:new(self.x,self.y)
end,
totable=function(self)
return {self.x,self.y}
end,
getMetatable=function ()
return metatable1
end
}
metatable1={
__name="Vector2",
__index=Vector2,
__add=Vector2.add,
__sub=Vector2.sub,
__mul=Vector2.mul,
__div=Vector2.div,
__unm=Vector2.unm,
__tostring=Vector2.tostring,
__eq=Vector2.equals,
}
function Vector2:new(x,y)
local obj={}
obj.x=x
obj.y=y
if type(obj.x)~="number" then obj.x=0 end
if type(obj.y)~="number" then obj.y=0 end
return setmetatable(obj, metatable1)
end
--== Vector2.lh-end ==--
--== Collider.lh-begin ==--
Collider={}
Collider.__index=Collider
local function isValidCollider(col)
if type(col)~="table" then return false
elseif type(col.top)~="table" then return false
elseif type(col.top.x)~="number" or type(col.top.y)~="number" or type(col.top.z)~="number" then return false
elseif type(col.bottom)~="table" then return false
elseif type(col.bottom.x)~="number" or type(col.bottom.y)~="number" or type(col.bottom.z)~="number" then return false
elseif col.top.x>col.bottom.x then return false
elseif col.top.y>col.bottom.y then return false
elseif col.top.z>col.bottom.z then return false
end
return true
end
function Collider:new3D(refPos,top,bottom)
if not validateObj(refPos,Vector3.getMetatable()) then error("refPos is not a Vector3 object")
elseif not validateObj(top,Vector3.getMetatable()) then error("top is not a Vector3 object")
elseif not validateObj(bottom,Vector3.getMetatable()) then error("bottom is not a Vector3 object")
end
if top.x>bottom.x then error("top x is bigger than bottom x")
elseif top.y>bottom.y then error("top y is bigger than bottom y")
elseif top.z>bottom.z then error("top z is bigger than bottom z")
end
local obj={}
obj.refPos=refPos:copy()
obj.top=top:copy()
obj.bottom=bottom:copy()
obj.refTop=obj.refPos+obj.top
obj.refBottom=obj.refPos+obj.bottom
setmetatable(obj, self)
return obj
end
function Collider:new2D(refPos,top,bottom)
if not validateObj(refPos,Vector2.getMetatable()) then error("refPos is not a Vector2 object")
elseif not validateObj(top,Vector2.getMetatable()) then error("top is not a Vector2 object")
elseif not validateObj(bottom,Vector2.getMetatable()) then error("bottom is not a Vector2 object")
end
if top.x>bottom.x then error("top x is bigger than bottom x")
elseif top.y>bottom.y then error("top y is bigger than bottom y")
end
local obj={}
obj.refPos=Vector3:new(refPos.x,refPos.y,0)
obj.top=Vector3:new(top.x,top.y,0)
obj.bottom=Vector3:new(bottom.x,bottom.y,0)
obj.refTop=obj.refPos+obj.top
obj.refBottom=obj.refPos+obj.bottom
setmetatable(obj, self)
return obj
end
function Collider:setRefPos(pos)
if type(pos)~="table" then error("vector is not an object")
elseif type(pos.x)~="number" or type(pos.y)~="number" then error("vector.x and/or vector.y are not numbers")
end
if type(pos.z)=="number" then
self.refPos=pos:copy()
else
self.refPos=Vector3:new(pos.x,pos.y,0)
end
self.refTop=self.refPos+self.top
self.refBottom=self.refPos+self.bottom
end
function Collider:getRefPos()
return self.refPos:copy()
end
function Collider:getRelativeTop()
return self.top:copy()
end
function Collider:getRelativeBottom()
return self.bottom:copy()
end
function Collider:getTop()
return self.refTop:copy()
end
function Collider:getBottom()
return self.refBottom:copy()
end
function Collider:isCollidingWithPoint(vector)
if type(vector)~="table" then error("vector is not an object")
elseif type(vector.x)~="number" or type(vector.y)~="number" then error("vector.x and/or vector.y is not a number")
end
if
self.refTop.x>vector.x or
self.refTop.y>vector.y or
self.refBottom.x<vector.x or
self.refBottom.y<vector.y
then
return false
end
if type(vector.z)=="number" then
if
self.refTop.z>vector.z or
self.refBottom.z<vector.z
then
return false
end
end
return true
end
function Collider:computeOverlap(collider)
if not validateObj(collider,Collider) then error("provided collider cannot collide") end
local colliderTop=collider:getTop()
local colliderBottom=collider:getBottom()
local overlapX=math.min(self.refBottom.x, colliderBottom.x)-math.max(self.refTop.x, colliderTop.x)
local overlapY=math.min(self.refBottom.y, colliderBottom.y)-math.max(self.refTop.y, colliderTop.y)
local overlapZ=math.min(self.refBottom.z, colliderBottom.z)-math.max(self.refTop.z, colliderTop.z)
return Vector3:new(overlapX, overlapY, overlapZ)
end
function Collider:isCollidingWithCollider(collider)
if not validateObj(collider,Collider) then error("given collider cannot collide") end
local colliderTop=collider:getTop()
local colliderBottom=collider:getBottom()
if
self.refBottom.x<colliderTop.x or
self.refBottom.y<colliderTop.y or
self.refBottom.z<colliderTop.z or
self.refTop.x>colliderBottom.x or
self.refTop.y>colliderBottom.y or
self.refTop.z>colliderBottom.z
then
return false
end
return true
end
function Collider:renderBox(buffer, color)
if type(buffer)~="table" then error("buffer is not an object")
elseif type(buffer.blit)~="function" then error("buffer does not have a blit method")
elseif type(buffer.getSize)~="function" then error("buffer does not have a getSize method")
elseif type(color)~="number" then error("color is not a number")
end
local bufferWidth, bufferHeight=buffer:getSize()
local width=self.bottom.x-self.top.x+1
local height=self.bottom.y-self.top.y+1
local realX, realY
for i=1,width do
realX=self.refTop.x+i
if realX>=1 and realX<=bufferWidth then
for j=1,height do
realY=self.refTop.y+j
if realY>=1 and realY<=bufferHeight then
buffer:blit(realX,realY,color,nil,nil)
end
end
end
end
end
function Collider:renderOutline(buffer,color)
if type(buffer)~="table" then error("buffer is not an object")
elseif type(buffer.blit)~="function" then error("buffer does not have a 'blit' method")
elseif type(buffer.getHeight)~="function" then error("buffer does not have a 'getHeight' method")
elseif type(color)~="number" then error("color is not a number")
end
local bufferHeight=buffer:getHeight()
local width=self.bottom.x-self.top.x+1
local height=self.bottom.y-self.top.y+1
local realY
for i=1,height do
realY=self.refTop.y+i
if realY>=1 and realY<=bufferHeight then
if i==1 or i==height then
for j=1,width do
buffer:blit(self.refTop.x+j, realY, color)
end
else
buffer:blit(self.refTop.x+1, realY, color)
buffer:blit(self.refTop.x+width, realY, color)
end
end
end
end
function Collider:toJson(isCompact,indents)
local parser=JsonParser:new()
parser:putValue("refPos",self.refPos:totable())
parser:putValue("top",self.top:totable())
parser:putValue("bottom",self.bottom:totable())
return parser:toJson(isCompact,indents)
end
function Collider:fromJson(jsonTbl)
if type(jsonTbl)~="table" then error("jsonTbl is not a table") end
if type(jsonTbl.refPos)~="table" then jsonTbl.refPos={0,0,0} end
if type(jsonTbl.top)~="table" then jsonTbl.top={0,0,0} end
if type(jsonTbl.bottom)~="table" then jsonTbl.bottom={0,0,0} end
local refPos=Vector3:new(jsonTbl.refPos[1],jsonTbl.refPos[2],jsonTbl.refPos[3])
local top=Vector3:new(jsonTbl.top[1],jsonTbl.top[2],jsonTbl.top[3])
local bottom=Vector3:new(jsonTbl.bottom[1],jsonTbl.bottom[2],jsonTbl.bottom[3])
return Collider:new3D(refPos,top,bottom)
end
function Collider:__eq(other)
if not validateObj(other,Collider) then return false end
if self.top==other.top and self.bottom==other.bottom then
return true
end
return false
end
--== Collider.lh-end ==--
--== JsonArray.lh-begin ==--
JsonArray={}
JsonArray.__index=JsonArray
local function parseTableJA(table,len,isCompact,indents)
local output="["
local indentationStr=("    "):rep(indents)
for i=1,len do
if not isCompact then output=output.."\n"..indentationStr end
local value=table[i]
if type(value)=="function" then
local result=value(isCompact,indents+1)
if validateObj(result,JsonParser) then output=output..result:toJson(isCompact,indents+1)
elseif validateObj(result,JsonArray) then output=output..result:toJson(isCompact,indents+1)
else output=output..tostring(result)
end
elseif type(value)=="table" then
if type(value.toJson)=="function" then
local result=value:toJson(isCompact,indents+1)
if validateObj(result,JsonParser) then output=output..result:toJson(isCompact,indents+1)
elseif validateObj(result,JsonArray) then output=output..result:toJson(isCompact,indents+1)
else output=output..tostring(result)
end
else output=output..parseTableJA(value, #value, isCompact, indents+1)
end
else output=output..toJsonStyleString(value)
end
if i<len then output=output.."," end
end
if not isCompact then
output=output.."\n"
if indents>1 then
output=output..("    "):rep(indents-1)
end
end
return output.."]"
end
function JsonArray:new(table,len)
local obj={}
if type(table)~="table" then table={} end
if type(len)~="number" then len=#table
elseif len<0 then len=#table
end
obj.table=table
obj.len=len
setmetatable(obj, self)
return obj
end
function JsonArray:push(value)
self.len=self.len+1
self.table[self.len]=value
end
function JsonArray:pop()
self.table[self.len]=nil
self.len=self.len-1
end
function JsonArray:clear()
self.table={}
self.len=0
end
function JsonArray:toJson(isCompact,indents)
if type(indents)~="number" then indents=1
elseif indents<1 then indents=1
end
return parseTableJA(self.table,self.len,isCompact,indents)
end
--== JsonArray.lh-end ==--
--== ColorMatrix.lh-begin ==--
ColorMatrix={}
ColorMatrix.__index=ColorMatrix
local function copyMatrix(input,width,height)
local output={}
local subTable
for i=1,width do
subTable=input[i]
if type(subTable)=="table" then
output[i]={}
for j=1,height do
output[i][j]=subTable[j]
end
end
end
return output
end
function ColorMatrix:new0()
return ColorMatrix:new1({{}},0,0)
end
function ColorMatrix:new1(matrix,width,height)
local obj={}
matrix=matrix or {{}}
if type(width)~="number" then width=0
elseif width<0 then width=0
else width=math.floor(width) end
if type(height)~="number" then height=0
elseif height<0 then height=0
else height=math.floor(height) end
obj.width=width
obj.height=height
obj.mtx=copyMatrix(matrix,obj.width,obj.height)
setmetatable(obj, self)
return obj
end
function ColorMatrix:new2(color,width,height)
local obj={}
obj.mtx={}
if type(width)~="number" then width=0
elseif width<0 then width=0
else width=math.floor(width) end
if type(height)~="number" then height=0
elseif height<0 then height=0
else height=math.floor(height) end
if not isColor(color) then color=colors.white end
obj.width=width
obj.height=height
for i=1,width do
obj.mtx[i]={}
for j=1,height do
obj.mtx[i][j]=color
end
end
setmetatable(obj, self)
return obj
end
function ColorMatrix:loadImg(src, matrixWidth, matrixHeight)
if not fs.exists(src) then error(src.." is not an existing nfp file") end
if type(matrixWidth)~="number" then matrixWidth=1
else matrixWidth=math.floor(matrixWidth) end
if type(matrixHeight)~="number" then matrixHeight=1
else matrixHeight=math.floor(matrixHeight) end
local reqWidth, reqHeight=0, 0
local fileMtx={}
for line in io.lines(src) do
if #line>reqWidth then reqWidth=#line end
reqHeight=reqHeight+1
fileMtx[reqHeight]={}
for i=1,#line do
local color=getColor(line:sub(i,i))
if color then
fileMtx[reqHeight][i]=color
end
end
end
if #fileMtx==0 then error("file '"..src.."' is empty") end
local imgMtx={}
for i=1,reqWidth do
imgMtx[i]={}
for j=1,reqHeight do
imgMtx[i][j]=fileMtx[j][i]
end
end
if matrixWidth<reqWidth then matrixWidth=reqWidth end
if matrixHeight<reqHeight then matrixHeight=reqHeight end
return ColorMatrix:new1(imgMtx,matrixWidth,matrixHeight)
end
function ColorMatrix:setMatrix0(mtx)
if self.width==0 or self.height==0 then return end
if type(mtx)~="table" then error("parsed argument is not a table") end
self.mtx=copyMatrix(mtx,self.width,self.height)
end
function ColorMatrix:setMatrix1(mtx,width,height)
if type(width)~="number" then width=0
elseif width<0 then width=0 end
if type(height)~="number" then height=0
elseif height<0 then height=0 end
self.width=width
self.height=height
self:setMatrix0(mtx)
end
function ColorMatrix:setWidth(width)
if type(width)~="number" then width=0
elseif width<0 then width=0 end
self.width=width
end
function ColorMatrix:getWidth()
return self.width
end
function ColorMatrix:setHeight(height)
if type(height)~="number" then height=0
elseif height<0 then height=0 end
self.height=height
end
function ColorMatrix:getHeight()
return self.height
end
function ColorMatrix:setSize(width,height)
if type(width)~="number" then width=0
elseif width<0 then width=0 end
if type(height)~="number" then height=0
elseif height<0 then height=0 end
self.width=width
self.height=height
end
function ColorMatrix:getSize()
return self.width, self.height
end
function ColorMatrix:slice(x,y,width,height)
if type(x)~="number" then error("x is not a number")
elseif type(y)~="number" then error("y is not a number")
elseif type(width)~="number" then error("width is not a number")
elseif  type(height)~="number" then error("height is not a number")
elseif width<1 or height<1 then error("width and hight must be at least 1")
end
local matrix={}
for i=1,width do
matrix[i]={}
for j=1,height do
local subTable=self.mtx[x+(i-1)]
if type(subTable)=="table" then matrix[i][j]=subTable[y+(j-1)]
else matrix[i][j]=nil end
end
end
return ColorMatrix:new1(matrix,width,height)
end
function ColorMatrix:merge(colMtx,x,y)
if not validateObj(colMtx,ColorMatrix) then error("colMtx is not a ColoMatrix object")
elseif type(x)~="number" then error("x is not a number")
elseif type(y)~="number" then error("y is not a number")
end
local matrix={}
local relX, relY=x+colMtx.width-1, y+colMtx.height-1
for i=1,self.width do
matrix[i]={}
for j=1,self.height do
if (i>=x and i<=relX) and (j>=y and j<=relY) then
matrix[i][j]=colMtx.mtx[(i-x)+1][(j-y)+1]
else
matrix[i][j]=self.mtx[i][j]
end
end
end
return ColorMatrix:new1(matrix,self.width,self.height)
end
function ColorMatrix:getMatrix()
return copyMatrix(self.mtx,self.width,self.height)
end
function ColorMatrix:toJson(isCompact,indents)
local parser=JsonParser:new()
parser:putValue("width",self.width)
parser:putValue("height",self.height)
local mtx=JsonArray:new()
local subMtx
for i=1,self.width do
subMtx=JsonArray:new()
for j=1,self.height do
if type(self.mtx[i])=="table" then subMtx:push(self.mtx[i][j]) end
end
mtx:push(subMtx)
end
parser:putValue("mtx",mtx)
return parser:toJson(isCompact,indents)
end
function ColorMatrix:fromJson(jsonTbl)
if type(jsonTbl)~="table" then error("jsonTbl is not a table") end
if type(jsonTbl.width)~="number" then jsonTbl.width=0 end
if type(jsonTbl.height)~="number" then jsonTbl.height=0 end
if type(jsonTbl.mtx)~="table" then jsonTbl.mtx={} end
local width=math.max(math.floor(jsonTbl.width), 0)
local height=math.max(math.floor(jsonTbl.height), 0)
local output={}
local subTable
for i=1,width do
subTable=jsonTbl.mtx[i]
if type(subTable)=="table" then
output[i]={}
for j=1,height do
if isColor(subTable[j]) then output[i][j]=subTable[j] end
end
end
end
return ColorMatrix:new1(output,width,height)
end
--== ColorMatrix.lh-end ==--
--== VerGLDepthBuffer.lh-begin ==--
VerGLDepthBuffer={}
VerGLDepthBuffer.__index=VerGLDepthBuffer
function VerGLDepthBuffer:new(width,height,zNear,defaultZ,color,textColor)
local obj={}
if type(width)~="number" then obj.width=5
elseif width<5 then obj.width=5
else obj.width=math.floor(width)
end
if type(height)~="number" then obj.height=5
elseif height<5 then obj.height=5
else obj.height=math.floor(height)
end
if type(zNear)~="number" then obj.zNear=100
elseif zNear<0 then obj.zNear=100
else obj.zNear=zNear
end
if type(defaultZ)~="number" then obj.defaultZ=0
elseif defaultZ<0 or defaultZ>obj.zNear then obj.defaultZ=0
else obj.defaultZ=defaultZ
end
obj.color=color or colors.black
obj.textColor=textColor or colors.white
obj.colBuffer={}
obj.txtColBuffer={}
obj.txtBuffer={}
obj.depthBuffer={}
for i=1, width do
table.insert(obj.colBuffer,{})
table.insert(obj.txtColBuffer,{})
table.insert(obj.txtBuffer,{})
table.insert(obj.depthBuffer,{})
for j=1, height do
table.insert(obj.colBuffer[i],obj.color)
table.insert(obj.txtColBuffer[i],obj.textColor)
table.insert(obj.txtBuffer[i]," ")
table.insert(obj.depthBuffer[i],obj.zNear)
end
end
setmetatable(obj, self)
return obj
end
function VerGLDepthBuffer:getWidth()
return self.width
end
function VerGLDepthBuffer:getHeight()
return self.height
end
function VerGLDepthBuffer:getSize()
return self.width, self.height
end
function VerGLDepthBuffer:getColor()
return self.color
end
function VerGLDepthBuffer:getTextColor()
return self.textColor
end
function VerGLDepthBuffer:setBackgroundColor(color)
for x=1,self.width do
for y=1,self.height do
self.colBuffer[x][y]=color
self.depthBuffer[x][y]=self.zNear
end
end
end
function VerGLDepthBuffer:setTextColor(color)
for x=1,self.width do
for y=1,self.height do
self.txtColBuffer[x][y]=color
self.depthBuffer[x][y]=self.zNear
end
end
end
function VerGLDepthBuffer:setChar0(char)
char=string.sub(tostring(char),1,1)
for x=1,self.width do
for y=1,self.height do
self.txtBuffer[x][y]=char
self.depthBuffer[x][y]=self.zNear
end
end
end
function VerGLDepthBuffer:setChar1(x,y,char,pointZ)
char=string.sub(tostring(char),1,1)
if x<1 or x>self.width then return end
if y<1 or y>self.height then return end
x=math.floor(x)
y=math.floor(y)
if type(pointZ)~="number" then pointZ=self.defaultZ
elseif pointZ<0 then pointZ=self.defaultZ
end
if self.depthBuffer[x][y]>=pointZ then return end
self.depthBuffer[x][y]=pointZ
self.txtBuffer[x][y]=char
end
function VerGLDepthBuffer:supportsDepth()
return true
end
function VerGLDepthBuffer:refreshColor()
self:setBackgroundColor(self.color)
end
function VerGLDepthBuffer:refreshTextColor()
self:setTextColor(self.textColor)
end
function VerGLDepthBuffer:refreshText()
self:setChar0(" ")
end
function VerGLDepthBuffer:refresh()
self:refreshColor()
self:refreshTextColor()
self:refreshText()
end
function VerGLDepthBuffer:blit(x,y,color,textCol,text,pointZ)
if x<1 or x>self.width then return end
if y<1 or y>self.height then return end
x=math.floor(x)
y=math.floor(y)
if type(pointZ)~="number" then pointZ=self.defaultZ
elseif pointZ<0 then pointZ=self.defaultZ
end
if self.depthBuffer[x][y]>=pointZ then return end
self.depthBuffer[x][y]=pointZ
if color and not text then self.colBuffer[x][y]=color end
if textCol and not text then self.txtColBuffer[x][y]=textCol end
if text then
text=tostring(text)
if #text==1 then
self.txtBuffer[x][y]=text
if color then self.colBuffer[x][y]=color end
if textCol then self.txtColBuffer[x][y]=textCol end
return
end
local writingX, writingY=x, y
for i=1,#text do
if writingX>self.width then
writingX=1
writingY=writingY+1
if writingY>self.height then return end
end
self.txtBuffer[writingX][writingY]=string.sub(text,i,i)
if color then self.colBuffer[writingX][writingY]=color end
if textCol then self.txtColBuffer[writingX][writingY]=textCol end
writingX=writingX+1
end
end
end
function VerGLDepthBuffer:flip(output, x, y)
local initialX, initialY=output.getCursorPos()
local initialCol, initialTxtCol=output.getBackgroundColor(), output.getTextColor()
local initialCursorBlink=output.getCursorBlink()
output.setCursorBlink(false)
for w=1, self.width do
for h=1, self.height do
output.setCursorPos(x+w-1,y+h-1)
output.setBackgroundColor(self.colBuffer[w][h])
output.setTextColor(self.txtColBuffer[w][h])
output.write(self.txtBuffer[w][h])
end
end
output.setCursorPos(initialX,initialY)
output.setBackgroundColor(initialCol)
output.setTextColor(initialTxtCol)
output.setCursorBlink(initialCursorBlink)
end
--== VerGLDepthBuffer.lh-end ==--
--== CollisionShape.lh-begin ==--
CollisionShape={}
CollisionShape.__index=CollisionShape
local function validateCollider(col)
if not col then return false
elseif type(col)~="table" then return false
elseif type(col.isCollidingWithPoint)~="function" then return false
elseif type(col.isCollidingWithCollider)~="function" then return false
end
return true
end
function CollisionShape:new()
local obj={}
obj.colliders={}
setmetatable(obj, self)
return obj
end
function CollisionShape:addCollider(collider)
if not validateObj(collider,Collider) then error("parsed object is not a valid collider") end
table.insert(self.colliders,collider)
return #self.colliders
end
function CollisionShape:removeCollider(index)
if index>#self.colliders then return false
elseif table.remove(self.colliders,index) then return true
end
return false
end
function CollisionShape:clear()
self.colliders={}
end
function CollisionShape:setPos(pos)
for i=1,#self.colliders do
self.colliders[i]:setRefPos(pos)
end
end
function CollisionShape:isCollidingWithPoint(vector)
local output
for i=1,#self.colliders do
output=self.colliders[i]:isCollidingWithPoint(vector)
if output then return true end
end
return false
end
function CollisionShape:isCollidingWithCollider(collider)
local output
for i=1,#self.colliders do
output=self.colliders[i]:isCollidingWithCollider(collider)
if output then return true end
end
return false
end
function CollisionShape:isCollidingWithCollisionShape(shape)
if not validateObj(shape,CollisionShape) then error("shape is not a CollisionShape object") end
local output
for i=1,#self.colliders do
output=shape:isCollidingWithCollider(self.colliders[i])
if output then return true end
end
return false
end
function CollisionShape:renderBoxes(buffer,color)
if type(color)=="number" then color={color}
elseif type(color)~="table" then error("argument 'color' must be a color value or table of color values")
elseif #color==0 then error("color value table must have at least one element")
end
local currentColorIndex=1
local currentColor
for i=1,#self.colliders do
currentColor=color[currentColorIndex]
if type(currentColor)~="number" then error("currentColor is not a number") end
self.colliders[i]:renderBox(buffer,currentColor)
if currentColorIndex==#color then currentColorIndex=1
else currentColorIndex=currentColorIndex+1 end
end
end
function CollisionShape:renderOutlines(buffer,color)
if type(color)=="number" then color={color}
elseif type(color)~="table" then error("argument 'color' must be a color value or table of color values")
elseif #color==0 then error("color value table must have at least one element")
end
local currentColorIndex=1
local currentColor
for i=1,#self.colliders do
currentColor=color[currentColorIndex]
if type(currentColor)~="number" then error("element "..currentColorIndex.." of color table is not a number") end
self.colliders[i]:renderOutline(buffer,currentColor)
if currentColorIndex==#color then currentColorIndex=1
else currentColorIndex=currentColorIndex+1 end
end
end
function CollisionShape:toJson(isCompact,indents)
return JsonArray:new(self.colliders):toJson(isCompact,indents)
end
function CollisionShape:fromJson(jsonTbl)
if type(jsonTbl)~="table" then error("jsonTbl is not a table") end
local shape=CollisionShape:new()
local collider
for i=1,#jsonTbl do
collider=jsonTbl[i]
shape:addCollider(Collider:fromJson(collider))
end
return shape
end
--== CollisionShape.lh-end ==--
--== JsonParser.lh-begin ==--
JsonParser={}
JsonParser.__index=JsonParser
local function parseTable(table,isCompact,indents)
local output="["
local indentationStr=("    "):rep(indents)
for i=1,#table do
if not isCompact then output=output.."\n"..indentationStr end
local value=table[i]
if type(value)=="function" then
local result=value(isCompact,indents+1)
if validateObj(result,JsonParser) then output=output..result:toJson(isCompact,indents+1)
elseif validateObj(result,JsonArray) then output=output..result:toJson(isCompact,indents+1)
else output=output..tostring(result)
end
elseif type(value)=="table" then
if type(value.toJson)=="function" then
local result=value:toJson(isCompact,indents+1)
if validateObj(result,JsonParser) then output=output..result:toJson(isCompact,indents+1)
elseif validateObj(result,JsonArray) then output=output..result:toJson(isCompact,indents+1)
else output=output..tostring(result)
end
else output=output..parseTable(value,isCompact,indents+1)
end
else output=output..toJsonStyleString(value)
end
if i<#table then output=output.."," end
end
if not isCompact then
output=output.."\n"
if indents>1 then
output=output..("    "):rep(indents-1)
end
end
return output.."]"
end
local function tableContains(table,value)
for i=1,#table do
if table[i]==value then return true end
end
return false
end
function JsonParser:new()
local obj={}
obj.values={}
obj.valuesLen=0
obj.valueNames={}
setmetatable(obj, self)
return obj
end
function JsonParser:putValue(key,value)
if not tableContains(self.valueNames,key) then
self.valuesLen=self.valuesLen+1
table.insert(self.valueNames,key)
end
self.values[key]=value
end
function JsonParser:getValue(key)
return self.values[key]
end
function JsonParser:toJson(isCompact,indents)
if type(indents)~="number" then indents=1
elseif indents<1 then indents=1
end
local indentationStr=("    "):rep(indents)
local output="{"
local itr=0
for kIndex=1,#self.valueNames do
itr=itr+1
local k=self.valueNames[kIndex]
local v=self.values[k]
if not isCompact then output=output.."\n"..indentationStr end
output=output.."\""..tostring(k).."\": "
if type(v)=="function" then
local result=v(isCompact,indents+1)
if validateObj(result,JsonParser) then output=output..result:toJson(isCompact,indents+1)
elseif validateObj(result,JsonArray) then output=output..result:toJson(isCompact,indents+1)
else output=output..tostring(result)
end
elseif type(v)=="table" then
if type(v.toJson)=="function" then
local result=v:toJson(isCompact,indents+1)
if validateObj(result,JsonParser) then output=output..result:toJson(isCompact,indents+1)
elseif validateObj(result,JsonArray) then output=output..result:toJson(isCompact,indents+1)
else output=output..tostring(result)
end
else output=output..parseTable(v,isCompact,indents+1)
end
else output=output..toJsonStyleString(v)
end
if itr<self.valuesLen then output=output.."," end
end
if not isCompact then
output=output.."\n"
if indents>1 then
output=output..("    "):rep(indents-1)
end
end
return output.."}"
end
--== JsonParser.lh-end ==--
--== VerGLBuffer.lh-begin ==--
VerGLBuffer={}
VerGLBuffer.__index=VerGLBuffer
function VerGLBuffer:new(width,height,color,textColor)
local obj={}
if type(width)~="number" then obj.width=5
elseif width<5 then obj.width=5
else obj.width=math.floor(width) end
if type(height)~="number" then obj.height=5
elseif height<5 then obj.height=5
else obj.height=math.floor(height) end
obj.color=color or colors.black
obj.textColor=textColor or colors.white
obj.colBuffer={}
obj.txtColBuffer={}
obj.txtBuffer={}
for i=1, width do
table.insert(obj.colBuffer,{})
table.insert(obj.txtColBuffer,{})
table.insert(obj.txtBuffer,{})
for j=1, height do
table.insert(obj.colBuffer[i],obj.color)
table.insert(obj.txtColBuffer[i],obj.textColor)
table.insert(obj.txtBuffer[i]," ")
end
end
setmetatable(obj, self)
return obj
end
function VerGLBuffer:getWidth()
return self.width
end
function VerGLBuffer:getHeight()
return self.height
end
function VerGLBuffer:getSize()
return self.width, self.height
end
function VerGLBuffer:getColor()
return self.color
end
function VerGLBuffer:getTextColor()
return self.textColor
end
function VerGLBuffer:setBackgroundColor(color)
for x=1,self.width do
for y=1,self.height do
self.colBuffer[x][y]=color
end
end
end
function VerGLBuffer:setTextColor(color)
for x=1,self.width do
for y=1,self.height do
self.txtColBuffer[x][y]=color
end
end
end
function VerGLBuffer:setChar0(char)
char=string.sub(tostring(char),1,1)
for x=1,self.width do
for y=1,self.height do
self.txtBuffer[x][y]=char
end
end
end
function VerGLBuffer:setChar1(x,y,char)
char=string.sub(tostring(char),1,1)
if x<1 or x>self.width then return end
if y<1 or y>self.height then return end
x=math.floor(x)
y=math.floor(y)
self.txtBuffer[x][y]=char
end
function VerGLBuffer:supportsDepth()
return false
end
function VerGLBuffer:refreshColor()
self:setBackgroundColor(self.color)
end
function VerGLBuffer:refreshTextColor()
self:setTextColor(self.textColor)
end
function VerGLBuffer:refreshText()
self:setChar0(" ")
end
function VerGLBuffer:refresh()
self:refreshColor()
self:refreshTextColor()
self:refreshText()
end
function VerGLBuffer:blit(x,y,color,textCol,text)
if x<1 or x>self.width then return end
if y<1 or y>self.height then return end
x=math.floor(x)
y=math.floor(y)
if color and not text then self.colBuffer[x][y]=color end
if textCol and not text then self.txtColBuffer[x][y]=textCol end
if text then
text=tostring(text)
if #text==1 then
self.txtBuffer[x][y]=text
if color then self.colBuffer[x][y]=color end
if textCol then self.txtColBuffer[x][y]=textCol end
return
end
local writingX, writingY=x, y
for i=1,#text do
if writingX>self.width then
writingX=1
writingY=writingY+1
if writingY>self.height then return end
end
self.txtBuffer[writingX][writingY]=string.sub(text,i,i)
if color then self.colBuffer[writingX][writingY]=color end
if textCol then self.txtColBuffer[writingX][writingY]=textCol end
writingX=writingX+1
end
end
end
function VerGLBuffer:flip(output, x, y)
local initialX, initialY=output.getCursorPos()
local initialCol, initialTxtCol=output.getBackgroundColor(), output.getTextColor()
local initialCursorBlink=output.getCursorBlink()
output.setCursorBlink(false)
for h=1, self.height do
output.setCursorPos(x, y+h-1)
for w=1, self.width do
output.setBackgroundColor(self.colBuffer[w][h])
output.setTextColor(self.txtColBuffer[w][h])
output.write(self.txtBuffer[w][h])
end
end
output.setCursorPos(initialX,initialY)
output.setBackgroundColor(initialCol)
output.setTextColor(initialTxtCol)
output.setCursorBlink(initialCursorBlink)
end
--== VerGLBuffer.lh-end ==--
--== Sprite.lh-begin ==--
Sprite={}
Sprite.__index=Sprite
local spriteId=0
function Sprite:new(pos, img)
local obj={}
if not pos then
obj.pos=Vector2:new(0,0)
elseif getmetatable(pos)~=Vector2.getMetatable() then
obj.pos=Vector2:new(0,0)
else obj.pos=pos:floor() end
if not img then
obj.img=ColorMatrix:new0()
elseif getmetatable(img)~=ColorMatrix then
obj.img=ColorMatrix:new0()
else obj.img=img end
obj.id=spriteId
obj.type="sprite"
obj.nativeCollision=CollisionShape:new()
obj.renderCollision=false
obj.boxOrOutline=false
obj.collisionColors={colors.red,colors.green,colors.blue}
spriteId=spriteId+1
setmetatable(obj, self)
return obj
end
function Sprite:getPos()
return self.pos:copy()
end
function Sprite:setPos(pos)
if not pos then error("given position is nil")
elseif getmetatable(pos)~=Vector2.getMetatable() then error("given position is not a instance of Vector2")
end
self.pos=pos:floor()
self.nativeCollision:setPos(self.pos)
end
function Sprite:getImg()
return self.img
end
function Sprite:setImg(img)
if not img then error("parsed image is nil")
elseif getmetatable(img)~=ColorMatrix then error("parsed image is not a ColorMatrix") end
self.img=img
end
function Sprite:loadImg(src, matrixWidth, matrixHeight)
self.img=ColorMatrix:loadImg(src, matrixWidth, matrixHeight)
end
function Sprite:toJson(isCompact,indents)
local parser=JsonParser:new()
parser:putValue("pos",self.pos:totable())
parser:putValue("img",self.img)
parser:putValue("collisionShape",self.nativeCollision)
return parser:toJson(isCompact,indents)
end
function Sprite:fromJson(jsonTbl)
if type(jsonTbl)~="table" then error("jsonTbl is not a table") end
if type(jsonTbl.pos)~="table" then jsonTbl.pos={0,0} end
if type(jsonTbl.img)~="table" then
jsonTbl.img={
width=0,
height=0,
mtx={}
}
end
if type(jsonTbl.collisionShape)~="table" then jsonTbl.collisionShape={} end
local pos=Vector2:new(jsonTbl.pos[1],jsonTbl.pos[2])
local img=ColorMatrix:fromJson(jsonTbl.img)
local collisionShape=CollisionShape:fromJson(jsonTbl.collisionShape)
local sprite=Sprite:new(pos,img)
sprite:setNativeCollisionShape(collisionShape)
return sprite
end
function Sprite:getNativeCollisionShape()
return self.nativeCollision
end
function Sprite:setNativeCollisionShape(shape)
if not validateObj(shape,CollisionShape) then error("shape is not a CollisionShape object") end
self.nativeCollision=shape
end
function Sprite:addCollider(top,bottom)
return self.nativeCollision:addCollider(Collider:new2D(self.pos,top,bottom))
end
function Sprite:removeCollider(index)
return self.nativeCollision:removeCollider(index)
end
function Sprite:isCollidingWithPoint(vector)
return self.nativeCollision:isCollidingWithPoint(vector)
end
function Sprite:isCollidingWithCollider(collider)
return self.nativeCollision:isCollidingWithCollider(collider)
end
function Sprite:isCollidingWithCollisionShape(shape)
return self.nativeCollision:isCollidingWithCollisionShape(shape)
end
function Sprite:isCollidingWithObject(collidingObj)
if type(collidingObj)~="table" then error("collidingObj is not a object")
elseif type(collidingObj.getNativeCollisionShape)~="function" then error("collidingObj does not have a native collision shape")
end
local shape=collidingObj:getNativeCollisionShape()
if not validateObj(shape,CollisionShape) then error("collidingObj does not return a CollisionShape from getNativeCollisionShape") end
return self:isCollidingWithCollisionShape(shape)
end
function Sprite:renderNativeCollision(renderCollision,renderOutline,color)
self.renderCollision=renderCollision
self.boxOrOutline=renderOutline
if type(color)=="table" then self.collisionColors=color
elseif type(color)=="number" then self.collisionColors={color}
end
end
function Sprite:blitToBuffer(buffer)
local width, height=buffer:getSize()
local imgWidth, imgHeight=self.img:getSize()
local img=self.img:getMatrix()
local realX, realY, pixel
for i=1,imgWidth do
realX=self.pos.x+i
if realX>width then break
elseif realX>0 and type(img[i])=="table" then
for j=1,imgHeight do
realY=self.pos.y+j
if realY>height then break
elseif realY>0 then
pixel=img[i][j]
if type(pixel)=="number" then
buffer:blit(realX,realY,pixel,nil," ")
end
end
end
end
end
if self.renderCollision then
if self.boxOrOutline then
self.nativeCollision:renderOutlines(buffer,self.collisionColors)
else
self.nativeCollision:renderBoxes(buffer,self.collisionColors)
end
end
end
function Sprite:__eq(other)
if getmetatable(other)~=Sprite then return false end
return (self.id==other.id) and (other.type=="sprite")
end
--== Sprite.lh-end ==--
--== VerGLWindow.lh-begin ==--
VerGLWindow={}
VerGLWindow.__index=VerGLWindow
local function authPeripheral(output)
if output==nil then return nil end
for k, v in pairs(term.native()) do
if type(k)=="string" and type(v)=="function" then
if type(output[k])~="function" then
error("input peripheral is missing method: " .. k,2)
end
end
end
return output
end
local function hasMethods(obj,...)
local names={...}
for i=1,#names do
local name=tostring(names[i])
if type(obj[name])~="function" then return false end
end
return true
end
local function verifyBuffer(buffer)
if type(buffer)~="table" then return false
elseif not hasMethods(buffer,"getWidth","getHeight","getSize","refresh","flip","blit","supportsDepth") then return false
end
return true
end
function VerGLWindow:new(x, y, width, height, output, color, textColor)
local obj={}
if type(x)~="number" then obj.x=1
elseif x<1 then obj.x=1
else obj.x=math.floor(x) end
if type(y)~="number" then obj.y=1
elseif y<1 then obj.y=1
else obj.y=math.floor(y) end
obj.output=authPeripheral(output) or term;
obj.buffer=VerGLBuffer:new(width,height,color,textColor)
setmetatable(obj, self)
return obj
end
function VerGLWindow:new3D(x, y, width, height, zNear, defaultZ, output, color, textColor)
local obj={}
if type(x)~="number" then obj.x=1
elseif x<1 then obj.x=1
else obj.x=math.floor(x) end
if type(y)~="number" then obj.y=1
elseif y<1 then obj.y=1
else obj.y=math.floor(y) end
obj.output=authPeripheral(output) or term;
obj.buffer=VerGLDepthBuffer:new(width,height,zNear,defaultZ,color,textColor)
setmetatable(obj, self)
return obj
end
function VerGLWindow:getWidth()
return self.buffer:getWidth()
end
function VerGLWindow:getHeight()
return self.buffer:getHeight()
end
function VerGLWindow:getSize()
return self.buffer:getSize()
end
function VerGLWindow:getX()
return self.x
end
function VerGLWindow:getY()
return self.y
end
function VerGLWindow:getBuffer()
return self.buffer
end
function VerGLWindow:setBuffer(buffer)
if not verifyBuffer(buffer) then error("input is not a buffer object") end
self.buffer=buffer
end
function VerGLWindow:toVerGLCoords(xIn,yIn)
return xIn-self.x, yIn-self.y
end
function VerGLWindow:supportsDepth()
return self.buffer:supportsDepth()
end
function VerGLWindow:refreshBuffer()
self.buffer:refresh()
end
function VerGLWindow:flipBuffer()
self.buffer:flip(self.output,self.x,self.y)
end
--== VerGLWindow.lh-end ==--
--== Text.lh-begin ==--
Text={}
Text.__index=Text
local textId=0
local TOKEN_TEXT=0
local TOKEN_FG=1
local TOKEN_BG=2
local TOKEN_RESET_FG=3
local TOKEN_RESET_BG=4
local TOKEN_NEWLINE=5
local function parseText(text)
local tokens={}
local buffer=""
local function flushBuffer()
if #buffer>0 then
table.insert(tokens,{TOKEN_TEXT,buffer})
buffer=""
end
end
local i=1
while i<=#text do
local c=text:sub(i,i)
if c=="\n" then
flushBuffer()
table.insert(tokens,{TOKEN_NEWLINE})
elseif c=="$" or c=="&" then
local nextChar=text:sub(i+1,i+1)
local color=getColor(nextChar)
if color then
flushBuffer()
if c=="$" then
if nextChar=="r" then table.insert(tokens,{TOKEN_RESET_FG})
else table.insert(tokens,{TOKEN_FG,color})
end
else
if nextChar=="r" then table.insert(tokens,{TOKEN_RESET_BG})
else table.insert(tokens,{TOKEN_BG,color})
end
end
i=i+1
else
buffer=buffer .. c
end
else
buffer=buffer .. c
end
i=i+1
end
flushBuffer()
return tokens
end
local function wrapTokens(tokens,width)
local lines={}
local line={}
local lineWidth=0
local active={}
local function newLine()
table.insert(lines,line)
line={}
lineWidth=0
for _,token in ipairs(active) do
table.insert(line,token)
end
end
local function addToken(token)
table.insert(line,token)
end
for _,token in ipairs(tokens) do
if token[1]==TOKEN_FG or token[1]==TOKEN_BG then
addToken(token)
table.insert(active,token)
elseif token[1]==TOKEN_RESET_FG then
addToken(token)
for i=#active,1,-1 do
if active[i][1]==TOKEN_FG then
table.remove(active,i)
end
end
elseif token[1]==TOKEN_RESET_BG then
addToken(token)
for i=#active,1,-1 do
if active[i][1]==TOKEN_BG then
table.remove(active,i)
end
end
elseif token[1]==TOKEN_NEWLINE then
newLine()
elseif token[1]==TOKEN_TEXT then
local text=token[2]
for part in text:gmatch("%s*%S+%s*") do
local partLength=#part
while partLength>width do
local chunk=part:sub(1,width-lineWidth)
if #chunk>0 then
addToken({TOKEN_TEXT,chunk})
end
part=part:sub(#chunk+1)
newLine()
partLength=#part
end
if #part>0 then
if lineWidth+partLength>width then
newLine()
end
addToken({TOKEN_TEXT,part})
lineWidth=lineWidth+partLength
end
end
end
end
if #line>0 then
table.insert(lines,line)
end
return lines
end
function Text:new(pos,text,wrapped,maxWidth)
local obj={}
if not pos then
obj.pos=Vector2:new(0,0)
elseif getmetatable(pos)~=Vector2.getMetatable() then
obj.pos=Vector2:new(0,0)
else obj.pos=pos:floor() end
obj.text=tostring(text)
obj.wrapped=wrapped
obj.maxWidth=maxWidth
if type(self.maxWidth)=="number" then
if obj.maxWidth<3 then obj.maxWidth=3 end
end
obj.wrappedText=nil
obj.id=textId
obj.type="text"
obj.nativeCollision=CollisionShape:new()
textId=textId+1
setmetatable(obj, self)
return obj
end
function Text:getPos()
return self.pos:copy()
end
function Text:setPos(pos)
if not pos then error("given position is nil")
elseif getmetatable(pos)~=Vector2.getMetatable() then error("given position is not a instance of Vector2")
end
self.pos=pos:floor()
self.nativeCollision:setPos(self.pos)
self.wrappedText=nil
end
function Text:getText()
return self.text
end
function Text:setText(text)
local text=tostring(text)
if self.text==text then return end
self.text=text
self.wrappedText=nil
end
function Text:isWrapped()
return self.wrapped
end
function Text:setWrapped(wrapped)
self.wrapped=wrapped
end
function Text:toJson(isCompact,indents)
local parser=JsonParser:new()
parser:putValue("pos",self.pos:totable())
parser:putValue("text",self.text)
parser:putValue("wrapped",toboolean(self.wrapped))
parser:putValue("maxWidth",self.maxWidth)
parser:putValue("collisionShape",self.nativeCollision)
return parser:toJson(isCompact,indents)
end
function Text:fromJson(jsonTbl)
if type(jsonTbl)~="table" then error("jsonTbl is not a table") end
if type(jsonTbl.pos)~="table" then jsonTbl.pos={0,0} end
if type(jsonTbl.collisionShape)~="table" then jsonTbl.collisionShape={} end
local pos=Vector2:new(jsonTbl.pos[1],jsonTbl.pos[2])
local shape=CollisionShape:fromJson(jsonTbl.collisionShape)
local text=Text:new(pos,jsonTbl.text,jsonTbl.wrapped,jsonTbl.maxWidth)
text:setNativeCollisionShape(shape)
return text
end
function Text:getNativeCollisionShape()
return self.nativeCollision
end
function Text:setNativeCollisionShape(shape)
if not validateObj(shape,CollisionShape) then error("shape is not a CollisionShape object") end
self.nativeCollision=shape
end
function Text:isCollidingWithPoint(vector)
return self.nativeCollision:isCollidingWithPoint(vector)
end
function Text:isCollidingWithCollider(collider)
return self.nativeCollision:isCollidingWithCollider(collider)
end
function Text:isCollidingWithCollisionShape(shape)
return self.nativeCollision:isCollidingWithCollisionShape(shape)
end
function Text:isCollidingWithObject(collidingObj)
if type(collidingObj)~="table" then error("collidingObj is not a object")
elseif type(collidingObj.getNativeCollisionShape)~="function" then error("collidingObj does not have a native collision shape")
end
local shape=collidingObj:getNativeCollisionShape()
if not validateObj(shape,CollisionShape) then error("collidingObj does not return a CollisionShape from getNativeCollisionShape") end
self:isCollidingWithCollisionShape(shape)
end
function Text:blitToBuffer(buffer)
local width,height=buffer:getSize()
local usedWidth=width-self.pos.x
if type(self.maxWidth)=="number" and self.maxWidth<usedWidth then
usedWidth=self.maxWidth
end
if usedWidth<1 then return end
if not self.wrappedText then
local tokens=parseText(self.text)
if self.wrapped then
self.wrappedText=wrapTokens(tokens, usedWidth)
else
self.wrappedText={tokens}
end
end
local y=self.pos.y+1
for _,line in ipairs(self.wrappedText) do
if y>height then
break
end
local x=self.pos.x+1
local fg=nil
local bg=nil
for _,token in ipairs(line) do
if token[1]==TOKEN_TEXT then
local str=token[2]
for i=1,#str do
if x>width then
break
end
buffer:blit(
x,
y,
bg,
fg,
str:sub(i,i)
)
x=x+1
end
elseif token[1]==TOKEN_FG then
fg=token[2]
elseif token[1]==TOKEN_BG then
bg=token[2]
elseif token[1]==TOKEN_RESET_FG then
fg=nil
elseif token[1]==TOKEN_RESET_BG then
bg=nil
end
end
y=y+1
end
end
function Text:__eq(other)
if getmetatable(other)~=Text then return false end
return (self.id==other.id) and (other.type=="text")
end
--== Text.lh-end ==--
local function validateRenderable(object,logPrefix,log)
if not object then return false
elseif type(object)~="table" then
table.insert(log,logPrefix..": parsed object is not a object")
return false
elseif type(object.blitToBuffer)~="function" then
table.insert(log,logPrefix..": parsed object does not contain a blitToBuffer function")
return false
end
return true
end
VerGL2D={}
VerGL2D.__index=VerGL2D
function VerGL2D:new0(window)
local obj={}
if not window then error("provided window is nil")
elseif getmetatable(window)~=VerGLWindow then error("provided window is not instance of VerGLWindow") end
obj.window=window
obj.objects={}
obj.maxPriority=0
obj.errorLog={}
setmetatable(obj, self)
return obj
end
function VerGL2D:new1(x,y,width,height,peripheral,normColor,normTxtColor)
local obj={}
obj.window=VerGLWindow:new(x,y,width,height,peripheral,normColor,normTxtColor)
obj.objects={}
obj.maxPriority=0
obj.errorLog={}
setmetatable(obj, self)
return obj
end
function VerGL2D:getWindow()
return self.window
end
function VerGL2D:addRenderableObject0(object)
if not validateRenderable(object,"addRenderableObject0",self.errorLog) then return end
table.insert(self.objects,object)
self.maxPriority=self.maxPriority+1
end
function VerGL2D:addRenderableObject1(object,priority)
if type(priority)~="number" then
table.insert(self.errorLog,"addRenderableObject1: parsed in priority must be a number")
return
elseif not validateRenderable(object,"addRenderableObject1",self.errorLog) then return end
priority=math.abs(priority)
table.insert(self.objects,priority,object)
if priority>self.maxPriority then self.maxPriority=priority
else self.maxPriority=self.maxPriority+1 end
end
function VerGL2D:removeRenderableObject0(object)
if not validateRenderable(object,"removeRenderableObject0",self.errorLog) then return end
local lastPriority=0
for i=1,self.maxPriority do
if object==self.objects[i] then
table.remove(self.objects,i)
if i>=self.maxPriority then
self.maxPriority=lastPriority
else
self.maxPriority=self.maxPriority-1
end
return true
end
if object then
lastPriority=i
end
end
return false
end
function VerGL2D:removeRenderableObject1(priority)
if not priority then
table.insert(self.errorLog,"removeRenderableObject1: parsed in priority is nil")
return
elseif self.maxPriority<priority then
table.insert(self.errorLog,"removeRenderableObject1: parsed in priority is not an existing priority")
return
end
self:removeRenderableObject0(self.objects[priority])
end
function VerGL2D:changePriority(object,newPriority)
self:removeRenderableObject0(object)
self:addRenderableObject1(object,newPriority)
end
function VerGL2D:getRenderList()
return self.objects
end
function VerGL2D:toVerGLCoords0(vec)
if not validateObj(vec,Vector2.getMetatable()) then error("given object is not a vector") end
local x,y=self.window:toVerGLCoords(vec.x, vec.y)
return Vector2:new(x,y)
end
function VerGL2D:toVerGLCoords1(xIn,yIn)
if type(xIn)~="number" or type(yIn)~="number" then error("x and y must be numbers") end
local x,y=self.window:toVerGLCoords(xIn, yIn)
return Vector2:new(x,y)
end
function VerGL2D:blitToBuffer()
self.window:getBuffer():refresh()
self:blitToBufferNoRefresh()
end
function VerGL2D:blitToBufferNoRefresh()
local object
local toBeRemoved={}
local buffer=self.window:getBuffer()
local renderIndex=0
local function handleError(msg)
table.insert(toBeRemoved,renderIndex)
table.insert(self.errorLog,"blitToBuffer: removed object from render. object with priority "..renderIndex.." threw an error whilst writing to buffer. message: "..msg)
end
for i=1,self.maxPriority do
object=self.objects[i]
if object then
renderIndex=i
xpcall(
object.blitToBuffer,
handleError,
object,
buffer
)
end
end
for i=#toBeRemoved,1,-1 do
local pos=toBeRemoved[i]
self.objects[pos]=nil
if pos>=self.maxPriority then
local newMaxPriority=0
for j=1,#self.objects do
if object then
newMaxPriority=j
end
end
self.maxPriority=newMaxPriority
end
end
end
function VerGL2D:flipBuffer()
self.window:flipBuffer()
end
function VerGL2D:dumpErrorLog()
local log={}
for i=1,#self.errorLog do
log[i]=self.errorLog[i]
end
self.errorLog={}
return log
end