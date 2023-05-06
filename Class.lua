---@class Standard class used to create other classes
Class = {}

---Creates a new class
---@return table New Class
function Class:create(name,t)
    if(type(name)~='string')then
        t = name
        name = nil
    end
    local obj = t
    if(type(obj)~="table")then
        obj = {}
    end
    if(name)then
        addmetatable(obj,{__name = name})
    end
    for key, value in pairs(self) do -- copiando ponteiros para a nova instancia 
        --vLog("DEBUG"," Class:create(): add key= ",key,"; value= ",value)
        obj[key] = value
    end
    setmetatable(obj, getmetatable(self)) -- making the metatable inheritance
    return obj
end

---Extends a class
---@return table The mother class redy to be extended
function Class:extends(name,t)
    if(type(name)~='string')then
        t = name
        name = nil
    end
    local obj = t
    if(type(obj)~="table")then
        obj = {}
    end
    local mtSuper = getmetatable(self)
    mtSuper.__super:insert(mtSuper.__name)
    mtSuper.__name = name
    for key, value in pairs(self) do -- copiando ponteiros para a nova instancia 
        --vLog("DEBUG"," Class:create(): add key= ",key,"; value= ",value)
        obj[key] = value
    end
    setmetatable(obj,mtSuper)
    return obj
end

---Instaciate the class
---@return table obj A new instance of the class
function Class:instantiate()
    local obj = self:create()
    removemetatable(obj,"__super")
    obj.create = nil
    obj.instantiate = nil
    obj.extends = nil
    obj.new = nil

    return obj
end

--- Standard constructor: Returns a instance of the class. Can be overwitten
---@return table A new instance of the class
function Class:new() -- Contrutor padrão
    return self:instantiate()
    
end

---Adiciona metatabela a classe
---@param metaTable table
function Class:setMeta(metaTable)
    addmetatable(self,metaTable)
end

function Class:instanceOf(class)
    local mtSelf = getmetatable(self)
    local mtClass = getmetatable(class)
    if(mtClass)then
        return mtClass.__name == mtSelf.__name
    end
    return false
end

-----------Funções auxiliares-------------------
---Merges a metatable to the metatable of a given table/class
---@param class table
---@param newMeta table
function addmetatable(class,newMeta)
    local classMeta = getmetatable(class)
    if(classMeta)then
        for key, value in pairs(newMeta) do
            classMeta[key] = value
        end
    else
        classMeta = newMeta
    end
    setmetatable(class,classMeta)
end

---Removes a methaargument from a class's metatable
---@param class any
---@param meta any
function removemetatable(class,meta)
    local classMeta = getmetatable(class)
    classMeta[meta] = nil
    setmetatable(class,classMeta)
end