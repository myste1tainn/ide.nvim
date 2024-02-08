
-- Try to detect the type of IDE it needs to be
--

local p = require('plenary.scandir')

local is_flutter_dir = false
local v = p.scan_dir('.', {depth=1, hidden=true})
for _,f in ipairs(v) do
  if string.find(f, 'flutter') then
    is_flutter_dir = true
    break
  end
end

return {
  is_flutter_dir = is_flutter_dir
}
--for f in p.ls() do
--  print(f)
--end
--for file in lfs.dir[[C:\Program Files]] do
--    if lfs.attributes(file,"mode") == "file" then print("found file, "..file)
--    elseif lfs.attributes(file,"mode")== "directory" then print("found dir, "..file," containing:")
--        for l in lfs.dir("C:\\Program Files\\"..file) do
--             print("",l)
--        end
--    end
--end
