local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "2tuff cheats",
   Icon = 0,
   LoadingTitle = "cheats brah",
   LoadingSubtitle = "by luc",
   Theme = "Dark Blue",

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
local Slider = PlayerTab:CreateSlider({
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

-- REJOIN VOICE CHAT BUTTON
PlayerTab:CreateButton({
   Name = "Rejoin Voice Chat",
   Callback = function()
      game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
   end,
})

-- TELEPORT TO PLAYER DROPDOWN
local TeleportDropdown = PlayerTab:CreateDropdown({
   Name = "Teleport To Player",
   Options = {},
   CurrentOption = nil,
   Flag = "TPDropdown",
   Callback = function(playerName)
      local target = game.Players:FindFirstChild(playerName)
      if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
         local hrp = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
         if hrp then
            hrp.CFrame = target.Character.HumanoidRootPart.CFrame + Vector3.new(2, 0, 2)
         end
      end
   end,
})

-- REFRESH PLAYER LIST FUNCTION
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
