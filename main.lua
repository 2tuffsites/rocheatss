-- Password Input Setup
local password = "miners69" -- Set the password here
local enteredPassword = nil

-- Function to create the password input GUI
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
            gui:Destroy()  -- Destroy password input window
            createMenu()   -- Create the menu
        else
            -- Incorrect password, can add some feedback if needed
            print("Incorrect password!")
        end
    end)
end

-- Menu Creation
local function createMenu()
    print("2TuffCheats loaded. Stay sharp.")

    local UserInputService = game:GetService("UserInputService")

    -- Create the main menu GUI
    local gui = Instance.new("ScreenGui")
    gui.Name = "2TuffCheats"
    gui.Parent = game.CoreGui
    gui.ResetOnSpawn = false

    local frame = Instance.new("Frame")
    frame.Name = "MainFrame"
    frame.Size = UDim2.new(0, 600, 0, 500)  -- Menu size increased
    frame.Position = UDim2.new(0.5, -300, 0.5, -250)
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

    -- Create the teleport tool button (Royal Blue)
    local tpButton = Instance.new("TextButton")
    tpButton.Text = "TP Tool"
    tpButton.Size = UDim2.new(0, 350, 0, 40)
    tpButton.Position = UDim2.new(0.5, -175, 0.5, 40)  -- Positioned under the menu title
    tpButton.BackgroundColor3 = Color3.fromRGB(65, 105, 225)
    tpButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    tpButton.Font = Enum.Font.GothamBold
    tpButton.TextSize = 18
    tpButton.Parent = frame

    -- Show greeting message
    local greeting = Instance.new("TextLabel")
    greeting.Text = "Greetings slime"
    greeting.Size = UDim2.new(1, 0, 0, 40)
    greeting.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
    greeting.TextColor3 = Color3.fromRGB(255, 255, 255)
    greeting.Font = Enum.Font.Gotham
    greeting.TextSize = 20
    greeting.Parent = frame
    greeting.Visible = true

    -- Fade out greeting after 2 seconds
    wait(2)
    greeting:TweenPosition(UDim2.new(0.5, -200, 0.5, -100), "Out", "Linear", 1)

    -- Add teleport tool to hotbar when clicked
    tpButton.MouseButton1Click:Connect(function()
        local hotbar = game.Players.LocalPlayer.Backpack
        local tool = Instance.new("Tool")
        tool.Name = "TeleportTool"
        tool.RequiresHandle = true
        tool.Parent = hotbar

        -- Tool click event to teleport to mouse position
        tool.Activated:Connect(function()
            local mouse = game.Players.LocalPlayer:GetMouse()
            local targetPosition = mouse.Hit.p
            game.Players.LocalPlayer.Character:MoveTo(targetPosition)
        end)
    end)

    -- Toggle menu visibility with K key
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if input.KeyCode == Enum.KeyCode.K and not gameProcessed then
            frame.Visible = not frame.Visible
        end
    end)

    -- Draggable menu
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

