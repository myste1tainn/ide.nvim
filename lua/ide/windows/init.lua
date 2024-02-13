require("uinvim")
require("ide.windows.window-type")
require("ide.windows.window-type-enum")
require("ide.utils")

---@class Windows
---@field activity Window
---@field devices SelectionWindow
---@field run TermWindow
Windows = {
  _windows = {},
}

function Windows.setup()
  local devices = SelectionWindow:new({
    name = "devices",
    optionName = function(data)
      return data.text
    end,
    opts = {
      direction = SplitDirection.TOP,
    },
  })

  local navigator = Window:new({
    name = "navigator",
    opts = {
      direction = SplitDirection.LEFT,
    },
  })

  local structure = Window:new({
    name = "structure",
    opts = {
      direction = SplitDirection.RIGHT,
    },
    body = {
      devices,
    },
  })

  local activity = Window:new({
    name = "Activity",
    opts = {
      direction = SplitDirection.RIGHT,
    },
    --buffer = TaskManager.instance.tasks.map(function() end)
  })

  local runWindow = TermWindow:new({
    name = "Run",
    opts = {
      direction = SplitDirection.BOTTOM,
    },
    body = {
      activity,
    },
  })

  local main = MainWindow:new({
    name = "editor",
    body = {
      --navigator,
      structure,
      runWindow,
    },
  }):render()

  Windows.main = main
  Windows.devices = devices
  Windows.navigator = navigator
  Windows.structure = structure
  Windows.activity = activity
  Windows.run = runWindow

  -- TODO: Remove this, this is only for the testing purpose
  Windows:run("flutter run")

  --devices:setOptions({
  --  "Option 1",
  --  "Option 2",
  --  "Option 3",
  --  "Option 4",
  --  "Option 5",
  --})
  --local data = {
  --  "0",
  --  "0",
  --  "0",
  --  "0",
  --  "0",
  --}
  --devices:texts(data)
  --local tick = false
  --require("timer").add( -- require function and call it
  --  function()         -- pass your function
  --    for i, v in ipairs(data) do
  --      data[i] = tostring(tonumber(v) + 1)
  --    end
  --    devices:texts(data)
  --    tick = not tick
  --    return 1000
  --  end
  --)
end

function Windows.get(winId)
  winId = tonumber(winId)
  for _, v in ipairs(Windows._windows) do
    if v.handle == winId then
      return v
    end
  end
end
