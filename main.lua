local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "2tuff cheats",
   Icon = 0,
   LoadingTitle = "cheats brah",
   LoadingSubtitle = "by luc",
   Theme = "RoyalBlue", -- Changed theme here

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

-- SPEED SLIDER
PlayerTab:CreateSlider({
   Name = "Speed",
   Range = {16, 500},
   Increment = 1,
   Suffix = "Speed",
   CurrentValue = 16,
   Flag = "Slider1",
   Callback = function(Value)
      local char = game.Players.LocalPlayer.Character
      if char and char:FindFirstChild("Humanoid") then
         char.Humanoid.WalkSpeed = Value
      end
   end,
})

-- JUMP POWER SLIDER
PlayerTab:CreateSlider({
   Name = "Jump Power",
   Range = {50, 500},
   Increment = 5,
   Suffix = "Jump",
   CurrentValue = 50,
   Flag = "JumpSlider",
   Callback = function(Value)
      local char = game.Players.LocalPlayer.Character
      if char and char:FindFirstChild("Humanoid") then
         char.Humanoid.JumpPower = Value
      end
   end,
})

-- TELEPORT TO PLAYER DROPDOWN
local playerToTeleportTo = nil

local TeleportDropdown = PlayerTab:CreateDropdown({
   Name = "Teleport To Player",
   Options = {},
   CurrentOption = nil,
   Flag = "TPDropdown",
   Callback = function(selectedName)
      playerToTeleportTo = selectedName
      local target = game.Players:FindFirstChild(selectedName)
      if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
         local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
         if hrp then
            hrp.CFrame = target.Character.HumanoidRootPart.CFrame + Vector3.new(2, 0, 2)
         end
      else
         Rayfield:Notify({
            Title = "Teleport Failed",
            Content = "Player not found or missing character.",
            Duration = 3
         })
      end
   end,
})

-- DYNAMIC PLAYER LIST UPDATER
local function updatePlayers()
   local names = {}
   for _, player in pairs(game.Players:GetPlayers()) do
      if player ~= game.Players.LocalPlayer then
         table.insert(names, player.Name)
      end
   end
   TeleportDropdown:Refresh(names, true)
end

updatePlayers()
game.Players.PlayerAdded:Connect(updatePlayers)
game.Players.PlayerRemoving:Connect(updatePlayers)
