local Rx = require("rx")
local Job = require("plenary.job")

---@class RxJob
---@field name string
---@field cmd string
---@field args table?
RxJob = {}

function RxJob:new(o)
  o = o or {}
  if o.cmd == nil then
    error("Job need to have defined 'cmd'")
  end

  setmetatable(o, self)
  self.__index = self
  return o
end

-- Run the defined task
---@return Rx.Observable
function RxJob:run()
  return Rx.Observable.create(function(observer)
    local job = Job:new({ command = self.cmd, args = self.args })
    job:after_success(vim.schedule_wrap(function()
      observer:onNext(job:result())
    end))
    job:after_failure(vim.schedule_wrap(function()
      observer:onError(job:result())
    end))
    job:start()
  end)
end
