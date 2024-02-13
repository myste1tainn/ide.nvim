local Rx = require("rx")
local exec = require("flutter-tools.executable")

function RxFlutterExec()
  return Rx.Observable.create(function(observer)
    exec.flutter(function(cmd)
      observer:onNext(cmd)
    end)
  end)
end
