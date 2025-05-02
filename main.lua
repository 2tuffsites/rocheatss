-- Existing Code for Menu GUI and Basic Setup (keep this part)

if game.CoreGui:FindFirstChild("2TuffCheats") then
    game.CoreGui["2TuffCheats"]:Destroy()
end

print("2TuffCheats loaded. Stay sharp.")

local UserInputService = game:GetService("UserInputService")
local gui = Instance.new("ScreenGui")
gui.Name = "2TuffCheats"
gui.Parent = game.CoreGui
gui.ResetOnSpawn = false

local frame = Instance.new("Frame")
frame.Name = "MainFrame"
frame.Size = UDim2.new(0, 500, 0, 400)
frame.Position = UDim2.new(0.5, -250, 0.5, -200)
frame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
frame.BorderSizePixel = 0
frame.Visible = true
frame.Parent = gui

local title = Instance.new("TextLabel")
title.Text = "2TuffCheats Menu"
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundColor3 = Color3.fromRGB(65, 105, 225)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.Parent = frame

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if input.KeyCode == Enum.KeyCode.K and not gameProcessed then
        frame.Visible = not frame.Visible
    end
end)

-- Password System
local password = "miners69"
local enteredPassword = ""
local passwordBox = Instance.new("TextBox")
passwordBox.Position = UDim2.new(0.5, -100, 0.5, -120)
passwordBox.Size = UDim2.new(0, 200, 0, 50)
passwordBox.Text = ""
passwordBox.PlaceholderText = "Enter Password"
passwordBox.TextColor3 = Color3.fromRGB(255, 255, 255)
passwordBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
passwordBox.Parent = frame

passwordBox.FocusLost:Connect(function(enterPressed)
    if enterPressed and passwordBox.Text == password then
        print("Password Correct!")
        passwordBox.Visible = false  -- Hide password box after entering correct password
    else
        print("Incorrect Password")
    end
end)

-- Teleport Tool
local teleportToolButton = Instance.new("TextButton")
teleportToolButton.Size = UDim2.new(0, 280, 0, 40)
teleportToolButton.Text = "Teleport Tool"
teleportToolButton.Font = Enum.Font.GothamBold
teleportToolButton.TextSize = 16
teleportToolButton.TextColor3 = Color3.fromRGB(255, 255, 255)
teleportToolButton.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
teleportToolButton.BorderSizePixel = 0
teleportToolButton.Parent = frame

teleportToolButton.MouseButton1Click:Connect(function()
    local tool = Instance.new("Tool")
    tool.Name = "TeleportTool"
    tool.RequiresHandle = false
    tool.Parent = game.Players.LocalPlayer.Backpack

    tool.Activated:Connect(function()
        local mouse = game.Players.LocalPlayer:GetMouse()
        local targetPos = mouse.Hit.p
        game.Players.LocalPlayer.Character:MoveTo(targetPos)
    end)
end)

-- Make Menu Moveable (dragging)
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

-- Close Button (Optional)
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 100, 0, 40)
closeButton.Position = UDim2.new(0.5, -50, 1, -50)
closeButton.Text = "Close"
closeButton.Font = Enum.Font.GothamBold
closeButton.TextSize = 16
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
closeButton.BorderSizePixel = 0
closeButton.Parent = frame

closeButton.MouseButton1Click:Connect(function()
    frame.Visible = false
end)


