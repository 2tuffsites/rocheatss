if game.CoreGui:FindFirstChild("2TuffCheats") then game.CoreGui["2TuffCheats"]:Destroy() end

print("2TuffCheats loaded. Stay sharp.")

local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

-- GUI Setup
local gui = Instance.new("ScreenGui")
gui.Name = "2TuffCheats"
gui.Parent = game.CoreGui
gui.ResetOnSpawn = false

local frame = Instance.new("Frame")
frame.Name = "MainFrame"
frame.Size = UDim2.new(0, 300, 0, 200)
frame.Position = UDim2.new(0.5, -150, 0.5, -100)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Visible = true
frame.Parent = gui

-- Neon Blue Border
local border = Instance.new("UIStroke")
border.Color = Color3.fromRGB(0, 104, 255)
border.Parent = frame
border.Thickness = 3

local title = Instance.new("TextLabel")
title.Text = "2TuffCheats Menu"
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundColor3 = Color3.fromRGB(65, 105, 225)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.SourceSansSemibold
title.TextSize = 18
title.TextStrokeTransparency = 0.8
title.Parent = frame

-- Smooth Dragging Variables
local dragging = false
local dragInput, dragStart, startPos

frame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = frame.Position
	end
end)

frame.InputChanged:Connect(function(input)
	if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
		local delta = input.Position - dragStart
		frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)

frame.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end
end)

-- Pop-up Greeting
local greeting = Instance.new("TextLabel")
greeting.Text = "Welcome to 2TuffCheats!"
greeting.Size = UDim2.new(0, 280, 0, 40)
greeting.Position = UDim2.new(0, 10, 0, 50)
greeting.BackgroundTransparency = 1
greeting.TextColor3 = Color3.fromRGB(0, 104, 255)
greeting.Font = Enum.Font.GothamBold
greeting.TextSize = 18
greeting.TextStrokeTransparency = 0.8
greeting.Parent = frame

-- Tween animation for greeting
local greetingTween = TweenService:Create(greeting, TweenInfo.new(2, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, true), {TextTransparency = 0.5})
greetingTween:Play()

-- Close the Menu Smoothly
local function closeMenu()
	local closeTween = TweenService:Create(frame, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Position = UDim2.new(0.5, -150, 1, 0), Transparency = 1})
	closeTween:Play()
	wait(0.5)
	frame.Visible = false
end

-- Toggle visibility with K key
UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if input.KeyCode == Enum.KeyCode.K and not gameProcessed then
		if frame.Visible then
			closeMenu()
		else
			frame.Visible = true
			local openTween = TweenService:Create(frame, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Position = UDim2.new(0.5, -150, 0.5, -100), Transparency = 0})
			openTween:Play()
		end
	end
end)

