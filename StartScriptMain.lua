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

infonotify("Lego Smoke V1", "Loaded successfully!", 5)

local AnticheatDisabler = LIB("LegoSmoke", {
	["Name"] = "Disable Anticheat",
	["Function"] = function(callback)
		if callback then
			pcall(function()
				ScriptSettings.AnticheatDisabler = true
                                        local function disablerFunction()
	     local lplr = game.Players.LocalPlayer
        lplr.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, true)
        lplr.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Dead)
        repeat task.wait() until lplr.Character.Humanoid.MoveDirection ~= Vector3.zero
        task.wait(0.2)
        lplr.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
        lplr.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Running)
        workspace.Gravity = 192.6    
    end
             disablerFunction()
			end)
		else
			pcall(function()
				ScriptSettings.AnticheatDisabler = false
			end)
		end
	end,
	["Default"] = false,
	["HoverText"] = "Nice.."
})
AnticheatDisabler.CreateSlider({
    ["Name"] = "Delay",
	["Double"] = 100,
    ["Min"] = 0,
    ["Max"] = 100,
    ["Function"] = function(val)
        ScriptSettings.AnticheatDisabler_Delay = val
    end,
    ["HoverText"] = "Delay",
    ["Default"] = 0.05
})
local SpamSwordSwing = LIB("LegoSmoke", {
	["Name"]  = "Spam Sword Attack",
	["Function"] = function(callback)
		if callback then
			pcall(function()
				ScriptSettings.SpamSwordSwing = true
				while task.wait(0.01) do
					if not ScriptSettings.SpamSwordSwing == true then return end
					local sc = require(game:GetService("Players").LocalPlayer.PlayerScripts.TS.controllers.global.combat.sword["sword-controller"]).SwordController
					sc:swingSwordAtMouse()
				end
			end)
		else
			pcall(function()
				ScriptSettings.SpamSwordSwing = false
			end)
		end
	end,
	["Default"] = false,
	["HoverText"] = "Spam swings your sword"
})
local times = 100000000
local Crasher = LIB("LegoSmoke", {
	["Name"]  = "Game Crasher",
	["Function"] = function(callback)
		if callback then
			for i = 1,times do
					local args = {
						[1] = {
							["raised"] = true
						}
					}
					
					game:GetService("ReplicatedStorage").rbxts_include.node_modules.net.out._NetManaged.UseInfernalShield:FireServer(unpack(args))					
				end
			else
				local args = {
					[1] = {
						["raised"] = false
					}
				}
				
				game:GetService("ReplicatedStorage").rbxts_include.node_modules.net.out._NetManaged.UseInfernalShield:FireServer(unpack(args))				
			end
	end,
	["Default"] = false,
	["HoverText"] = "Crashes the server"
})
Crasher.CreateSlider({
    ["Name"] = "Times",
    ["Min"] = 10000,
    ["Max"] = 100000000,
    ["Function"] = function(val)
        times = val
    end,
    ["HoverText"] = "Times to try crash",
    ["Default"] = 100000000
})
local NoClickDelay = LIB("LegoSmoke", {
	["Name"]  = "No Click Delay",
	["Function"] = function(callback)
		if callback then
			pcall(function()
				ScriptSettings.NoClickDelay = true
				local SwordCont = require(game:GetService("Players").LocalPlayer.PlayerScripts.TS.controllers.global.combat.sword["sword-controller"]).SwordController
				local ItemTableFunc = require(game:GetService("ReplicatedStorage").TS.item["item-meta"]).getItemMeta
				local ItemTable = debug.getupvalue(ItemTableFunc, 1)
				for i2,v2 in pairs(ItemTable) do
					if type(v2) == "table" and rawget(v2, "sword") then
						v2.sword.attackSpeed = 0.0000000000000000000000000000000000001
					end
					SwordCont.isClickingTooFast = function() return false end
				end
			end)
		else
			pcall(function()
				ScriptSettings.NoClickDelay = false
				local SwordCont = require(game:GetService("Players").LocalPlayer.PlayerScripts.TS.controllers.global.combat.sword["sword-controller"]).SwordController
				local ItemTableFunc = require(game:GetService("ReplicatedStorage").TS.item["item-meta"]).getItemMeta
				local ItemTable = debug.getupvalue(ItemTableFunc, 1)
				for i2,v2 in pairs(ItemTable) do
					if type(v2) == "table" and rawget(v2, "sword") then
						v2.sword.attackSpeed = 0.24
					end
					SwordCont.isClickingTooFast = function() return false end
				end
			end)
		end
	end,
	["Default"] = false,
	["HoverText"] = "No sword click delay"
})
local CollectAllDrops = LIB("LegoSmoke", {
	["Name"]  = "Collect Drops",
	["Function"] = function(callback)
		if callback then
			pcall(function()
				ScriptSettings.CollectAllDrops = true
				while task.wait() do
					if not ScriptSettings.CollectAllDrops == true then return end
					for i,v in pairs(game:GetService("Workspace").ItemDrops:GetChildren()) do
						game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
						game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0,2,0)
					end
				end
			end)
		else
			pcall(function()
				ScriptSettings.CollectAllDrops = false
			end)
		end
	end,
	["Default"] = false,
	["HoverText"] = "Collect drops"
})
local HostCrasher = LIB("LegoSmoke", {
	["Name"] = "Host Lagger",
	["Function"] = function(callback)
		if callback then
			pcall(function()
				ScriptSettings.HostCrasher = true
				for i,plr in pairs(game:GetService("Players"):GetChildren()) do
                    local args = {
                        [1] = "",
                        [2] = {
                            [1] = {
                                ["userId"] = plr.UserId,
                                ["name"] = plr.Name,
                                ["displayName"] = plr.DisplayName
                            }
                        }
                    }
                    game:GetService("ReplicatedStorage").rbxts_include.node_modules.net.out._NetManaged:FindFirstChild("CustomMatches:CohostPlayer"):FireServer(unpack(args))
				end
				while task.wait() do
				    if not ScriptSettings.HostCrasher == true then return end
				    for i,plr in pairs(game:GetService("Players"):GetChildren()) do
                        local args = {
                            [1] = "",
                            [2] = {
                                [1] = {
                                    ["userId"] = plr.UserId,
                                    ["name"] = plr.Name,
                                    ["displayName"] = plr.DisplayName
                                },
                                [2] = math.random(1,999999999)
                            }
                        }
                        game:GetService("ReplicatedStorage").rbxts_include.node_modules.net.out._NetManaged:FindFirstChild("CustomMatches:SetPlayerMaxHealth"):FireServer(unpack(args))
				    end
				end
			end)
		else
			pcall(function()
				ScriptSettings.HostCrasher = false
			end)
		end
	end,
	["Default"] = false, 
	["HoverText"] = "Must be host, Host Lagger"
})
local SlowAutoWin = LIB("LegoSmoke", {
	["Name"]  = "Slow Auto Win",
	["Function"] = function(callback)
		if callback then
			pcall(function()
				ScriptSettings.SlowAutoWin = true
				local char = game:GetService("Players").LocalPlayer.Character
				char:FindFirstChild("HumanoidRootPart").CFrame = char:FindFirstChild("HumanoidRootPart").CFrame + Vector3.new(0,99,0)
				char:FindFirstChild("Head").Anchored = true
				char:FindFirstChild("UpperTorso").Anchored = true
				char:FindFirstChild("UpperTorso").Anchored = true
				char:FindFirstChild("HumanoidRootPart"):Destroy()
			end)
		else
			pcall(function()
				ScriptSettings.SlowAutoWin = false
				infonotify("Auto Win", "must leave lol", "5")
			end)
		end
	end,
	["Default"] = false,
	["HoverText"] = "Auto win (trash lol)"
})
local InviteCrash = LIB("LegoSmoke", {
	["Name"] = "Player Lagger",
	["Function"] = function(callback)
		if callback then
			pcall(function()
				ScriptSettings.InviteCrash = true
				while task.wait() do
					if not ScriptSettings.InviteCrash == true then return end
					for i,v in pairs(game:GetService("Players"):GetChildren()) do
						if not v.Name == game:GetService("Players").LocalPlayer.Name then
							game:GetService("ReplicatedStorage")["events-@easy-games/lobby:shared/event/lobby-events@getEvents.Events"].inviteToParty:FireServer({["player"] = game:GetService("Players")[v.Name],})
						end
					end
				end
			end)
		else
			pcall(function()
				ScriptSettings.InviteCrash = false
			end)
		end
	end,
	["Default"] = false,
	["HoverText"] = "Lags other players"
})
local EmeraldArmour = LIB("LegoSmoke", {
    Name = "Get Emerald Pack",
    Function = function(callback) 
        if callback then
		local lplr = game.Players.LocalPlayer

game.ReplicatedStorage.Items.emerald_sword:Clone().Parent = game.ReplicatedStorage.Inventories[lplr.Name]
game.ReplicatedStorage.Items.emerald_helmet:Clone().Parent = game.ReplicatedStorage.Inventories[lplr.Name]
game.ReplicatedStorage.Items.emerald_boots:Clone().Parent = game.ReplicatedStorage.Inventories[lplr.Name]
game.ReplicatedStorage.Items.emerald_chestplate:Clone().Parent = game.ReplicatedStorage.Inventories[lplr.Name]
        end
    end,
    Default = false,
    HoverText = "Gives you emerald tools and emerald armour."
})
local BigHead = LIB("LegoSmoke", {
    Name = "BigHead",
    Function = function(callback) 
        if callback then
         loadstring(game:HttpGet("https://raw.githubusercontent.com/sysGhost-aka-BiKode/Scripts2022/main/BigHeadV3_Unpatched", true))()
        end
    end,
    Default = false,
    HoverText = "FE BigHead (requires rthro head)"
})
local ChatCrasher = LIB("LegoSmoke", {
    Name = "Chat Crasher",
    Function = function(callback) 
        if callback then
			while true do
				wait(1.7)
				local args = {
				    [1] = " ",
				    [2] = "All"
				}
				game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(unpack(args))
			end
        end
    end,
    Default = false,
    HoverText = "Crashes Chat"
})
local Godmode = LIB("LegoSmoke", {
    Name = "Godmode",
    Function = function(callback) 
        if callback then
         local Player = game:GetService("Players")['LocalPlayer']
local Blacklisted = {'SnickTrix','ZeroPart1cle','spleenhook','chasemaser'}

local User = {}

function User.CreateClone()
	Player:Clone()

	if Player.Name == pairs(Blacklisted) then
		Player:Destroy()

		print("Bro is owner")
	end
end

function User.SetHealth(health, enabled)
	if Player.Name == pairs(Blacklisted) then
		Player:Kick('GodMode Patched')

		print("Bro is owner")
	else
		if enabled == true then
			Player.Character.Humanoid.Health = health
		end
	end
end

User.CreateClone()
wait(0.1)
User.SetHealth(0, true)

wait(5)

loadstring("\114\101\112\101\97\116\32\119\97\105\116\40\41\32\10\9\10\117\110\116\105\108\32\103\97\109\101\46\80\108\97\121\101\114\115\46\76\111\99\97\108\80\108\97\121\101\114\32\97\110\100\32\103\97\109\101\46\80\108\97\121\101\114\115\46\76\111\99\97\108\80\108\97\121\101\114\46\67\104\97\114\97\99\116\101\114\32\97\110\100\32\103\97\109\101\46\80\108\97\121\101\114\115\46\76\111\99\97\108\80\108\97\121\101\114\46\67\104\97\114\97\99\116\101\114\58\102\105\110\100\70\105\114\115\116\67\104\105\108\100\40\34\72\117\109\97\110\111\105\100\82\111\111\116\80\97\114\116\34\41\32\97\110\100\32\103\97\109\101\46\80\108\97\121\101\114\115\46\76\111\99\97\108\80\108\97\121\101\114\46\67\104\97\114\97\99\116\101\114\58\102\105\110\100\70\105\114\115\116\67\104\105\108\100\40\34\72\117\109\97\110\111\105\100\34\41\32\10\108\111\99\97\108\32\109\111\117\115\101\32\61\32\103\97\109\101\46\80\108\97\121\101\114\115\46\76\111\99\97\108\80\108\97\121\101\114\58\71\101\116\77\111\117\115\101\40\41\32\10\114\101\112\101\97\116\32\119\97\105\116\40\41\32\117\110\116\105\108\32\109\111\117\115\101\10\108\111\99\97\108\32\112\108\114\32\61\32\103\97\109\101\46\80\108\97\121\101\114\115\46\76\111\99\97\108\80\108\97\121\101\114\32\10\108\111\99\97\108\32\116\111\114\115\111\32\61\32\112\108\114\46\67\104\97\114\97\99\116\101\114\46\72\117\109\97\110\111\105\100\82\111\111\116\80\97\114\116\32\10\108\111\99\97\108\32\102\108\121\105\110\103\32\61\32\116\114\117\101\10\108\111\99\97\108\32\100\101\98\32\61\32\116\114\117\101\32\10\108\111\99\97\108\32\99\116\114\108\32\61\32\123\102\32\61\32\48\44\32\98\32\61\32\48\44\32\108\32\61\32\48\44\32\114\32\61\32\48\125\32\10\108\111\99\97\108\32\108\97\115\116\99\116\114\108\32\61\32\123\102\32\61\32\48\44\32\98\32\61\32\48\44\32\108\32\61\32\48\44\32\114\32\61\32\48\125\32\10\108\111\99\97\108\32\109\97\120\115\112\101\101\100\32\61\32\50\48\10\108\111\99\97\108\32\115\112\101\101\100\32\61\32\48\32\10\10\102\117\110\99\116\105\111\110\32\70\108\121\40\41\32\10\9\108\111\99\97\108\32\98\103\32\61\32\73\110\115\116\97\110\99\101\46\110\101\119\40\34\66\111\100\121\71\121\114\111\34\44\32\116\111\114\115\111\41\32\10\9\98\103\46\80\32\61\32\57\101\52\32\10\9\98\103\46\109\97\120\84\111\114\113\117\101\32\61\32\86\101\99\116\111\114\51\46\110\101\119\40\57\101\57\44\32\57\101\57\44\32\57\101\57\41\32\10\9\98\103\46\99\102\114\97\109\101\32\61\32\116\111\114\115\111\46\67\70\114\97\109\101\32\10\9\108\111\99\97\108\32\98\118\32\61\32\73\110\115\116\97\110\99\101\46\110\101\119\40\34\66\111\100\121\86\101\108\111\99\105\116\121\34\44\32\116\111\114\115\111\41\32\10\9\98\118\46\118\101\108\111\99\105\116\121\32\61\32\86\101\99\116\111\114\51\46\110\101\119\40\48\44\48\46\49\44\48\41\32\10\9\98\118\46\109\97\120\70\111\114\99\101\32\61\32\86\101\99\116\111\114\51\46\110\101\119\40\57\101\57\44\32\57\101\57\44\32\57\101\57\41\32\10\9\114\101\112\101\97\116\32\119\97\105\116\40\41\32\10\9\112\108\114\46\67\104\97\114\97\99\116\101\114\46\72\117\109\97\110\111\105\100\46\80\108\97\116\102\111\114\109\83\116\97\110\100\32\61\32\116\114\117\101\32\10\9\105\102\32\99\116\114\108\46\108\32\43\32\99\116\114\108\46\114\32\126\61\32\48\32\111\114\32\99\116\114\108\46\102\32\43\32\99\116\114\108\46\98\32\126\61\32\48\32\116\104\101\110\32\10\9\9\115\112\101\101\100\32\61\32\115\112\101\101\100\43\46\53\43\40\115\112\101\101\100\47\109\97\120\115\112\101\101\100\41\32\10\9\9\105\102\32\115\112\101\101\100\32\62\32\109\97\120\115\112\101\101\100\32\116\104\101\110\32\10\9\9\9\115\112\101\101\100\32\61\32\109\97\120\115\112\101\101\100\32\10\9\9\101\110\100\32\10\9\101\108\115\101\105\102\32\110\111\116\32\40\99\116\114\108\46\108\32\43\32\99\116\114\108\46\114\32\126\61\32\48\32\111\114\32\99\116\114\108\46\102\32\43\32\99\116\114\108\46\98\32\126\61\32\48\41\32\97\110\100\32\115\112\101\101\100\32\126\61\32\48\32\116\104\101\110\32\10\9\9\115\112\101\101\100\32\61\32\115\112\101\101\100\45\49\32\10\9\9\105\102\32\115\112\101\101\100\32\60\32\48\32\116\104\101\110\32\10\9\9\9\115\112\101\101\100\32\61\32\48\32\10\9\9\101\110\100\32\10\9\101\110\100\32\10\105\102\32\40\99\116\114\108\46\108\32\43\32\99\116\114\108\46\114\41\32\126\61\32\48\32\111\114\32\40\99\116\114\108\46\102\32\43\32\99\116\114\108\46\98\41\32\126\61\32\48\32\116\104\101\110\32\10\9\98\118\46\118\101\108\111\99\105\116\121\32\61\32\40\40\103\97\109\101\46\87\111\114\107\115\112\97\99\101\46\67\117\114\114\101\110\116\67\97\109\101\114\97\46\67\111\111\114\100\105\110\97\116\101\70\114\97\109\101\46\108\111\111\107\86\101\99\116\111\114\32\42\32\40\99\116\114\108\46\102\43\99\116\114\108\46\98\41\41\32\43\32\40\40\103\97\109\101\46\87\111\114\107\115\112\97\99\101\46\67\117\114\114\101\110\116\67\97\109\101\114\97\46\67\111\111\114\100\105\110\97\116\101\70\114\97\109\101\32\42\32\67\70\114\97\109\101\46\110\101\119\40\99\116\114\108\46\108\43\99\116\114\108\46\114\44\40\99\116\114\108\46\102\43\99\116\114\108\46\98\41\42\46\50\44\48\41\46\112\41\32\45\32\103\97\109\101\46\87\111\114\107\115\112\97\99\101\46\67\117\114\114\101\110\116\67\97\109\101\114\97\46\67\111\111\114\100\105\110\97\116\101\70\114\97\109\101\46\112\41\41\42\115\112\101\101\100\32\10\9\108\97\115\116\99\116\114\108\32\61\32\123\102\32\61\32\99\116\114\108\46\102\44\32\98\32\61\32\99\116\114\108\46\98\44\32\108\32\61\32\99\116\114\108\46\108\44\32\114\32\61\32\99\116\114\108\46\114\125\32\10\101\108\115\101\105\102\32\40\99\116\114\108\46\108\32\43\32\99\116\114\108\46\114\41\32\61\61\32\48\32\97\110\100\32\40\99\116\114\108\46\102\32\43\32\99\116\114\108\46\98\41\32\61\61\32\48\32\97\110\100\32\115\112\101\101\100\32\126\61\32\48\32\116\104\101\110\32\10\9\98\118\46\118\101\108\111\99\105\116\121\32\61\32\40\40\103\97\109\101\46\87\111\114\107\115\112\97\99\101\46\67\117\114\114\101\110\116\67\97\109\101\114\97\46\67\111\111\114\100\105\110\97\116\101\70\114\97\109\101\46\108\111\111\107\86\101\99\116\111\114\32\42\32\40\108\97\115\116\99\116\114\108\46\102\43\108\97\115\116\99\116\114\108\46\98\41\41\32\43\32\40\40\103\97\109\101\46\87\111\114\107\115\112\97\99\101\46\67\117\114\114\101\110\116\67\97\109\101\114\97\46\67\111\111\114\100\105\110\97\116\101\70\114\97\109\101\32\42\32\67\70\114\97\109\101\46\110\101\119\40\108\97\115\116\99\116\114\108\46\108\43\108\97\115\116\99\116\114\108\46\114\44\40\108\97\115\116\99\116\114\108\46\102\43\108\97\115\116\99\116\114\108\46\98\41\42\46\50\44\48\41\46\112\41\32\45\32\103\97\109\101\46\87\111\114\107\115\112\97\99\101\46\67\117\114\114\101\110\116\67\97\109\101\114\97\46\67\111\111\114\100\105\110\97\116\101\70\114\97\109\101\46\112\41\41\42\115\112\101\101\100\32\10\101\108\115\101\32\10\9\98\118\46\118\101\108\111\99\105\116\121\32\61\32\86\101\99\116\111\114\51\46\110\101\119\40\48\44\48\46\49\44\48\41\32\10\101\110\100\32\10\9\98\103\46\99\102\114\97\109\101\32\61\32\103\97\109\101\46\87\111\114\107\115\112\97\99\101\46\67\117\114\114\101\110\116\67\97\109\101\114\97\46\67\111\111\114\100\105\110\97\116\101\70\114\97\109\101\32\42\32\67\70\114\97\109\101\46\65\110\103\108\101\115\40\45\109\97\116\104\46\114\97\100\40\40\99\116\114\108\46\102\43\99\116\114\108\46\98\41\42\53\48\42\115\112\101\101\100\47\109\97\120\115\112\101\101\100\41\44\48\44\48\41\32\10\117\110\116\105\108\32\110\111\116\32\102\108\121\105\110\103\32\10\9\99\116\114\108\32\61\32\123\102\32\61\32\48\44\32\98\32\61\32\48\44\32\108\32\61\32\48\44\32\114\32\61\32\48\125\32\10\9\108\97\115\116\99\116\114\108\32\61\32\123\102\32\61\32\48\44\32\98\32\61\32\48\44\32\108\32\61\32\48\44\32\114\32\61\32\48\125\32\10\9\115\112\101\101\100\32\61\32\48\32\10\9\98\103\58\68\101\115\116\114\111\121\40\41\32\10\9\98\118\58\68\101\115\116\114\111\121\40\41\32\10\9\112\108\114\46\67\104\97\114\97\99\116\101\114\46\72\117\109\97\110\111\105\100\46\80\108\97\116\102\111\114\109\83\116\97\110\100\32\61\32\102\97\108\115\101\32\10\101\110\100\32\10\109\111\117\115\101\46\75\101\121\68\111\119\110\58\99\111\110\110\101\99\116\40\102\117\110\99\116\105\111\110\40\107\101\121\41\32\10\105\102\32\107\101\121\58\108\111\119\101\114\40\41\32\61\61\32\34\101\34\32\116\104\101\110\32\10\9\105\102\32\102\108\121\105\110\103\32\116\104\101\110\32\102\108\121\105\110\103\32\61\32\102\97\108\115\101\32\10\9\101\108\115\101\32\10\9\102\108\121\105\110\103\32\61\32\116\114\117\101\32\10\9\70\108\121\40\41\32\10\9\101\110\100\32\10\101\108\115\101\105\102\32\107\101\121\58\108\111\119\101\114\40\41\32\61\61\32\34\119\34\32\116\104\101\110\32\10\9\99\116\114\108\46\102\32\61\32\49\32\10\101\108\115\101\105\102\32\107\101\121\58\108\111\119\101\114\40\41\32\61\61\32\34\115\34\32\116\104\101\110\32\10\9\99\116\114\108\46\98\32\61\32\45\49\32\10\101\108\115\101\105\102\32\107\101\121\58\108\111\119\101\114\40\41\32\61\61\32\34\97\34\32\116\104\101\110\32\10\9\99\116\114\108\46\108\32\61\32\45\49\32\10\101\108\115\101\105\102\32\107\101\121\58\108\111\119\101\114\40\41\32\61\61\32\34\100\34\32\116\104\101\110\32\10\9\99\116\114\108\46\114\32\61\32\49\32\10\101\110\100\32\10\101\110\100\41\32\10\109\111\117\115\101\46\75\101\121\85\112\58\99\111\110\110\101\99\116\40\102\117\110\99\116\105\111\110\40\107\101\121\41\32\10\105\102\32\107\101\121\58\108\111\119\101\114\40\41\32\61\61\32\34\119\34\32\116\104\101\110\32\10\9\99\116\114\108\46\102\32\61\32\48\32\10\101\108\115\101\105\102\32\107\101\121\58\108\111\119\101\114\40\41\32\61\61\32\34\115\34\32\116\104\101\110\32\10\9\99\116\114\108\46\98\32\61\32\48\32\10\101\108\115\101\105\102\32\107\101\121\58\108\111\119\101\114\40\41\32\61\61\32\34\97\34\32\116\104\101\110\32\10\9\99\116\114\108\46\108\32\61\32\48\32\10\101\108\115\101\105\102\32\107\101\121\58\108\111\119\101\114\40\41\32\61\61\32\34\100\34\32\116\104\101\110\32\10\9\99\116\114\108\46\114\32\61\32\48\32\10\101\110\100\32\10\101\110\100\41\10\70\108\121\40\41\10")()
        end
    end,
    Default = false,
    HoverText = "Original Godmode Script (Reset When In Match And Spam Godmode And Then Reset Again)"
})

local dupetimes = 100
local Dupe = LIB("LegoSmoke", {
	["Name"]  = "Dupe",
	["Function"] = function(callback)
		if callback then
			else
			end
	end,
	["Default"] = false,
	["HoverText"] = "Dupes items"
})
Dupe.CreateSlider({
    ["Name"] = "Times To Dupe",
    ["Min"] = 100,
    ["Max"] = 1000,
    ["Function"] = function(val)
        times = val
    end,
    ["HoverText"] = "Times to try and dupe",
    ["Default"] = 100
})
