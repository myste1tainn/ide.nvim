require("uinvim.init")
require("uide.windows.window-type")
require("uide.windows.window-type-enum")
require("utils")

Windows = {
	_windows = {},
}

function Windows.setup()
	local devices = Window:new({
		name = "devices",
		opts = {
			direction = SplitDirection.TOP,
		},
	})

	MainWindow:new({
		name = "editor",
		body = {
			Window:new({
				name = "navigator",
				opts = {
					direction = SplitDirection.LEFT,
				},
			}),
			Window:new({
				name = "structure",
				opts = {
					direction = SplitDirection.RIGHT,
				},
				body = {
					devices,
				},
			}),
			Window:new({
				name = "quickfix",
				opts = {
					direction = SplitDirection.BOTTOM,
				},
				body = {
					Window:new({
						name = "task-manager",
						opts = {
							direction = SplitDirection.RIGHT,
						},
						--buffer = TaskManager.instance.tasks.map(function() end)
					}),
				},
			}),
		},
	}):render()

	devices:text("test 1")
	devices:text("test 2")
	devices:text("test 3")
	devices:text("test 4")
	devices:text("test 5")
end

function Windows.get(winId)
	winId = tonumber(winId)
	for _, v in ipairs(Windows._windows) do
		if v.handle == winId then
			return v
		end
	end
end

return Windows
