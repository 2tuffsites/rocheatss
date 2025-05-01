-- Password-protected 2TuffCheats UI
if game.CoreGui:FindFirstChild("2TuffCheats") then game.CoreGui["2TuffCheats"]:Destroy() end

local correctPassword = "minors69"
local inputPassword = tostring(game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):PromptForInput("Enter password:"))

if inputPassword ~= correctPassword then
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Access Denied",
        Text = "Incorrect password.";
        Duration = 5
    })
    return
end

print("✅ 2TuffCheats loaded. Welcome back.")

local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "2TuffCheats"
gui.Parent = game.CoreGui
gui.ResetOnSpawn = false

local frame = Instance.new("Frame")
frame.Name = "MainFrame"
frame.Size = UDim2.new(0, 400, 0, 300)
frame.Position = UDim2.new(0.5, -200, 0.5, -150)
frame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
frame.BorderSizePixel = 0
frame.BackgroundTransparency = 0
frame.Active = true
frame.Draggable = true
frame.Parent = gui

-- Neon outline
local uiStroke = Instance.new("UIStroke")
uiStroke.Color = Color3.fromRGB(0, 153, 255)
uiStroke.Thickness = 3
uiStroke.Parent = frame

-- Title
local title = Instance.new("TextLabel")
title.Text = "2TuffCheats Menu"
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundColor3 = Color3.fromRGB(0, 153, 255)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.FredokaOne
title.TextSize = 22
title.Parent = frame

-- Welcome message
local welcome = Instance.new("TextLabel")
welcome.Text = "Welcome to 2TuffCheats"
welcome.Size = UDim2.new(1, 0, 0, 30)
welcome.Position = UDim2.new(0, 0, 0, 40)
welcome.BackgroundTransparency = 1
welcome.TextColor3 = Color3.fromRGB(0, 153, 255)
welcome.Font = Enum.Font.FredokaOne
welcome.TextSize = 18
welcome.Parent = frame

delay(2, function()
    welcome:Destroy()
end)

-- Button container
local buttonFrame = Instance.new("Frame")
buttonFrame.Position = UDim2.new(0, 0, 0, 70)
buttonFrame.Size = UDim2.new(1, 0, 1, -70)
buttonFrame.BackgroundTransparency = 1
buttonFrame.Parent = frame

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 10)
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
layout.VerticalAlignment = Enum.VerticalAlignment.Top
layout.Parent = buttonFrame

-- Button function
local function MakeButton(name, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 360, 0, 40)
    btn.Text = name
    btn.BackgroundColor3 = Color3.fromRGB(0, 153, 255)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.FredokaOne
    btn.TextSize = 18
    btn.Parent = buttonFrame

    btn.MouseButton1Click:Connect(callback)
end

-- Teleport tool function
MakeButton("Teleport Tool", function()
    local tool = Instance.new("Tool")
    tool.Name = "TeleportTool"
    tool.RequiresHandle = false

    tool.Activated:Connect(function()
        local mouse = game.Players.LocalPlayer:GetMouse()
        if mouse and mouse.Hit then
            game.Players.LocalPlayer.Character:MoveTo(mouse.Hit.Position + Vector3.new(0, 3, 0))
        end
    end)

    tool.Parent = game.Players.LocalPlayer.Backpack
end)

-- Smooth hide with K
local hidden = false
UserInputService.InputBegan:Connect(function(input, processed)
    if input.KeyCode == Enum.KeyCode.K and not processed then
        hidden = not hidden
        local targetPos = hidden and UDim2.new(0.5, -200, -1, 0) or UDim2.new(0.5, -200, 0.5, -150)
        TweenService:Create(frame, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {Position = targetPos}):Play()
    end
end)

