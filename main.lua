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

-- TP Tool
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
         if connection then
            connection:Disconnect()
         end

         connection = mouse.Button1Down:Connect(function()
            local char = player.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if hrp then
               hrp.CFrame = CFrame.new(mouse.Hit.Position + Vector3.new(0, 5, 0))
            end
         end)
      end)

      Tool.Unequipped:Connect(function()
         if connection then
            connection:Disconnect()
            connection = nil
         end
      end)

      Tool.Parent = player.Backpack
   end,
})

-- Infinite Zoom
PlayerTab:CreateButton({
   Name = "Infinite Zoom",
   Callback = function()
      game.Players.LocalPlayer.CameraMaxZoomDistance = math.huge
   end,
})

-- Invisibility Toggle
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
         hrp.Parent = nil -- Server-invisible method
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

-- Infinite Yield Button (FE v6.3.1)
MiscTab:CreateButton({
   Name = "Infinite Yield",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
   end,
})
-- Flight Speed Slider
local flying = false
local flySpeed = 50
local UIS = game:GetService("UserInputService")

MiscTab:CreateSlider({
   Name = "Flight Speed",
   Range = {1, 500},
   Increment = 1,
   Suffix = "Speed",
   CurrentValue = 50,
   Flag = "FlightSpeedSlider",
   Callback = function(Value)
      flySpeed = Value
   end,
})

-- Flight logic
UIS.InputBegan:Connect(function(input, gpe)
   if gpe then return end
   if input.KeyCode == Enum.KeyCode.F then
      flying = not flying
      local player = game.Players.LocalPlayer
      local char = player.Character or player.CharacterAdded:Wait()
      local hrp = char:WaitForChild("HumanoidRootPart")
      local bodyVelocity = Instance.new("BodyVelocity")
      bodyVelocity.Name = "FlightVelocity"
      bodyVelocity.MaxForce = Vector3.new(1, 1, 1) * 1000000
      bodyVelocity.Velocity = Vector3.zero
      bodyVelocity.Parent = hrp

      if flying then
         task.spawn(function()
            while flying and char and hrp and hrp:FindFirstChild("FlightVelocity") do
               local direction = Vector3.zero
               if UIS:IsKeyDown(Enum.KeyCode.W) then direction += workspace.CurrentCamera.CFrame.LookVector end
               if UIS:IsKeyDown(Enum.KeyCode.S) then direction -= workspace.CurrentCamera.CFrame.LookVector end
               if UIS:IsKeyDown(Enum.KeyCode.A) then direction -= workspace.CurrentCamera.CFrame.RightVector end
               if UIS:IsKeyDown(Enum.KeyCode.D) then direction += workspace.CurrentCamera.CFrame.RightVector end
               if UIS:IsKeyDown(Enum.KeyCode.Space) then direction += Vector3.new(0, 1, 0) end
               if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then direction -= Vector3.new(0, 1, 0) end

               direction = direction.Unit * flySpeed
               bodyVelocity.Velocity = direction
               task.wait()
            end
         end)
      else
         if hrp:FindFirstChild("FlightVelocity") then
            hrp.FlightVelocity:Destroy()
         end
      end
   end
end)
