-- Password Input Check (before everything else)
local password = "miners69" -- Set the password here
local enteredPassword = nil

-- Create the password input window
local function createPasswordInput()
    local gui = Instance.new("ScreenGui")
    gui.Name = "PasswordInput"
    gui.Parent = game.CoreGui
    gui.ResetOnSpawn = false

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 400, 0, 300)
    frame.Position = UDim2.new(0.5, -200, 0.5, -150)
    frame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
    frame.BorderSizePixel = 0
    frame.Parent = gui

    local title = Instance.new("TextLabel")
    title.Text = "Enter Password"
    title.Size = UDim2.new(1, 0, 0, 40)
    title.BackgroundColor3 = Color3.fromRGB(65, 105, 225)
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 24
    title.Parent = frame

    local inputField = Instance.new("TextBox")
    inputField.Size = UDim2.new(0, 300, 0, 40)
    inputField.Position = UDim2.new(0.5, -150, 0.5, -60)
    inputField.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    inputField.TextColor3 = Color3.fromRGB(0, 0, 0)
    inputField.ClearTextOnFocus = true
    inputField.Font = Enum.Font.Gotham
    inputField.TextSize = 20
    inputField.Parent = frame

    local submitButton = Instance.new("TextButton")
    submitButton.Text = "Submit"
    submitButton.Size = UDim2.new(0, 150, 0, 40)
    submitButton.Position = UDim2.new(0.5, -75, 0.5, 60)
    submitButton.BackgroundColor3 = Color3.fromRGB(65, 105, 225)
    submitButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    submitButton.Font = Enum.Font.GothamBold
    submitButton.TextSize = 18
    submitButton.Parent = frame

    submitButton.MouseButton1Click:Connect(function()
        enteredPassword = inputField.Text
        if enteredPassword == password then
            -- Close password input window
            gui:Destroy()
            createMenu()
        else
            -- Incorrect password warning
            print("Incorrect password!")
        end
    end)
end

-- Menu Creation after Password Validation
local function createMenu()
    print("💀 2TuffCheats loaded. Stay sharp.")

    local UserInputService = game:GetService("UserInputService")

    -- GUI Setup
    local gui = Instance.new("ScreenGui")
    gui.Name = "2TuffCheats"
    gui.Parent = game.CoreGui
    gui.ResetOnSpawn = false

    local frame = Instance.new("Frame")
    frame.Name = "MainFrame"
    frame.Size = UDim2.new(0, 400, 0, 300)
    frame.Position = UDim2.new(0.5, -200, 0.5, -150)
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
    title.TextSize = 24
    title.Parent = frame

    -- Teleport Tool Button
    local tpButton = Instance.new("TextButton")
    tpButton.Text = "Teleport Tool"
    tpButton.Size = UDim2.new(0, 350, 0, 40)
    tpButton.Position = UDim2.new(0.5, -175, 0.5, 0)
    tpButton.BackgroundColor3 = Color3.fromRGB(65, 105, 225)
    tpButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    tpButton.Font = Enum.Font.GothamBold
    tpButton.TextSize = 18
    tpButton.Parent = frame

    -- Teleport tool activation
    tpButton.MouseButton1Click:Connect(function()
        local tpToolActivated = true
        local mouse = game.Players.LocalPlayer:GetMouse()

        mouse.Button1Down:Connect(function()
            if tpToolActivated then
                local targetPosition = mouse.Hit.p
                game.Players.LocalPlayer.Character:MoveTo(targetPosition)
            end
        end)
    end)

    -- Toggle visibility with K key
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if input.KeyCode == Enum.KeyCode.K and not gameProcessed then
            frame.Visible = not frame.Visible
            -- Smooth hide transition
            if not frame.Visible then
                frame.Position = UDim2.new(0.5, -200, 0.5, -350)
            end
        end
    end)

    -- Make the menu draggable
    local dragging, dragInput, dragStart, startPos
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    frame.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

-- Start the password input process
createPasswordInput()

