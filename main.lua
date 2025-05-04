local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "2tuff Menu",
   Icon = nil, -- Fixed from 0 to nil
   LoadingTitle = "Hey! no cheating!{jokin}",
   LoadingSubtitle = "by luc",
   Theme = {
      TextColor = Color3.fromRGB(0, 102, 204), -- Royal blue text
      Background = Color3.fromRGB(255, 255, 255), -- White background
      Topbar = Color3.fromRGB(255, 255, 255), -- White topbar
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
            baseplate.Position = Vector3.new(0, 1, 0)
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
-- Visuals Tab
-- Visuals Tab
local VisualsTab = Window:CreateTab("Visuals", 4483362458)

VisualsTab:CreateButton({
   Name = "Black Void",
   Callback = function()
      local lighting = game:GetService("Lighting")
      
      -- Set up the black skybox
      lighting.Sky.SkyboxBk = "rbxassetid://0"  -- Black
      lighting.Sky.SkyboxDn = "rbxassetid://0"  -- Black
      lighting.Sky.SkyboxFt = "rbxassetid://0"  -- Black
      lighting.Sky.SkyboxLf = "rbxassetid://0"  -- Black
      lighting.Sky.SkyboxRt = "rbxassetid://0"  -- Black
      lighting.Sky.SkyboxUp = "rbxassetid://0"  -- Black
      
      -- Set the ambient and other settings to make the environment appear black
      lighting.Ambient = Color3.fromRGB(0, 0, 0)
      lighting.OutdoorAmbient = Color3.fromRGB(0, 0, 0)
   end,
})
-- Add "Lil Scripts" Tab to the UI
local LilScriptsTab = Window:CreateTab("Lil Scripts", 4483362458)

-- Add the "Jerk Off" script as a button inside the "Lil Scripts" tab
LilScriptsTab:CreateButton({
   Name = "Activate Jerk Off Script",
   Callback = function()
      local JerkOffSpeed = getgenv().JERK_OFF_SPEED
      local KeepOnDeath = getgenv().KEEP_ON_DEATH

      --// player defintion
      local Player = game.Players.LocalPlayer
      local Character = Player.Character or Player.CharacterAdded:Wait()
      local Humanoid = Character:WaitForChild("Humanoid", 1)
      local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart", 1) or Character.PrimaryPart

      --// check if not R6
      if not Character:FindFirstChild("Torso") then
          warn("Must be R6")
          return
      end

      --// check if already executed
      if getgenv().JerkOffExecuted then
          warn("Already executed")
          return
      end

      getgenv().JerkOffExecuted = true

      --// the animations of the script
      local MAIN_ANIMATIONS = {
          JERK_OFF = "rbxassetid://99198989",
          CLOSER_HANDS = "rbxassetid://168086975",
      }

      --// this is a boolean named "JerkingOff"🤯
      local JerkingOff = false

      --// making the tool in 
      local JerkTool = Instance.new("Tool")
      JerkTool.Name = "Jerk Off"
      JerkTool.RequiresHandle = false
      JerkTool.Parent = game:GetService("ReplicatedStorage")

      --// on respawn
      Player.CharacterAdded:Connect(function()
          --// redefine character on respawn
          Character = Player.Character
          Humanoid = Character:WaitForChild("Humanoid", 1)
          HumanoidRootPart = Character:WaitForChild("HumanoidRootPart", 1) or Character.PrimaryPart

          --// tool give
          if KeepOnDeath then
              --// clones the tool from replicatedStorage
              local new_tool = JerkTool:Clone()
              new_tool.Parent = Player.Backpack
              
              --// set JerkingOff to true or false based on if it's equipped
              new_tool.Equipped:Connect(function()
                  JerkingOff = true
              end)

              new_tool.Unequipped:Connect(function()
                  JerkingOff = false
              end)
          end

          --// disable on death
          Humanoid.Died:Connect(function()
              JerkingOff = false
              if not KeepOnDeath then
                  getgenv().JerkOffExecuted = false
              end
          end)
      end)

      --// give on execute
      local new_tool = JerkTool:Clone()
      new_tool.Parent = Player.Backpack

      --// set JerkingOff to true or false based on if it's equipped
      new_tool.Equipped:Connect(function()
          JerkingOff = true
      end)

      new_tool.Unequipped:Connect(function()
          JerkingOff = false
      end)

      --// disable on death
      Humanoid.Died:Connect(function()
          JerkingOff = false
          if not KeepOnDeath then
              getgenv().JerkOffExecuted = false
          end
      end)

      --// main loop
      local jerkoffTrack
      local closerhandsTrack
      local setToOriginalValues = true

      game:GetService("RunService").RenderStepped:Connect(function()
          if not Humanoid then
              return --// exit if Humanoid is not defined
          end
          if JerkingOff then
              setToOriginalValues = true
              Humanoid.WalkSpeed = 0 --// set walk speed to 0 while jerking off
              Humanoid.JumpPower = 0 --// set jump power to 0 while jerking off

              --// check if jerkoffTrack is not playing
              if not jerkoffTrack then
                  local anim = Instance.new("Animation")
                  anim.AnimationId = MAIN_ANIMATIONS.JERK_OFF
                  jerkoffTrack = Humanoid:LoadAnimation(anim)
                  jerkoffTrack.Looped = true
                  jerkoffTrack:Play()
                  jerkoffTrack:AdjustSpeed(JerkOffSpeed)
              end
            
              --// check if closerhandsTrack is not playing
              if not closerhandsTrack then
                  local anim = Instance.new("Animation")
                  anim.AnimationId = MAIN_ANIMATIONS.CLOSER_HANDS
                  closerhandsTrack = Humanoid:LoadAnimation(anim)
                  closerhandsTrack:Play()
                  closerhandsTrack:AdjustSpeed(JerkOffSpeed)
              end
          elseif setToOriginalValues then
              setToOriginalValues = false
              Humanoid.WalkSpeed = 16 --// reset walk speed
              Humanoid.JumpPower = 50 --// reset jump power
              --// stop animations if they are playing
              if jerkoffTrack then
                  jerkoffTrack:Stop()
                  jerkoffTrack = nil
              end
              if closerhandsTrack then
                  closerhandsTrack:Stop()
                  closerhandsTrack = nil
              end
          end
      end)
   end,
})
