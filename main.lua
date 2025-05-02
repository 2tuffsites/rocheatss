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
-- Create the main UI Frame
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local menuFrame = Instance.new("Frame")
menuFrame.Parent = screenGui
menuFrame.Size = UDim2.new(0.5, 0, 0.7, 0)  -- 50% width, 70% height
menuFrame.Position = UDim2.new(0.25, 0, 0.15, 0)  -- Centered on screen
menuFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 255)  -- Royal blue
menuFrame.BackgroundTransparency = 0.2  -- Slight transparency
menuFrame.BorderRadius = UDim.new(0, 20)  -- Rounded corners
menuFrame.AnchorPoint = Vector2.new(0.5, 0.5)

-- Add a title label
local titleLabel = Instance.new("TextLabel")
titleLabel.Parent = menuFrame
titleLabel.Text = "2TuffCheats"
titleLabel.Size = UDim2.new(1, 0, 0.1, 0)
titleLabel.Position = UDim2.new(0, 0, 0, 0)
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)  -- White text
titleLabel.TextSize = 30
titleLabel.TextFont = Enum.Font.GothamBold
titleLabel.BackgroundTransparency = 1
titleLabel.TextStrokeTransparency = 0.6  -- Slight text stroke for better readability

-- Add a close button
local closeButton = Instance.new("TextButton")
closeButton.Parent = menuFrame
closeButton.Size = UDim2.new(0.2, 0, 0.1, 0)
closeButton.Position = UDim2.new(1, -30, 0, 10)  -- Top-right corner
closeButton.Text = "Close"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.TextSize = 20
closeButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)  -- Red background
closeButton.BorderRadius = UDim.new(0, 10)
closeButton.MouseButton1Click:Connect(function()
    screenGui:Destroy()  -- Close the menu when clicked
end)

-- Smooth transition effect (fade in the menu frame)
menuFrame.BackgroundTransparency = 1
game:GetService("TweenService"):Create(menuFrame, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 0.2}):Play()

-- Add a simple button (like for password input, teleport, or voice chat)
local sampleButton = Instance.new("TextButton")
sampleButton.Parent = menuFrame
sampleButton.Size = UDim2.new(0.8, 0, 0.1, 0)
sampleButton.Position = UDim2.new(0.1, 0, 0.2, 0)
sampleButton.Text = "Sample Feature"
sampleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
sampleButton.TextSize = 20
sampleButton.BackgroundColor3 = Color3.fromRGB(0, 0, 200)  -- Slightly darker blue for contrast
sampleButton.BorderRadius = UDim.new(0, 10)
sampleButton.MouseButton1Click:Connect(function()
    -- Add functionality here (like teleport or other features)
end)
-- Create the main UI Frame
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local menuFrame = Instance.new("Frame")
menuFrame.Parent = screenGui
menuFrame.Size = UDim2.new(0.5, 0, 0.7, 0)  -- 50% width, 70% height
menuFrame.Position = UDim2.new(0.25, 0, 0.15, 0)  -- Centered on screen
menuFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 255)  -- Royal blue
menuFrame.BackgroundTransparency = 0.2  -- Slight transparency
menuFrame.BorderRadius = UDim.new(0, 20)  -- Rounded corners
menuFrame.AnchorPoint = Vector2.new(0.5, 0.5)

-- Add a title label
local titleLabel = Instance.new("TextLabel")
titleLabel.Parent = menuFrame
titleLabel.Text = "2TuffCheats"
titleLabel.Size = UDim2.new(1, 0, 0.1, 0)
titleLabel.Position = UDim2.new(0, 0, 0, 0)
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)  -- White text
titleLabel.TextSize = 30
titleLabel.TextFont = Enum.Font.GothamBold
titleLabel.BackgroundTransparency = 1
titleLabel.TextStrokeTransparency = 0.6  -- Slight text stroke for better readability

-- Add a close button
local closeButton = Instance.new("TextButton")
closeButton.Parent = menuFrame
closeButton.Size = UDim2.new(0.2, 0, 0.1, 0)
closeButton.Position = UDim2.new(1, -30, 0, 10)  -- Top-right corner
closeButton.Text = "Close"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.TextSize = 20
closeButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)  -- Red background
closeButton.BorderRadius = UDim.new(0, 10)
closeButton.MouseButton1Click:Connect(function()
    screenGui:Destroy()  -- Close the menu when clicked
end)

-- Smooth transition effect (fade in the menu frame)
menuFrame.BackgroundTransparency = 1
game:GetService("TweenService"):Create(menuFrame, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 0.2}):Play()

-- Add a simple button (like for password input, teleport, or voice chat)
local sampleButton = Instance.new("TextButton")
sampleButton.Parent = menuFrame
sampleButton.Size = UDim2.new(0.8, 0, 0.1, 0)
sampleButton.Position = UDim2.new(0.1, 0, 0.2, 0)
sampleButton.Text = "Sample Feature"
sampleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
sampleButton.TextSize = 20
sampleButton.BackgroundColor3 = Color3.fromRGB(0, 0, 200)  -- Slightly darker blue for contrast
sampleButton.BorderRadius = UDim.new(0, 10)
sampleButton.MouseButton1Click:Connect(function()
    -- Add functionality here (like teleport or other features)
end)
-- Create the main UI Frame
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local menuFrame = Instance.new("Frame")
menuFrame.Parent = screenGui
menuFrame.Size = UDim2.new(0.5, 0, 0.7, 0)  -- 50% width, 70% height
menuFrame.Position = UDim2.new(0.25, 0, 0.15, 0)  -- Centered on screen
menuFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 255)  -- Royal blue
menuFrame.BackgroundTransparency = 0.2  -- Slight transparency
menuFrame.BorderRadius = UDim.new(0, 20)  -- Rounded corners
menuFrame.AnchorPoint = Vector2.new(0.5, 0.5)

-- Add a title label
local titleLabel = Instance.new("TextLabel")
titleLabel.Parent = menuFrame
titleLabel.Text = "2TuffCheats"
titleLabel.Size = UDim2.new(1, 0, 0.1, 0)
titleLabel.Position = UDim2.new(0, 0, 0, 0)
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)  -- White text
titleLabel.TextSize = 30
titleLabel.TextFont = Enum.Font.GothamBold
titleLabel.BackgroundTransparency = 1
titleLabel.TextStrokeTransparency = 0.6  -- Slight text stroke for better readability

-- Add a close button
local closeButton = Instance.new("TextButton")
closeButton.Parent = menuFrame
closeButton.Size = UDim2.new(0.2, 0, 0.1, 0)
closeButton.Position = UDim2.new(1, -30, 0, 10)  -- Top-right corner
closeButton.Text = "Close"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.TextSize = 20
closeButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)  -- Red background
closeButton.BorderRadius = UDim.new(0, 10)
closeButton.MouseButton1Click:Connect(function()
    screenGui:Destroy()  -- Close the menu when clicked
end)

-- Smooth transition effect (fade in the menu frame)
menuFrame.BackgroundTransparency = 1
game:GetService("TweenService"):Create(menuFrame, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 0.2}):Play()

-- Rejoin VC button
local rejoinVCButton = Instance.new("TextButton")
rejoinVCButton.Parent = menuFrame
rejoinVCButton.Size = UDim2.new(0.8, 0, 0.1, 0)
rejoinVCButton.Position = UDim2.new(0.1, 0, 0.2, 0)
rejoinVCButton.Text = "Rejoin Voice Chat"
rejoinVCButton.TextColor3 = Color3.fromRGB(255, 255, 255)
rejoinVCButton.TextSize = 20
rejoinVCButton.BackgroundColor3 = Color3.fromRGB(0, 0, 200)  -- Slightly darker blue for contrast
rejoinVCButton.BorderRadius = UDim.new(0, 10)
rejoinVCButton.MouseButton1Click:Connect(function()
    -- Add your code to rejoin VC here
end)

-- Teleport to Player button
local tpToPlayerButton = Instance.new("TextButton")
tpToPlayerButton.Parent = menuFrame
tpToPlayerButton.Size = UDim2.new(0.8, 0, 0.1, 0)
tpToPlayerButton.Position = UDim2.new(0.1, 0, 0.35, 0)  -- Below Rejoin VC button
tpToPlayerButton.Text = "Teleport to Player"
tpToPlayerButton.TextColor3 = Color3.fromRGB(255, 255, 255)
tpToPlayerButton.TextSize = 20
tpToPlayerButton.BackgroundColor3 = Color3.fromRGB(0, 0, 200)  -- Slightly darker blue for contrast
tpToPlayerButton.BorderRadius = UDim.new(0, 10)

tpToPlayerButton.MouseButton1Click:Connect(function()
    local playerList = game.Players:GetPlayers()
    local playerNames = {}
    for _, player in pairs(playerList) do
        table.insert(playerNames, player.Name)
    end

    -- Display list of players to teleport to
    local selectionBox = Instance.new("Frame")
    selectionBox.Parent = menuFrame
    selectionBox.Size = UDim2.new(0.8, 0, 0.3, 0)
    selectionBox.Position = UDim2.new(0.1, 0, 0.5, 0)
    selectionBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    selectionBox.BorderRadius = UDim.new(0, 10)
    
    local playerListUI = Instance.new("UIListLayout")
    playerListUI.Parent = selectionBox
    
    for _, name in pairs(playerNames) do
        local playerButton = Instance.new("TextButton")
        playerButton.Parent = selectionBox
        playerButton.Size = UDim2.new(1, 0, 0, 30)
        playerButton.Text = name
        playerButton.TextColor3 = Color3.fromRGB(0, 0, 0)
        playerButton.TextSize = 18
        playerButton.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
        playerButton.BorderRadius = UDim.new(0, 10)
        
        playerButton.MouseButton1Click:Connect(function()
            -- Teleport to selected player
            local selectedPlayer = game.Players:FindFirstChild(name)
            if selectedPlayer and selectedPlayer.Character then
                game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(selectedPlayer.Character.HumanoidRootPart.CFrame)
                selectionBox:Destroy()  -- Close the player list
            end
        end)
    end
end)


