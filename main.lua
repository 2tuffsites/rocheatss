local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
Name = "2tuff Menu",
Icon = nil,
LoadingTitle = "fyi this ISNT a logger",
LoadingSubtitle = "by luc",
Theme = {
TextColor = Color3.fromRGB(0, 102, 204),
Background = Color3.fromRGB(0, 0, 0),
Topbar = Color3.fromRGB(0, 0, 0),
Shadow = Color3.fromRGB(0, 0, 0),
NotificationBackground = Color3.fromRGB(0, 0, 0),
NotificationActionsBackground = Color3.fromRGB(0, 0, 0),
TabBackground = Color3.fromRGB(0, 0, 0),
TabStroke = Color3.fromRGB(180, 180, 180),
TabBackgroundSelected = Color3.fromRGB(0, 0, 0),
TabTextColor = Color3.fromRGB(0, 102, 204),
SelectedTabTextColor = Color3.fromRGB(0, 0, 0),
ElementBackground = Color3.fromRGB(0, 0, 0),
ElementBackgroundHover = Color3.fromRGB(0, 0, 0),
SecondaryElementBackground = Color3.fromRGB(0, 0, 0),
ElementStroke = Color3.fromRGB(0, 0, 0),
SecondaryElementStroke = Color3.fromRGB(180, 180, 180),
SliderBackground = Color3.fromRGB(0, 0, 0),
SliderProgress = Color3.fromRGB(0, 102, 204),
SliderStroke = Color3.fromRGB(0, 102, 204),
ToggleBackground = Color3.fromRGB(0, 0, 0),
ToggleEnabled = Color3.fromRGB(0, 102, 204),
ToggleDisabled = Color3.fromRGB(180, 180, 180),
ToggleEnabledStroke = Color3.fromRGB(0, 102, 204),
ToggleDisabledStroke = Color3.fromRGB(150, 150, 150),
ToggleEnabledOuterStroke = Color3.fromRGB(0, 102, 204),
ToggleDisabledOuterStroke = Color3.fromRGB(120, 120, 120),
DropdownSelected = Color3.fromRGB(0, 0, 0),
DropdownUnselected = Color3.fromRGB(0, 0, 0),
InputBackground = Color3.fromRGB(0, 0, 0),
InputStroke = Color3.fromRGB(200, 200, 200),
PlaceholderColor = Color3.fromRGB(150, 150, 150)
},
ConfigurationSaving = {
Enabled = true,
FolderName = nil,
FileName = "2tuff cheats"
},
KeySystem = true,
KeySettings = {
Title = "2tuff cheats",
Subtitle = "Key System",
Note = "Enter key to continue",
FileName = "KeySystem",
SaveKey = true,
GrabKeyFromSite = false,
Key = {"lapolicia"}
}
})

local PlayerTab = Window:CreateTab("Player", 4483362458)

PlayerTab:CreateSlider({
Name = "Speed",
Range = {16, 300},
Increment = 1,
Suffix = "Speed",
CurrentValue = 16,
Flag = "SpeedSlider",
Callback = function(Value)
local hum = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
if hum then
hum.WalkSpeed = Value
end
end,
})

PlayerTab:CreateSlider({
Name = "Jump Power",
Range = {50, 300},
Increment = 10,
Suffix = "Jump",
CurrentValue = 50,
Flag = "JumpSlider",
Callback = function(Value)
local plr = game.Players.LocalPlayer
local function applyJumpPower()
local hum = plr.Character and plr.Character:FindFirstChildOfClass("Humanoid")
if hum then
hum.UseJumpPower = true
hum.JumpPower = Value
end
end
applyJumpPower()
plr.CharacterAdded:Connect(function()
wait(0.5)
applyJumpPower()
end)
end,
})

PlayerTab:CreateButton({
Name = "TP Tool",
Callback = function()
local Tool = Instance.new("Tool")
Tool.Name = "Teleport Tool"
Tool.RequiresHandle = false
Tool.CanBeDropped = false

local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local connection

Tool.Equipped:Connect(function()
if connection then connection:Disconnect() end
connection = mouse.Button1Down:Connect(function()
local char = player.Character
local hrp = char and char:FindFirstChild("HumanoidRootPart")
if hrp then
hrp.CFrame = CFrame.new(mouse.Hit.Position + Vector3.new(0, 5, 0))
end
end)
end)

Tool.Unequipped:Connect(function()
if connection then connection:Disconnect() end
end)

Tool.Parent = player.Backpack
end,
})

PlayerTab:CreateButton({
Name = "Infinite Zoom",
Callback = function()
game.Players.LocalPlayer.CameraMaxZoomDistance = math.huge
end,
})

local MiscTab = Window:CreateTab("Misc", 4483362458)

MiscTab:CreateButton({
Name = "Infinite Yield",
Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
end,
})

-- Baseplate and Color Picker
local selectedColor = Color3.fromRGB(255, 255, 255)
local baseplate = nil

MiscTab:CreateToggle({
Name = "Custom Baseplate Toggle",
CurrentValue = false,
Flag = "BaseplateToggle",
Callback = function(Value)
if Value then
if not baseplate then
baseplate = Instance.new("Part")
baseplate.Size = Vector3.new(30000, 0, 30000)
baseplate.Anchored = true
baseplate.Position = Vector3.new(0, 0, 0)
baseplate.Color = selectedColor
baseplate.Material = Enum.Material.SmoothPlastic
baseplate.Name = "CustomBaseplate"
baseplate.Parent = workspace
else
baseplate.Parent = workspace
end
else
if baseplate then
baseplate.Parent = nil
end
end
end
})

MiscTab:CreateColorPicker({
Name = "Baseplate Color",
Flag = "BaseplateColor",
Color = selectedColor,
Callback = function(Color)
selectedColor = Color
end,
})

MiscTab:CreateButton({
Name = "Apply Baseplate Color",
Callback = function()
if baseplate then
baseplate.Color = selectedColor
end
end,
})

-- Spin
local spinSpeed = 10
local spinning = false

local function startSpinning()
spinning = true
task.spawn(function()
while spinning do
local character = game.Players.LocalPlayer.Character
if character and character:FindFirstChild("HumanoidRootPart") then
character.HumanoidRootPart.CFrame = character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(spinSpeed), 0)
end
task.wait(0.005)
end
end)
end

local function stopSpinning()
spinning = false
end

MiscTab:CreateToggle({
Name = "Spin",
CurrentValue = false,
Flag = "SpinToggle",
Callback = function(state)
if state then
startSpinning()
else
stopSpinning()
end
end
})

MiscTab:CreateSlider({
Name = "Spin Speed",
Range = {1, 200},
Increment = 1,
Suffix = "Speed",
CurrentValue = 10,
Flag = "SpinSpeedSlider",
Callback = function(Value)
spinSpeed = Value
end,
})
-- Teleports Tab
local TeleportsTab = Window:CreateTab("Teleports", 4483362458)

TeleportsTab:CreateInput({
    Name = "Teleport to Player",
    PlaceholderText = "Enter player display name",
    RemoveTextAfterFocusLost = true,
    Callback = function(displayName)
        local lowerInput = displayName:lower()
        for _, player in ipairs(game.Players:GetPlayers()) do
            if player.DisplayName:lower() == lowerInput then
                local char = player.Character
                local hrp = char and char:FindFirstChild("HumanoidRootPart")
                if hrp then
                    local myChar = game.Players.LocalPlayer.Character
                    local myHRP = myChar and myChar:FindFirstChild("HumanoidRootPart")
                    if myHRP then
                        myHRP.CFrame = hrp.CFrame
                        Rayfield:Notify({
                            Title = "Teleported!",
                            Content = "You were teleported to " .. player.DisplayName,
                            Duration = 5
                        })
                        return
                    end
                end
            end
        end

        Rayfield:Notify({
            Title = "Teleport Failed",
            Content = "Player not found or unavailable.",
            Duration = 5
        })
    end
})
