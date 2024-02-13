require("ide.flutter.tasks.rx-flutter-exec")
require("ide.flutter.tasks.rx-job")
require("ide.flutter.tasks.task")
local popup = require("plenary.popup")
local ui = require("flutter-tools.ui")

local EMULATOR = 1
local DEVICE = 2

---@class GetDevicesTask:Task
GetDevicesTask = {}

function GetDevicesTask:new(o)
  o = Task.new(self, {
    name = "Get Devices",
    execute = function()
      return RxFlutterExec():flatMap(function(cmd)
        return RxJob:new({ cmd = cmd, args = { "devices" } }):run()
      end):map(function(result)
        return To_selection_entries(result, DEVICE)
      end)
    end,
  })
  setmetatable(o, self)
  self.__index = self
  return o
end

---@param result string[]
---@param type integer
local function get_devices(result, type)
  local devices = {}
  for _, line in pairs(result) do
    local device = Parse(line, type)
    if device then
      table.insert(devices, device)
    end
  end
  return devices
end

function To_selection_entries(result, device_type)
  if not result or #result < 1 then
    return {}
  end
  if not device_type then
    device_type = DEVICE
  end
  local devices = get_devices(result, device_type)
  if #devices == 0 then
    vim.tbl_map(function(item)
      return { text = item }
    end, result)
  end
  return vim.tbl_map(function(device)
    local has_platform = device.platform and device.platform ~= ""
    return {
      text = string.format(" %s %s ", device.name, has_platform and " • " .. device.platform or " "),
      type = ui.entry_type.DEVICE,
      data = device,
    }
  end, devices)
end

--
---@param line string
---@param device_type number
---@return Device?
function Parse(line, device_type)
  local parts = vim.split(line, "•")
  local is_emulator = device_type == EMULATOR
  local name_index = not is_emulator and 1 or 2
  local id_index = not is_emulator and 2 or 1
  if #parts == 4 then
    return {
      name = vim.trim(parts[name_index]),
      id = vim.trim(parts[id_index]),
      platform = vim.trim(parts[3]),
      system = vim.trim(parts[4]),
      type = device_type,
    }
  end
end

function Show_menu(job)
  local lines = To_selection_entries(job:result(), DEVICE)
  local l = {}
  for _, v in ipairs(lines) do
    table.insert(l, v.text)
  end
  if #lines > 0 then
    local borderchars = { "─", "│ ", "─", " │", "╭", "╮", "╯", "╰" }

    Win_id = popup.create(l, {
      title = "Devices",
      highlight = "MyProjectWindow",
      borderchars = borderchars,
      callback = function(_, sel)
        print("selected = ", sel)
      end,
    })

    local bufnr = vim.api.nvim_win_get_buf(Win_id)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "q", "<cmd>lua CloseMenu()<CR>", { silent = false })
  end
end

function CloseMenu()
  vim.api.nvim_win_close(Win_id, true)
end
