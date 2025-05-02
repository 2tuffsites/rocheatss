local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "2tuff cheats",
   Icon = 0,
   LoadingTitle = "cheats brah",
   LoadingSubtitle = "by luc",
   Theme = "Default",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil,
      FileName = "2tuff cheats"
   },
   KeySystem = true,
   KeySettings = {
      Title = "Untitled",
      Subtitle = "Key System",
      Note = "No method of obtaining the key is provided",
      FileName = "KeySystem",
      SaveKey = true,
      GrabKeyFromSite = false,
      Key = {"Rahh"}
   }
})

-- Player Tab
local PlayerTab = Window:CreateTab("Player", 4483362458)

-- ✅ Speed Slider
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

-- ✅ Jump Power Slider
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

-- ✅ TP Tool Button
PlayerTab:CreateButton({
   Name = "Give TP Tool",
   Callback = function()
      local Tool = Instance.new("Tool")
      Tool.Name = "TP Tool"
      Tool.RequiresHandle = false
      Tool.CanBeDropped = false

      local equipped = false

      Tool.Equipped:Connect(function()
         if equipped then return end
         equipped = true

         local mouse = game.Players.LocalPlayer:GetMouse()

         mouse.Button1Down:Connect(function()
            local char = game.Players.LocalPlayer.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if hrp then
               hrp.CFrame = CFrame.new(mouse.Hit.Position + Vector3.new(0, 5, 0))
            end
         end)
      end)

      Tool.Unequipped:Connect(function()
         equipped = false
      end)

      Tool.Parent = game.Players.LocalPlayer.Backpack
   end,
})

-- ✅ Teleport to Player Dropdown (No Auto-Update)
PlayerTab:CreateDropdown({
   Name = "Teleport To Player",
   Options = (function()
      local list = {}
      for _, p in ipairs(game.Players:GetPlayers()) do
         if p ~= game.Players.LocalPlayer then
            table.insert(list, p.Name)
         end
      end
      return list
   end)(),
   CurrentOption = nil,
   Flag = "TPDropdown",
   Callback = function(playerName)
      local plr = game.Players.LocalPlayer
      local target = game.Players:FindFirstChild(playerName)
      if not target then
         Rayfield:Notify({ Title = "Teleport Failed", Content = "Player not found.", Duration = 3 })
         return
      end

      local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
      local targetHRP = target.Character and target.Character:FindFirstChild("HumanoidRootPart")
      if hrp and targetHRP then
         hrp.CFrame = targetHRP.CFrame + Vector3.new(3, 0, 0)
      else
         Rayfield:Notify({ Title = "Teleport Failed", Content = "Character not ready.", Duration = 3 })
      end
   end,
})
local cameraZoomEnabled = false

PlayerTab:CreateButton({
   Name = "Infinite Camera Zoom",
   Callback = function()
      cameraZoomEnabled = not cameraZoomEnabled

      local camera = game.Workspace.CurrentCamera
      if cameraZoomEnabled then
         -- Enable infinite camera zoom
         camera.FieldOfView = 120  -- Set a very high FOV for zooming out effect
         camera.CameraType = Enum.CameraType.Scriptable
         camera.CFrame = camera.CFrame * CFrame.new(0, 0, -10000)  -- Move the camera far back
      else
         -- Restore normal camera behavior
         camera.CameraType = Enum.CameraType.Custom
         camera.FieldOfView = 70  -- Default FOV
      end
   end,
})


