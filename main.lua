local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "2tuff Menu",
   Icon = nil,
   LoadingTitle = "Hey! no cheating!{jokin}",
   LoadingSubtitle = "by luc",
   Theme = {
      TextColor = Color3.fromRGB(0, 102, 204),
      Background = Color3.fromRGB(255, 255, 255),
      Topbar = Color3.fromRGB(255, 255, 255),
      Shadow = Color3.fromRGB(200, 200, 200),
      NotificationBackground = Color3.fromRGB(230, 230, 230),
      NotificationActionsBackground = Color3.fromRGB(255, 255, 255),
      TabBackground = Color3.fromRGB(220, 220, 220),
      TabStroke = Color3.fromRGB(180, 180, 180),
      TabBackgroundSelected = Color3.fromRGB(255, 255, 255),
      TabTextColor = Color3.fromRGB(0, 102, 204),
      SelectedTabTextColor = Color3.fromRGB(255, 255, 255),
      ElementBackground = Color3.fromRGB(245, 245, 245),
      ElementBackgroundHover = Color3.fromRGB(240, 240, 240),
      SecondaryElementBackground = Color3.fromRGB(230, 230, 230),
      ElementStroke = Color3.fromRGB(200, 200, 200),
      SecondaryElementStroke = Color3.fromRGB(180, 180, 180),
      SliderBackground = Color3.fromRGB(255, 255, 255),
      SliderProgress = Color3.fromRGB(0, 102, 204),
      SliderStroke = Color3.fromRGB(0, 102, 204),
      ToggleBackground = Color3.fromRGB(240, 240, 240),
      ToggleEnabled = Color3.fromRGB(0, 102, 204),
      ToggleDisabled = Color3.fromRGB(180, 180, 180),
      ToggleEnabledStroke = Color3.fromRGB(0, 102, 204),
      ToggleDisabledStroke = Color3.fromRGB(150, 150, 150),
      ToggleEnabledOuterStroke = Color3.fromRGB(0, 102, 204),
      ToggleDisabledOuterStroke = Color3.fromRGB(120, 120, 120),
      DropdownSelected = Color3.fromRGB(250, 250, 250),
      DropdownUnselected = Color3.fromRGB(240, 240, 240),
      InputBackground = Color3.fromRGB(255, 255, 255),
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

-- Player Tab
local PlayerTab = Window:CreateTab("Player", 4483362458)

PlayerTab:CreateSlider({
   Name = "Speed",
   Range = {16, 500},
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
   Range = {50, 500},
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
      Tool.Name = "TP Tool"
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

-- Misc Tab
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
            baseplate.Size = Vector3.new(10000, 0, 10000)
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
   end,
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

-- Spin Toggle and Speed Slider
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
   end,
})

MiscTab:CreateSlider({
   Name = "Spin Speed",
   Range = {1, 100},
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

local TpDropdown = TeleportsTab:CreateDropdown({
    Name = "Teleport Locations",
    Options = {
        "Spawn 1", "Spawn 2", "Spawn 3", "Circle Booth", "Avatar-UI", "Private Room (Inside)",
        "Bathrooms", "Chill Spot", "Picnic", "Middle Room (Tent)", "Tower (Float Up Part)",
        "Tower (Top)", "Tower (Highest Part)", "Donut Shop", "Above Relaxing Room", "Note Board"
    },
    CurrentOption = "Spawn 1",
    Flag = "TpDropdown"
})

local locations = {
    ["Spawn 1"] = CFrame.new(-0.000122070313, 4.99999857, 0.000122070313),
    ["Spawn 2"] = CFrame.new(166.64, 4.99999857, 195.381),
    ["Spawn 3"] = CFrame.new(143.6, 4.99999857, -33.09),
    ["Circle Booth"] = CFrame.new(26.7397423, 7.81395245, 86.7164536),
    ["Avatar-UI"] = CFrame.new(-129, 4.9, 82),
    ["Private Room (Inside)"] = CFrame.new(4220.82275, 2.76511836, 60.7681046),
    ["Bathrooms"] = CFrame.new(-72.3955917, 5.09832525, 93.0914459),
    ["Chill Spot"] = CFrame.new(228.970184, 5.75081444, -21.5613441),
    ["Picnic"] = CFrame.new(85.846756, 3.61196709, -29.8345909),
    ["Middle Room (Tent)"] = CFrame.new(70.9464493, 5.62692404, 24.2968006),
    ["Tower (Float Up Part)"] = CFrame.new(61.3288841, 72.0192184, 215.731613),
    ["Tower (Top)"] = CFrame.new(63.2298126, 284.407227, 193.529007),
    ["Tower (Highest Part)"] = CFrame.new(58.0468788, 313.312622, 225.215027),
    ["Donut Shop"] = CFrame.new(-80.8301239, 3.1662631, -82.6656799),
    ["Above Relaxing Room"] = CFrame.new(-97.4412308, 24.4840164, 121.394676),
    ["Note Board"] = CFrame.new(58.6107864, 4.99999857, 245.690369)
}

TeleportsTab:CreateButton({
    Name = "Teleport",
    Callback = function()
        local selectedLocation = TpDropdown.Value
        local targetCFrame = locations[selectedLocation]
        if targetCFrame then
            local char = game.Players.LocalPlayer.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if hrp then
                hrp.CFrame = targetCFrame
            end
        else
            warn("Invalid location selected")
        end
    end
})
