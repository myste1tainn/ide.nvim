---@class Task
---@field name string
---@field execute function
Task = {}

function Task:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

function Task:run()
  return self:execute()
end
