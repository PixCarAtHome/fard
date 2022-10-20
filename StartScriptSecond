repeat task.wait() until game:IsLoaded()
repeat task.wait() until shared.GuiLibrary
local uis = game:GetService("UserInputService")
local GuiLibrary = shared.GuiLibrary
local ScriptSettings = {}
local UIS = game:GetService("UserInputService")
local LIB = function(tab, argstable) 
	return GuiLibrary["ObjectsThatCanBeSaved"][tab.."Window"]["Api"].CreateOptionsButton(argstable)
end
function securefunc(func)
	task.spawn(function()
		spawn(function()
			pcall(function()
				loadstring(
					func()
				)()
			end)
		end)
	end)
end
function warnnotify(title, content, duration)
	local frame = GuiLibrary["CreateNotification"](title or "[!] Warning", content or "(No Content Given)", duration or 5, "assets/WarningNotification.png")
	frame.Frame.Frame.ImageColor3 = Color3.fromRGB(255, 64, 64)
end
function infonotify(title, content, duration)
	local frame = GuiLibrary["CreateNotification"](title or "[?] Info", content or "(No Content Given)", duration or 5, "assets/InfoNotification.png")
	frame.Frame.Frame.ImageColor3 = Color3.fromRGB(255, 64, 64)
end
function getstate()
	local ClientStoreHandler = require(game.Players.LocalPlayer.PlayerScripts.TS.ui.store).ClientStore
	return ClientStoreHandler:getState().Game.matchState
end
function iscustommatch()
	local ClientStoreHandler = require(game.Players.LocalPlayer.PlayerScripts.TS.ui.store).ClientStore
	return ClientStoreHandler:getState().Game.customMatch
end
function checklagback()
	local hrp = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart
	return isnetworkowner(hrp)
end
 
local HostPanel = LIB("Private", {
	["Name"]  = "Host Panel",
	["Function"] = function(callback)
		if callback then
		end
	end,
	["Default"] = false,
	["HoverText"] = "Host Panel"
})
local HostPanel = LIB("Private", {
	["Name"]  = "Faster AutoWin",
	["Function"] = function(callback)
		if callback then
		for i, v in pairs(Game.Players:GetChildren()) do
			if not v.Character then return end
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame
				wait(3)
			end
		end
	end,
	["Default"] = false,
	["HoverText"] = "For Skywars"
})
local HostPanel = LIB("Private", {
	["Name"]  = "Inf Reach",
	["Function"] = function(callback)
		if callback then
		end
	end,
	["Default"] = false,
	["HoverText"] = "For Skywars"
})
