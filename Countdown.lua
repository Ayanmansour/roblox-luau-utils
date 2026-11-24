--!strict
-- Countdown.lua
-- Asynchronous countdown. start() returns a cancellation function.

local Countdown = {}

-- onTick receives seconds left; onFinished runs only if not cancelled.
function Countdown.start(seconds: number, onTick: (number) -> (), onFinished: (() -> ())?): () -> ()
	assert(seconds >= 0 and seconds == math.floor(seconds), "seconds must be a nonnegative integer")
	local cancelled = false
	local thread = task.spawn(function()
		for remaining = seconds, 0, -1 do
			if cancelled then
				return
			end
			onTick(remaining)
			if remaining > 0 then
				task.wait(1)
			end
		end
		if not cancelled and onFinished then
			onFinished()
		end
	end)

	return function()
		cancelled = true
		-- Cancellation is cooperative so callers do not need to manage threads.
	end
end

return Countdown
