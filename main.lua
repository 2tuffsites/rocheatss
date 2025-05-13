local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
	Name = "2tuff Menu",
	Icon = nil,
	LoadingTitle = "fyi this ISNT a logger",
	LoadingSubtitle = "by luc",
	Theme = {
		TextColor = Color3.fromRGB(255, 0, 0),
		Background = Color3.fromRGB(0, 0, 0),
		Topbar = Color3.fromRGB(0, 0, 0),
		Shadow = Color3.fromRGB(0, 0, 0),
		NotificationBackground = Color3.fromRGB(0, 0, 0),
		NotificationActionsBackground = Color3.fromRGB(0, 0, 0),
		TabBackground = Color3.fromRGB(0, 0, 0),
		TabStroke = Color3.fromRGB(180, 180, 180),
		TabBackgroundSelected = Color3.fromRGB(0, 0, 0),
		TabTextColor = Color3.fromRGB(255, 0, 0),
		SelectedTabTextColor = Color3.fromRGB(0, 0, 0),
		ElementBackground = Color3.fromRGB(0, 0, 0),
		ElementBackgroundHover = Color3.fromRGB(0, 0, 0),
		SecondaryElementBackground = Color3.fromRGB(0, 0, 0),
		ElementStroke = Color3.fromRGB(0, 0, 0),
		SecondaryElementStroke = Color3.fromRGB(66, 0, 0),
		SliderBackground = Color3.fromRGB(0, 0, 0),
		SliderProgress = Color3.fromRGB(66, 0, 0),
		SliderStroke = Color3.fromRGB(66, 0, 0),
		ToggleBackground = Color3.fromRGB(0, 0, 0),
		ToggleEnabled = Color3.fromRGB(66, 0, 0),
		ToggleDisabled = Color3.fromRGB(180, 180, 180),
		ToggleEnabledStroke = Color3.fromRGB(66, 0, 0),
		ToggleDisabledStroke = Color3.fromRGB(150, 150, 150),
		ToggleEnabledOuterStroke = Color3.fromRGB(255, 0, 0),
		ToggleDisabledOuterStroke = Color3.fromRGB(120, 120, 120),
		DropdownSelected = Color3.fromRGB(0, 0, 0),
		DropdownUnselected = Color3.fromRGB(0, 0, 0),
		InputBackground = Color3.fromRGB(0, 0, 0),
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
		Key = {"lapolicias"}
	}
})

-- Player Tab
local PlayerTab = Window:CreateTab("Player", 4483362458)

PlayerTab:CreateSlider({
	Name = "Speed",
	Range = {16, 300},
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

local flying = false
local flyConn
local UIS = game:GetService("UserInputService")

-- Fly system (WASD only)
local flySpeed = 50

PlayerTab:CreateSlider({
	Name = "Fly Speed",
	Range = {20, 1000},
	Increment = 5,
	Suffix = "Speed",
	CurrentValue = 50,
	Flag = "FlySpeedSlider",
	Callback = function(Value)
		flySpeed = Value
	end,
})

-- Toggle Fly Function
local function toggleFly()
	local plr = game.Players.LocalPlayer
	local char = plr.Character or plr.CharacterAdded:Wait()
	local hrp = char:WaitForChild("HumanoidRootPart")

	if not flying then
		flying = true

		local bv = Instance.new("BodyVelocity")
		bv.Name = "FlyVelocity"
		bv.MaxForce = Vector3.new(1e9, 1e9, 1e9)
		bv.Velocity = Vector3.zero
		bv.Parent = hrp

		local bg = Instance.new("BodyGyro")
		bg.Name = "FlyGyro"
		bg.MaxTorque = Vector3.new(1e9, 1e9, 1e9)
		bg.CFrame = hrp.CFrame
		bg.Parent = hrp

		flyConn = game:GetService("RunService").RenderStepped:Connect(function()
			local moveVec = Vector3.zero
			local cam = workspace.CurrentCamera.CFrame

			if UIS:IsKeyDown(Enum.KeyCode.W) then moveVec += cam.LookVector end
			if UIS:IsKeyDown(Enum.KeyCode.S) then moveVec -= cam.LookVector end
			if UIS:IsKeyDown(Enum.KeyCode.A) then moveVec -= cam.RightVector end
			if UIS:IsKeyDown(Enum.KeyCode.D) then moveVec += cam.RightVector end

			bv.Velocity = moveVec.Magnitude > 0 and moveVec.Unit * flySpeed or Vector3.zero
			bg.CFrame = cam
		end)
	else
		flying = false
		if flyConn then flyConn:Disconnect() end
		local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
		if hrp then
			if hrp:FindFirstChild("FlyVelocity") then hrp.FlyVelocity:Destroy() end
			if hrp:FindFirstChild("FlyGyro") then hrp.FlyGyro:Destroy() end
		end
	end
end

UIS.InputBegan:Connect(function(input, processed)
	if not processed and input.KeyCode == Enum.KeyCode.F then
		toggleFly()
	end
end)

PlayerTab:CreateSlider({
	Name = "Jump Power",
	Range = {50, 300},
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
		Tool.Name = "Teleport Tool"
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
				baseplate.Size = Vector3.new(1000000, 0, 1000000)
				baseplate.Anchored = true
				baseplate.Position = Vector3.new(0, 0, 0)
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
	end
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

-- Spin Feature
local spinSpeed = 10
local spinning = false

local function startSpinning()
	spinning = true
	task.spawn(function()
		while spinning do
			local character = game.Players.LocalPlayer.Character
			if character and character:FindFirstChild("HumanoidRootPart") then
				character.HumanoidRootPart.CFrame = character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(spinSpeed), 0)
			end
			task.wait(0.005)
		end
	end)
end

local function stopSpinning()
	spinning = false
end

MiscTab:CreateToggle({
	Name = "Spin",
	CurrentValue = false,
	Flag = "SpinToggle",
	Callback = function(state)
		if state then
			startSpinning()
		else
			stopSpinning()
		end
	end
})

MiscTab:CreateSlider({
	Name = "Spin Speed",
	Range = {1, 200},
	Increment = 1,
	Suffix = "Speed",
	CurrentValue = 10,
	Flag = "SpinSpeedSlider",
	Callback = function(Value)
		spinSpeed = Value
	end,
})

MiscTab:CreateButton({
	Name = "Rejoin Server",
	Callback = function()
		local TeleportService = game:GetService("TeleportService")
		local Players = game:GetService("Players")
		local LocalPlayer = Players.LocalPlayer

		TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
	end,
})
local InvisTab = Window:CreateTab("Invis", 4483362458)

InvisTab:CreateParagraph({
	Title = "Invisibility",
	Content = "Press Q to toggle server-side invisibility. Others cannot see you."
local UIS = game:GetService("UserInputService")
local lp = game.Players.LocalPlayer
local char = lp.Character or lp.CharacterAdded:Wait()

local invis = false
local storedParts = {}

local function toggleInvis(state)
	local character = lp.Character
	if not character then return end

	for _, part in ipairs(character:GetDescendants()) do
		if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
			if state == true then
				storedParts[part] = {
					Transparency = part.Transparency,
					Parent = part.Parent
				}
				part:Destroy() -- server-side removal
			elseif storedParts[part] then
				local newPart = Instance.new("Part")
				newPart.Name = part.Name
				newPart.Size = part.Size
				newPart.CFrame = character.HumanoidRootPart.CFrame
				newPart.Anchored = false
				newPart.CanCollide = false
				newPart.Transparency = 0.7
				newPart.Material = Enum.Material.ForceField
				newPart.Parent = storedParts[part].Parent
			end
		elseif part:IsA("Decal") and state == true then
			part:Destroy()
		end
	end

	invis = state
end

UIS.InputBegan:Connect(function(input, gpe)
	if gpe or input.KeyCode ~= Enum.KeyCode.Q then return end
	if invis == false then
		toggleInvis(true)
	else
		lp:LoadCharacter() -- clean full restore
		invis = false
	end
end)
