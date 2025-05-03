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

-- Jump Power Slider
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

-- TP Tool (Instant TP)
PlayerTab:CreateButton({
   Name = "teleport tool",
   Callback = function()
      local Tool = Instance.new("Tool")
      Tool.Name = "Teleport tool"
      Tool.RequiresHandle = false
      Tool.CanBeDropped = false

      Tool.Equipped:Connect(function()
         local mouse = game.Players.LocalPlayer:GetMouse()
         mouse.Button1Down:Connect(function()
            local char = game.Players.LocalPlayer.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if hrp then
               hrp.CFrame = CFrame.new(mouse.Hit.Position + Vector3.new(0, 5, 0))
            end
         end)
      end)

      Tool.Parent = game.Players.LocalPlayer.Backpack
   end,
})

-- Infinite Zoom
PlayerTab:CreateButton({
   Name = "Infinite Zoom",
   Callback = function()
      game.Players.LocalPlayer.CameraMaxZoomDistance = math.huge
   end,
})

-- Invisibility Toggle (R key)
local invisibleToggleEnabled = false
local isInvisible = false
local UserInputService = game:GetService("UserInputService")

-- Invisibility Functions
local function makeInvisible()
   local character = game.Players.LocalPlayer.Character
   if not character then return end

   for _, item in ipairs(character:GetDescendants()) do
      if item:IsA("BasePart") then
         item.Transparency = 0.7
         item.CanCollide = false
         if item:FindFirstChild("OriginalColor") == nil then
            local value = Instance.new("Color3Value", item)
            value.Name = "OriginalColor"
            value.Value = item.Color
         end
      elseif item:IsA("Decal") or item:IsA("Texture") or item:IsA("Accessory") then
         item:Destroy()
      end
   end
   isInvisible = true
end

local function makeVisible()
   local character = game.Players.LocalPlayer.Character
   if not character then return end

   for _, item in ipairs(character:GetDescendants()) do
      if item:IsA("BasePart") then
         item.Transparency = 0
         item.CanCollide = true
         if item:FindFirstChild("OriginalColor") then
            item.Color = item.OriginalColor.Value
            item.OriginalColor:Destroy()
         end
      end
   end
   isInvisible = false
end

-- Rayfield Toggle
PlayerTab:CreateToggle({
   Name = "Invisible Toggle (Press R)",
   CurrentValue = false,
   Flag = "InvisibleToggle",
   Callback = function(Value)
      invisibleToggleEnabled = Value
   end,
})

-- Keybind Handling
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

-- Misc Tab
local MiscTab = Window:CreateTab("Misc", 4483362458)

-- Infinite Yield Loader Button (FE v6.3.1)
MiscTab:CreateButton({
   Name = "Load Infinite Yield FE v6.3.1",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
   end,
})
