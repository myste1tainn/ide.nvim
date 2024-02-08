local info = require('uide.detection')
local windows = require('uide.windows')
local lazy = require('flutter-tools.lazy')
local popup = lazy.require('plenary.popup')
local p = lazy.require('plenary.scandir')
local ui = lazy.require("flutter-tools.ui") ---@module "flutter-tools.ui"
local utils = lazy.require("flutter-tools.utils") ---@module "flutter-tools.utils"
local fmt = string.format

-- BEGIN CODE FOR TESTING PURPOSE
--function SourceAllFiles()
--  local dirs = p.scan_dir('/Users/arnon.keereena/.config/nvim/lua/uide', { hidden = true, depth = 2 })
--  for _, f in ipairs(dirs) do
--    if string.match(f, ".lua") then
--      if string.match(f, "uide/init.lua") then
--        goto continue
--      end
--      -- Source only the lua files
--      print('Sourcing file =', f)
--      local command = 'so ' .. f
--      vim.cmd(command)
--    end
--    ::continue::
--  end
--
--  vim.cmd('so /Users/arnon.keereena/.config/nvim/lua/uide/init.lua')
--end
--
--vim.api.nvim_create_user_command('SourceAllFiles', SourceAllFiles, {})
--vim.keymap.set('n', '<leader>t', ':SourceAllFiles<CR>')
--vim.cmd('cd /Users/arnon.keereena/Desktop/personal/restaur')
-- END CODE FOR TESTING PURPOSE

windows.setup()

if info.is_flutter_dir then
  require('uide.flutter').setup()
end


