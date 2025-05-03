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

-- TP Tool Button (Smooth TP)
PlayerTab:CreateButton({
   Name = "TP Tool",
   Callback = function()
      local TweenService = game:GetService("TweenService")
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
               local targetPos = mouse.Hit.Position + Vector3.new(0, 5, 0)
               local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
               local tween = TweenService:Create(hrp, tweenInfo, {CFrame = CFrame.new(targetPos)})
               tween:Play()
            end
         end)
      end)

      Tool.Unequipped:Connect(function()
         equipped = false
      end)

      Tool.Parent = game.Players.LocalPlayer.Backpack
   end,
})

-- Infinite Zoom Button
PlayerTab:CreateButton({
   Name = "Infinite Zoom",
   Callback = function()
      game.Players.LocalPlayer.CameraMaxZoomDistance = math.huge
   end,
})

-- Invisibility Toggle with R Keybind
local invisibleToggleEnabled = false
local isInvisible = false
local UserInputService = game:GetService("UserInputService")

local function makeInvisible()
   local character = game.Players.LocalPlayer.Character
   if not character then return end

   for _, part in ipairs(character:GetDescendants()) do
      if part:IsA("BasePart") then
         part.Transparency = 0.7
         part.CanCollide = false
      elseif part:IsA("Decal") or part:IsA("Texture") or part:IsA("Accessory") then
         part:Destroy()
      end
   end
   isInvisible = true
end

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

PlayerTab:CreateToggle({
   Name = "Invisible Toggle (Press R)",
   CurrentValue = false,
   Flag = "InvisibleToggle",
   Callback = function(Value)
      invisibleToggleEnabled = Value
   end,
})

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

MiscTab:CreateButton({
   Name = "Load Infinite Yield",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
   end,
})
