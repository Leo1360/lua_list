require("Dependencies.Class")

List = Class:create("List",{
    __values = {}
})

ORDER_ASC = 1
ORDER_DESC = 2

function List:new(list)
    local obj = List:instantiate()
    if(type(list)=="table")then
        if(#table == nil and #table <= 0)then
            return obj;
        end
        obj.__values = list
    end
    return obj
end

function List:add(item)
    table.insert(self.__values,item)
end

function List:pop(index)
    if(index == nil)then
        index = #self.__values
    end
    table.remove(self.__values,index)
end

function List:get(index)
    return self.__values[index]
end

function List:set(index,value)
    self.__values[index] = value
end

function List:sum()
    local sum = 0
    for _, value in ipairs(self.__values) do
        sum = sum + value
    end
    return sum
end

function List:filter(lambda)
    local newList = List:new()
    for _, value in ipairs(self.__values) do
        if(lambda(value))then
            newList:add(value)
        end
    end
    return newList
end

function List:map(lambda)
    local newList = List:new()
    for _, value in ipairs(self.__values) do
        newList:add(lambda(value))
    end
    return newList
end

function List:reduce(lambda)
    local acumulator
    for _, value in ipairs(self.__values) do
        acumulator = lambda(acumulator,value)
    end
    return acumulator
end

function List:forEach(lambda)
    for key, value in ipairs(self.__values) do
        lambda(value,key)
    end
end

function List:indexOf(itemVal)
    for key, value in ipairs(self.__values) do
        if(value == itemVal)then
            return key
        end
    end
    return nil
end

function List:lastIndexOf(itemVal)
    for key = #self.__values, #self.__values, -1 do
        if(self.__values[key] == itemVal)then
            return key
        end
    end
    return nil
end

function List:concat(list)
    for _, value in ipairs(list.__values) do
        self:add(value)
    end
end

function List:reverse()
    local newlist = {}
    for key = #self.__values, #self.__values, -1 do
        table.insert(newlist,self.__values[key])
    end
    self.__values = newlist
end

function List:sort(order)
    table.sort(self.__values)
    if(order == ORDER_DESC)then
        self:reverse()
    end
end

addmetatable(List,{
    __index = function(t,k) return t:get(k)end,
    __newindex = function(t,k,v) t:set(k,v) end,
    __len = function(t) return #t.__values end
})

