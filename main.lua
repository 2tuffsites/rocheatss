if game.CoreGui:FindFirstChild("2TuffCheats") then game.CoreGui["2TuffCheats"]:Destroy() end

print("2TuffCheats loaded. Stay sharp.")

local UserInputService = game:GetService("UserInputService")

local gui = Instance.new("ScreenGui")
gui.Name = "2TuffCheats"
gui.Parent = game.CoreGui
gui.ResetOnSpawn = false

local frame = Instance.new("Frame")
frame.Name = "MainFrame"
frame.Size = UDim2.new(0, 300, 0, 200)
frame.Position = UDim2.new(0.5, -150, 0.5, -100)
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
