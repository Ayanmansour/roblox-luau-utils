--!strict
-- Cooldown.lua
-- Server-side cooldown tracking using a monotonic clock.

local Cooldown = {}
local expiresAt: {[string]: number} = {}

local function keyFor(userId: number, action: string): string
	return tostring(userId) .. ":" .. action
end

-- Returns true if the action can begin, then starts its cooldown.
function Cooldown.tryUse(userId: number, action: string, duration: number): boolean
	assert(duration >= 0, "duration must be nonnegative")
	local key = keyFor(userId, action)
	local now = os.clock()
	if (expiresAt[key] or 0) > now then
		return false
	end
	expiresAt[key] = now + duration
	return true
end

function Cooldown.remaining(userId: number, action: string): number
	return math.max(0, (expiresAt[keyFor(userId, action)] or 0) - os.clock())
end

function Cooldown.clear(userId: number, action: string)
	expiresAt[keyFor(userId, action)] = nil
end

-- Call when a player leaves to prevent unbounded key growth.
function Cooldown.clearPlayer(userId: number)
	local prefix = tostring(userId) .. ":"
	for key in pairs(expiresAt) do
		if string.sub(key, 1, #prefix) == prefix then
			expiresAt[key] = nil
		end
	end
end

return Cooldown
