require("ide.windows") ---@class Windows
local info = require("ide.detection")
local detected = false
for _, v in pairs(info) do
  if type(v) == "boolean" and v then
    detected = true
    break
  end
end

if detected then
  Windows.setup()
end

if info.is_flutter_dir then
  require("ide.flutter").setup()
else
end
