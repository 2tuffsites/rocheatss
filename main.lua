if game.CoreGui:FindFirstChild("2TuffCheats") then
    game.CoreGui["2TuffCheats"]:Destroy()
end

print("2TuffCheats loaded. Stay sharp.")

local UserInputService = game:GetService("UserInputService")

-- GUI Setup
local gui = Instance.new("ScreenGui")
gui.Name = "2TuffCheats"
gui.Parent = game.CoreGui
gui.ResetOnSpawn = false

local frame = Instance.new("Frame")
frame.Name = "MainFrame"
frame.Size = UDim2.new(0, 400, 0, 300)  -- Bigger size
frame.Position = UDim2.new(0.5, -200, 0.5, -150)
frame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
frame.BorderSizePixel = 0
frame.Visible = true
frame.Parent = gui
frame.AnchorPoint = Vector2.new(0.5, 0.5)

-- Rounded corners & shadow for the frame
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 15)
corner.Parent = frame

local shadow = Instance.new("ImageLabel")
shadow.Size = UDim2.new(1, 10, 1, 10)
shadow.Position = UDim2.new(0, -5, 0, -5)
shadow.BackgroundTransparency = 1
shadow.Image = "rbxassetid://301031902"
shadow.ImageTransparency = 0.5
shadow.Parent = frame

-- Title
local title = Instance.new("TextLabel")
title.Text = "2TuffCheats Menu"
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundColor3 = Color3.fromRGB(65, 105, 225)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.TextStrokeTransparency = 0.8
title.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
title.Parent = frame

-- Drag functionality
local dragging, dragInput, dragStart, startPos
frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = frame.Position
        input.Changed:Connect(function()
            if not input.UserInputState == Enum.UserInputState.Change then return end
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end)
    end
end)

frame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- Toggle visibility with K key
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if input.KeyCode == Enum.KeyCode.K and not gameProcessed then
        frame.Visible = not frame.Visible
    end
end)
