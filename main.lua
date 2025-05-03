local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "2tuff Menu",
   Icon = 0,
   LoadingTitle = "Hey! no cheating!{jokin}",
   LoadingSubtitle = "by luc",
   Theme = {
      TextColor = Color3.fromRGB(0, 102, 204), -- Royal blue text
      Background = Color3.fromRGB(255, 255, 255), -- White background
      Topbar = Color3.fromRGB(0, 102, 204), -- Royal blue topbar
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
      Key = {"Rahh"}
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

local UserInputService = game:GetService("UserInputService")
local LocalPlayer = game.Players.LocalPlayer
local isInvisible = false
local invisibilityEnabled = false
local originalHRPParent = nil

PlayerTab:CreateToggle({
   Name = "Invisible Toggle (Press R)",
   CurrentValue = false,
   Flag = "InvisibleToggle",
   Callback = function(Value)
      invisibilityEnabled = Value
   end,
})

UserInputService.InputBegan:Connect(function(input, gameProcessed)
   if gameProcessed then return end
   if input.KeyCode == Enum.KeyCode.R and invisibilityEnabled then
      local char = LocalPlayer.Character
      if not char then return end
      local hrp = char:FindFirstChild("HumanoidRootPart")
      if not hrp then return end

      if not isInvisible then
         originalHRPParent = hrp.Parent
         hrp.Parent = nil
         for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") then
               part.Transparency = 0.7
            elseif part:IsA("Decal") or part:IsA("Texture") then
               part:Destroy()
            end
         end
         isInvisible = true
      else
         if originalHRPParent then
            hrp.Parent = originalHRPParent
         end
         for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") then
               part.Transparency = 0
            end
         end
         isInvisible = false
      end
   end
end)

-- Misc Tab
local MiscTab = Window:CreateTab("Misc", 4483362458)

MiscTab:CreateButton({
   Name = "Infinite Yield",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
   end,
})
