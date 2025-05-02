local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "2tuff cheats",
   Icon = 0,
   LoadingTitle = "cheats brah",
   LoadingSubtitle = "by luc",
   Theme = "RoyalBlue", -- ✅ Theme correctly set

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
      local humanoid = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
      if humanoid then
         humanoid.WalkSpeed = Value
      end
   end,
})

-- ✅ JUMP POWER SLIDER
PlayerTab:CreateSlider({
   Name = "Jump Power",
   Range = {50, 500},
   Increment = 10,
   Suffix = "Jump",
   CurrentValue = 50,
   Flag = "JumpSlider",
   Callback = function(Value)
      local humanoid = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
      if humanoid then
         humanoid.JumpPower = Value
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
      if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
         local myChar = game.Players.LocalPlayer.Character
         if myChar and myChar:FindFirstChild("HumanoidRootPart") then
            myChar.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame + Vector3.new(3, 0, 0)
         end
      else
         Rayfield:Notify({
            Title = "Teleport Failed",
            Content = "Player not found or not fully loaded.",
            Duration = 3
         })
      end
   end,
})

-- ✅ UPDATE PLAYER LIST DYNAMICALLY
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
