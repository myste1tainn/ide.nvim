require('uide.windows.window-type-enum')
require('ui')

WindowType = {}

function WindowType:split(opts)
  opts = opts or {}
  opts.direction = opts.direction or SplitDirection.BOTTOM

  local M = {}
  M.type = WindowTypeEnum.SPLIT
  M.direction = opts.direction

  return M
end
