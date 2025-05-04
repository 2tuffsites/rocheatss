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
local LilScriptsTab = Window:CreateTab("Lil Scripts", 4483362458)

LilScriptsTab:CreateButton({
	Name = "HeadSit Toggle (Press H)",
	Callback = function()
		-- HeadSit script
		local Players = game:GetService("Players")
		local RunService = game:GetService("RunService")
		local UserInputService = game:GetService("UserInputService")

		local LocalPlayer = Players.LocalPlayer
		local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
		local HRP = Character:WaitForChild("HumanoidRootPart")

		local HeadSitConnection = nil
		local Attached = false

		local function getClosestPlayer()
			local closest, shortestDistance = nil, math.huge
			for _, player in ipairs(Players:GetPlayers()) do
				if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
					local head = player.Character.Head
					local distance = (HRP.Position - head.Position).Magnitude
					if distance < shortestDistance and distance <= 10 then -- within 10 studs
						closest = player
						shortestDistance = distance
					end
				end
			end
			return closest
		end

		UserInputService.InputBegan:Connect(function(input, processed)
			if processed then return end
			if input.KeyCode == Enum.KeyCode.H then
				if Attached then
					-- Detach
					if HeadSitConnection then HeadSitConnection:Disconnect() end
					HeadSitConnection = nil
					Attached = false
					warn("Detached from head.")
				else
					-- Attach
					local targetPlayer = getClosestPlayer()
					if not targetPlayer then
						warn("No player nearby.")
						return
					end

					local targetHead = targetPlayer.Character:FindFirstChild("Head")
					if not targetHead then return end

					Attached = true
					HeadSitConnection = RunService.Heartbeat:Connect(function()
						if HRP and targetHead then
							HRP.CFrame = targetHead.CFrame * CFrame.new(0, 1.5, 0)
						end
					end)
					warn("Attached to " .. targetPlayer.Name)
				end
			end
		end)
	end,
})
