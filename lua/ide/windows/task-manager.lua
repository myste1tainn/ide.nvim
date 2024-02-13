local sign = require("significant")
vim.fn.sign_define("DONE", { text = "✅" })
vim.fn.sign_define("FAIL", { text = "❌" })

---@class TaskManager
TaskManager = {}

-- Setup the TaskManager with a Window
function TaskManager:setup(window)
  self.window = window
  self.tasks = {}
end

---@param task Task
function TaskManager:run(task)
  table.insert(self.tasks, task.name)
  local lineCount = self.window:log({ " " .. task.name })
  self:showSign(nil, lineCount - 1)
  return task.execute():tap(function()
    self:showSign("DONE", lineCount - 1)
  end, function()
    self:showSign("FAIL", lineCount - 1)
  end)
end

function TaskManager:showSign(signName, line)
  local currentWin = vim.api.nvim_get_current_win()
  vim.api.nvim_set_current_win(self.window.handle)
  if signName == "DONE" or signName == "FAIL" then
    sign.stop_animated_sign(line, { unplace_sign = false, sign_name = signName })
  else
    sign.start_animated_sign(line, "dots4", 100)
  end
  vim.api.nvim_set_current_win(currentWin)
end
