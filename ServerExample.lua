--!strict
-- Put this Script in ServerScriptService.
-- Put the three ModuleScripts from src/ in ServerScriptService/Utilities.
local Players = game:GetService("Players")
local Utilities = script.Parent:WaitForChild("Utilities")
local Cooldown = require(Utilities:WaitForChild("Cooldown"))
local Countdown = require(Utilities:WaitForChild("Countdown"))
local SessionData = require(Utilities:WaitForChild("SessionData"))

Players.PlayerAdded:Connect(function(player)
	SessionData.load(player.UserId)
	if Cooldown.tryUse(player.UserId, "joinBonus", 5) then
		local coins = SessionData.addCoins(player.UserId, 10)
		print(player.Name .. " has " .. tostring(coins) .. " session coins")
	end

	Countdown.start(3, function(remaining)
		print(player.Name .. " countdown: " .. remaining)
	end, function()
		print(player.Name .. " countdown finished")
	end)
end)

Players.PlayerRemoving:Connect(function(player)
	Cooldown.clearPlayer(player.UserId)
	SessionData.remove(player.UserId)
end)
