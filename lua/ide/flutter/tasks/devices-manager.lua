require("ide.flutter.tasks.rx-flutter-exec")
require("ide.flutter.tasks.rx-job")
require("ide.flutter.tasks.get-devices-task")
require("ide.windows")
require("ide.windows.task-manager")

local EMULATOR = 1
local DEVICE = 2

---@class DeviceManager
DeviceManager = {}

function DeviceManager.setup()
  TaskManager:setup(Windows.activity)
  DeviceManager.window = Windows.devices
  DeviceManager.window:onSelectionChange():subscribe(function(data)
    print("selected data =", Dump(data))
  end)
  TaskManager:run(GetDevicesTask:new()):subscribe(function(options)
    --local borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }
    --Win_id = popup.create(l, {
    --  title = "MyProjects",
    --  highlight = "MyProjectWindow",
    --  borderchars = borderchars,
    --  callback = function(_, sel)
    --    print('selected = ', sel)
    --  end
    --})
    --local bufnr = vim.api.nvim_win_get_buf(Win_id)
    --vim.api.nvim_buf_set_keymap(bufnr, "n", "q", "<cmd>lua CloseMenu()<CR>", { silent = false })
    DeviceManager.window:setOptions(options)
  end)
  -- exec.flutter(function(cmd)
  --   tm:run({
  --     name = "Get Devices",
  --     cmd = cmd,
  --     args = { "devices" },
  --     onSuccess = function(output)
  --       local lines = To_selection_entries(output, DEVICE)
  --       local l = {}
  --       for _, v in ipairs(lines) do
  --         table.insert(l, v.text)
  --       end
  --       if #lines > 0 then
  --         --local borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }
  --         --Win_id = popup.create(l, {
  --         --  title = "MyProjects",
  --         --  highlight = "MyProjectWindow",
  --         --  borderchars = borderchars,
  --         --  callback = function(_, sel)
  --         --    print('selected = ', sel)
  --         --  end
  --         --})
  --         --local bufnr = vim.api.nvim_win_get_buf(Win_id)
  --         --vim.api.nvim_buf_set_keymap(bufnr, "n", "q", "<cmd>lua CloseMenu()<CR>", { silent = false })
  --         M.window:log(l)
  --       end
  --     end,
  --     onFailure = function(_) end,
  --   })
  -- end)
end
