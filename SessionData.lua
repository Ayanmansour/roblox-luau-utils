--!strict
-- SessionData.lua
-- In-memory player data only. Does NOT persist between servers or sessions.

local SessionData = {}

type Profile = {
	coins: number,
	level: number,
}

local profiles: {[number]: Profile} = {}

function SessionData.load(userId: number): Profile
	if not profiles[userId] then
		profiles[userId] = { coins = 0, level = 1 }
	end
	return profiles[userId]
end

function SessionData.addCoins(userId: number, amount: number): number
	assert(amount >= 0 and amount == math.floor(amount), "amount must be a nonnegative integer")
	local profile = SessionData.load(userId)
	profile.coins += amount
	return profile.coins
end

function SessionData.getCoins(userId: number): number
	return SessionData.load(userId).coins
end

function SessionData.remove(userId: number)
	profiles[userId] = nil
end

return SessionData
