--[[
    说明: 工具表
]]

local Utils = class("Utils")

-- 将一个一维数组合并为二维数组
function Utils.oneToTwo(tables, num1, num2)
    local array = {}
    local tempTable = {}
    local tidx = 0
    for k, v in pairs(tables) do
        tidx = tidx + 1
        table.insert(tempTable, tidx, v)
    end

    local idx = 1
    for i = 1, num1 do
        array[i] = {}
        for j = 1, num2 do
            array[i][j] = tempTable[idx]
            idx = idx + 1
        end
    end

    return array
end


function Utils.slice(list, start, total)

    local _end = math.min(start + total - 1, #list)

    local array = {}

    for i = start, _end do
        table.insert(array, list[i])
    end

    return array
end



return Utils
