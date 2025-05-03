local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "2tuff cheats",
   Icon = 0,
   LoadingTitle = "cheats brah",
   LoadingSubtitle = "by luc",
   Theme = "Dark Blue",
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

-- Speed Slider
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

-- Give TP Tool
PlayerTab:CreateButton({
   Name = "TP Tool",
   Callback = function()
      local Tool = Instance.new("Tool")
      Tool.Name = "teleport tool"
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
local tpDropdown = PlayerTab:CreateDropdown({
   Name = "Teleport To Player",
   Options = {},
   CurrentOption = nil,
   Flag = "TPDropdown",
   Callback = function(playerName)
      local localPlr = game.Players.LocalPlayer
      local target = game.Players:FindFirstChild(playerName)

      if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
         local hrp = localPlr.Character and localPlr.Character:FindFirstChild("HumanoidRootPart")
         if hrp then
            hrp.CFrame = target.Character.HumanoidRootPart.CFrame + Vector3.new(3, 0, 0)
         else
            Rayfield:Notify({
               Title = "Teleport Failed",
               Content = "Your character isn't ready.",
               Duration = 3
            })
         end
      else
         Rayfield:Notify({
            Title = "Teleport Failed",
            Content = "Target player not available.",
            Duration = 3
         })
      end
   end
})
local function updatePlayerList()
   local list = {}
   for _, p in ipairs(game.Players:GetPlayers()) do
      if p ~= game.Players.LocalPlayer then
         table.insert(list, p.Name)
      end
   end
   tpDropdown:SetOptions(list)
end

game.Players.PlayerAdded:Connect(updatePlayerList)
game.Players.PlayerRemoving:Connect(updatePlayerList)
updatePlayerList()

PlayerTab:CreateButton({
   Name = "Infinite Zoom",
   Callback = function()
      game.Players.LocalPlayer.CameraMaxZoomDistance = math.huge
   end,
})
local invisibleToggleEnabled = false
local isInvisible = false
local UserInputService = game:GetService("UserInputService")

-- Make the player invisible to others and see-through to self
local function makeInvisible()
   local character = game.Players.LocalPlayer.Character
   if not character then return end

   for _, part in ipairs(character:GetDescendants()) do
      if part:IsA("BasePart") then
         part.Transparency = 0.7 -- You can still see yourself
         part.CanCollide = false
      elseif part:IsA("Decal") or part:IsA("Texture") or part:IsA("Accessory") then
         part:Destroy()
      end
   end
   isInvisible = true
end

-- Restore visibility
local function makeVisible()
   local character = game.Players.LocalPlayer.Character
   if not character then return end

   for _, part in ipairs(character:GetDescendants()) do
      if part:IsA("BasePart") then
         part.Transparency = 0
         part.CanCollide = true
      end
   end
   isInvisible = false
end

-- Rayfield toggle to enable/disable invisibility mode
PlayerTab:CreateToggle({
   Name = "Invisible Toggle (Press R)",
   CurrentValue = false,
   Flag = "InvisibleToggle",
   Callback = function(Value)
      invisibleToggleEnabled = Value
   end,
})

-- Keybind logic to switch invisibility on/off
UserInputService.InputBegan:Connect(function(input, gameProcessed)
   if gameProcessed then return end
   if input.KeyCode == Enum.KeyCode.R and invisibleToggleEnabled then
      if isInvisible then
         makeVisible()
      else
         makeInvisible()
      end
   end
end)
-- ✅ Misc Tab
local MiscTab = Window:CreateTab("Misc", 4483362458)

-- ✅ Infinite Yield Loader Button
MiscTab:CreateButton({
   Name = "Load Infinite Yield",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
   end,
})
