if game.CoreGui:FindFirstChild("2TuffMenu") then
	game.CoreGui["2TuffMenu"]:Destroy()
end

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local StarterGui = game:GetService("StarterGui")
local TeleportService = game:GetService("TeleportService")
local UserInputService = game:GetService("UserInputService")

-- Password UI
local passwordGui = Instance.new("ScreenGui", game.CoreGui)
passwordGui.Name = "2TuffMenu"
passwordGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local passwordFrame = Instance.new("Frame", passwordGui)
passwordFrame.Size = UDim2.new(0, 300, 0, 150)
passwordFrame.Position = UDim2.new(0.5, -150, 0.5, -75)
passwordFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
passwordFrame.BorderSizePixel = 0
passwordFrame.Active = true
passwordFrame.Draggable = true

local passwordBox = Instance.new("TextBox", passwordFrame)
passwordBox.Size = UDim2.new(0.8, 0, 0, 40)
passwordBox.Position = UDim2.new(0.1, 0, 0.3, 0)
passwordBox.PlaceholderText = "Enter Password"
passwordBox.Text = ""
passwordBox.TextSize = 20
passwordBox.Font = Enum.Font.Gotham
passwordBox.TextColor3 = Color3.new(1, 1, 1)
passwordBox.BackgroundColor3 = Color3.fromRGB(35, 35, 45)

local submit = Instance.new("TextButton", passwordFrame)
submit.Size = UDim2.new(0.5, 0, 0, 30)
submit.Position = UDim2.new(0.25, 0, 0.7, 0)
submit.Text = "Submit"
submit.TextColor3 = Color3.new(1, 1, 1)
submit.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
submit.Font = Enum.Font.GothamBold
submit.TextSize = 16

-- Menu UI (initially hidden)
local mainGui = Instance.new("ScreenGui", game.CoreGui)
mainGui.Name = "MainMenu"
mainGui.Enabled = false

local mainFrame = Instance.new("Frame", mainGui)
mainFrame.Size = UDim2.new(0, 400, 0, 300)
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true

local titleLabel = Instance.new("TextLabel", mainFrame)
titleLabel.Size = UDim2.new(1, 0, 0, 40)
titleLabel.Text = "2Tuff Hub"
titleLabel.TextColor3 = Color3.fromRGB(0, 150, 255)
titleLabel.Font = Enum.Font.GothamSemibold
titleLabel.TextSize = 22
titleLabel.BackgroundColor3 = Color3.fromRGB(25, 25, 35)

-- TP TOOL BUTTON
local tpButton = Instance.new("TextButton", mainFrame)
tpButton.Size = UDim2.new(0.8, 0, 0, 40)
tpButton.Position = UDim2.new(0.1, 0, 0.3, 0)
tpButton.Text = "TP Tool"
tpButton.TextColor3 = Color3.fromRGB(255, 255, 255)
tpButton.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
tpButton.Font = Enum.Font.Gotham
tpButton.TextSize = 18

-- Rejoin Button
local rejoinButton = Instance.new("TextButton", mainFrame)
rejoinButton.Size = UDim2.new(0.8, 0, 0, 40)
rejoinButton.Position = UDim2.new(0.1, 0, 0.5, 0)
rejoinButton.Text = "Rejoin VC"
rejoinButton.TextColor3 = Color3.fromRGB(255, 255, 255)
rejoinButton.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
rejoinButton.Font = Enum.Font.Gotham
rejoinButton.TextSize = 18

-- Greeting
local greeting = Instance.new("TextLabel", mainGui)
greeting.Size = UDim2.new(0, 200, 0, 50)
greeting.Position = UDim2.new(0.5, -100, 0.2, 0)
greeting.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
greeting.TextColor3 = Color3.new(1, 1, 1)
greeting.Font = Enum.Font.GothamBold
greeting.TextSize = 20
greeting.Text = "Greetings slime."
greeting.Visible = false

-- Password Logic
submit.MouseButton1Click:Connect(function()
	if passwordBox.Text == "miners69" then
		passwordGui:Destroy()
		mainGui.Enabled = true
		greeting.Visible = true
		wait(2)
		greeting:TweenPosition(UDim2.new(0.5, -100, 0.1, 0), "Out", "Quad", 1)
		wait(1)
		greeting:Destroy()
	end
end)

-- Open/Close Menu With K
UserInputService.InputBegan:Connect(function(input, gp)
	if not gp and input.KeyCode == Enum.KeyCode.K then
		mainGui.Enabled = not mainGui.Enabled
	end
end)

-- TP Tool logic
tpButton.MouseButton1Click:Connect(function()
	if not LocalPlayer.Backpack:FindFirstChild("TP Tool") then
		local tool = Instance.new("Tool")
		tool.RequiresHandle = false
		tool.Name = "TP Tool"
		tool.Parent = LocalPlayer.Backpack

		tool.Activated:Connect(function()
			local mouse = LocalPlayer:GetMouse()
			if mouse then
				LocalPlayer.Character:MoveTo(mouse.Hit.Position)
			end
		end)
	end
end)

-- Rejoin VC
rejoinButton.MouseButton1Click:Connect(function()
	TeleportService:Teleport(game.PlaceId, LocalPlayer)
end)
