local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "2tuff cheats",
   Icon = 0,
   LoadingTitle = "cheats brah",
   LoadingSubtitle = "by luc",
   Theme = "Default",

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false,

   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil,
      FileName = "2tuff cheats"
   },

   Discord = {
      Enabled = false,
      Invite = "noinvitelink",
      RememberJoins = true
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

-- PLAYER TAB
local PlayerTab = Window:CreateTab("Player", 4483362458)

-- ✅ SPEED SLIDER
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

-- ✅ JUMP POWER SLIDER (fixed)
PlayerTab:CreateSlider({
   Name = "Jump Power",
   Range = {50, 500},
   Increment = 10,
   Suffix = "Jump",
   CurrentValue = 50,
   Flag = "JumpSlider",
   Callback = function(Value)
      local hum = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
      if hum then
         hum.UseJumpPower = true
         hum.JumpPower = Value
      end
   end,
})

-- ✅ TELEPORT TO PLAYER (Fixed)
local TeleportDropdown
TeleportDropdown = PlayerTab:CreateDropdown({
   Name = "Teleport To Player",
   Options = {},
   CurrentOption = nil,
   Flag = "TPDropdown",
   Callback = function(playerName)
      local target = game.Players:FindFirstChild(playerName)
      if not target then
         Rayfield:Notify({ Title = "Teleport Failed", Content = "Player not found.", Duration = 3 })
         return
      end

      local success, err = pcall(function()
         local targetHRP = target.Character:WaitForChild("HumanoidRootPart", 3)
         local myHRP = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
         if targetHRP and myHRP then
            myHRP.CFrame = targetHRP.CFrame + Vector3.new(3, 0, 0)
         else
            Rayfield:Notify({ Title = "Teleport Failed", Content = "Target or self not fully loaded.", Duration = 3 })
         end
      end)

      if not success then
         Rayfield:Notify({ Title = "Teleport Error", Content = err, Duration = 3 })
      end
   end,
})

-- ✅ UPDATE PLAYER LIST
local function updatePlayerList()
   local names = {}
   for _, player in ipairs(game.Players:GetPlayers()) do
      if player ~= game.Players.LocalPlayer then
         table.insert(names, player.Name)
      end
   end
   if TeleportDropdown then
      TeleportDropdown:Refresh(names, true)
   end
end

updatePlayerList()
game.Players.PlayerAdded:Connect(updatePlayerList)
game.Players.PlayerRemoving:Connect(updatePlayerList)

-- ✅ GIVE TP TOOL BUTTON
PlayerTab:CreateButton({
   Name = "Give TP Tool",
   Callback = function()
      local Tool = Instance.new("Tool")
      Tool.Name = "TP Tool"
      Tool.RequiresHandle = false
      Tool.CanBeDropped = false

      Tool.Activated:Connect(function()
         local mouse = game.Players.LocalPlayer:GetMouse()
         local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
         if hrp and mouse then
            local pos = mouse.Hit.Position
            hrp.CFrame = CFrame.new(pos + Vector3.new(0, 5, 0))
         end
      end)

      Tool.Parent = game.Players.LocalPlayer.Backpack
   end,
})
-- ✅ JUMP POWER SLIDER (working fix)
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

      -- Handle character reset
      plr.CharacterAdded:Connect(function()
         wait(0.5)
         applyJumpPower()
      end)
   end,
})

-- ✅ TP TOOL BUTTON (fully working version)
PlayerTab:CreateButton({
   Name = "TP Tool",
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
