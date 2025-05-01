if game.CoreGui:FindFirstChild("2TuffCheats") then
	game.CoreGui["2TuffCheats"]:Destroy()
end

print("2TuffCheats loaded. Stay sharp.")

local correctPassword = "password123" -- <<< CHANGE THIS
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- Password UI
local passwordGui = Instance.new("ScreenGui", game.CoreGui)
passwordGui.Name = "PasswordGui"
passwordGui.ResetOnSpawn = false

local passFrame = Instance.new("Frame", passwordGui)
passFrame.Size = UDim2.new(0, 400, 0, 180)
passFrame.Position = UDim2.new(0.5, -200, 0.5, -90)
passFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
passFrame.BorderSizePixel = 0

local passTitle = Instance.new("TextLabel", passFrame)
passTitle.Size = UDim2.new(1, 0, 0, 40)
passTitle.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
passTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
passTitle.Font = Enum.Font.GothamSemibold
passTitle.TextSize = 20
passTitle.Text = "Enter Password"

local inputBox = Instance.new("TextBox", passFrame)
inputBox.Size = UDim2.new(0.8, 0, 0, 40)
inputBox.Position = UDim2.new(0.1, 0, 0.4, 0)
inputBox.Text = ""
inputBox.TextSize = 18
inputBox.ClearTextOnFocus = true
inputBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
inputBox.TextColor3 = Color3.fromRGB(0, 0, 0)
inputBox.Font = Enum.Font.Gotham

local submitButton = Instance.new("TextButton", passFrame)
submitButton.Size = UDim2.new(0.5, 0, 0, 35)
submitButton.Position = UDim2.new(0.25, 0, 0.75, 0)
submitButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
submitButton.TextColor3 = Color3.fromRGB(255, 255, 255)
submitButton.Font = Enum.Font.Gotham
submitButton.TextSize = 18
submitButton.Text = "Submit"

-- Menu function
local function loadMenu()
	local gui = Instance.new("ScreenGui", game.CoreGui)
	gui.Name = "2TuffCheats"
	gui.ResetOnSpawn = false

	local frame = Instance.new("Frame", gui)
	frame.Name = "MainFrame"
	frame.Size = UDim2.new(0, 400, 0, 300)
	frame.Position = UDim2.new(0.5, -200, 0.5, -150)
	frame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
	frame.BorderSizePixel = 0

	local title = Instance.new("TextLabel", frame)
	title.Text = "2TuffCheats"
	title.Size = UDim2.new(1, 0, 0, 40)
	title.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
	title.TextColor3 = Color3.fromRGB(255, 255, 255)
	title.Font = Enum.Font.GothamSemibold
	title.TextSize = 22

	-- Welcome text
	local welcome = Instance.new("TextLabel", frame)
	welcome.Text = "Welcome to 2TuffCheats"
	welcome.Size = UDim2.new(1, 0, 0, 25)
	welcome.Position = UDim2.new(0, 0, 0, 40)
	welcome.BackgroundTransparency = 1
	welcome.TextColor3 = Color3.fromRGB(0, 150, 255)
	welcome.Font = Enum.Font.Gotham
	welcome.TextSize = 16

	task.delay(2, function()
		welcome:Destroy()
	end)

	-- Teleport tool
	local tpBtn = Instance.new("TextButton", frame)
	tpBtn.Text = "Teleport to Mouse"
	tpBtn.Size = UDim2.new(0.8, 0, 0, 40)
	tpBtn.Position = UDim2.new(0.1, 0, 0.6, 0)
	tpBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
	tpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	tpBtn.Font = Enum.Font.Gotham
	tpBtn.TextSize = 18

	tpBtn.MouseButton1Click:Connect(function()
		local char = LocalPlayer.Character
		if char and Mouse.Hit then
			char:MoveTo(Mouse.Hit.Position + Vector3.new(0, 3, 0))
		end
	end)

	-- Smooth drag
	local dragging, dragInput, dragStart, startPos
	local function update(input)
		local delta = input.Position - dragStart
		frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end

	frame.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			dragStart = input.Position
			startPos = frame.Position

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then dragging = false end
			end)
		end
	end)

	frame.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement then
			dragInput = input
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			update(input)
		end
	end)

	-- Hide/Show menu
	local visible = true
	UserInputService.InputBegan:Connect(function(input, processed)
		if not processed and input.KeyCode == Enum.KeyCode.K then
			local goal = {}
			goal.Position = visible and UDim2.new(0.5, -200, 1, 0) or UDim2.new(0.5, -200, 0.5, -150)
			TweenService:Create(frame, TweenInfo.new(0.5, Enum.EasingStyle.Quad), goal):Play()
			visible = not visible
		end
	end)
end

-- Submit logic
submitButton.MouseButton1Click:Connect(function()
	if inputBox.Text == correctPassword then
		passwordGui:Destroy()
		loadMenu()
	else
		inputBox.Text = ""
	end
end)

