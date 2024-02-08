local exec = require('flutter-tools.executable')
local Job = require('plenary.job')
local sign = require('significant')
vim.fn.sign_define('DONE', { text = '✅' })
vim.fn.sign_define('FAIL', { text = '❌' })

local TaskManager = {}

-- Setup the TaskManager with a Window
function TaskManager:setup(window)
  self.window = window
  self.tasks = {}
end

function TaskManager:run(opts)
  if opts == nil then
    error("1st argument is required")
  end

  if opts.name == nil then
    error("Parameter 'name' is required")
  end

  table.insert(self.tasks, opts.name)
  local lineCount = self.window:log({ ' ' .. opts.name })
  print('lineCount =', lineCount)
  self:showSign(nil, lineCount)
  local job = Job:new({ command = opts.cmd, args = opts.args })
  job:after_success(vim.schedule_wrap(function(j)
    self:showSign('DONE', lineCount)
    opts.onSuccess(j:result())
  end))
  job:after_failure(vim.schedule_wrap(function(j)
    self:showSign('FAIL', lineCount)
    opts.onFailure(j:result())
  end))
  job:start()
end

function TaskManager:showSign(signName, line)
  local currentWin = vim.api.nvim_get_current_win()
  vim.api.nvim_set_current_win(self.window.handle)
  if signName == 'DONE' or signName == 'FAIL' then
    sign.stop_animated_sign(line, { unplace_sign = false, sign_name = signName })
  else
    sign.start_animated_sign(line, 'dots4', 100)
  end
  vim.api.nvim_set_current_win(currentWin)
end

return TaskManager
