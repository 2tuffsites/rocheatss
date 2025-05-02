-- 2TuffCheats - Base Secure Menu Setup
if game.CoreGui:FindFirstChild("2TuffCheats") then game.CoreGui["2TuffCheats"]:Destroy() end

local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")

-- Create main ScreenGui
local gui = Instance.new("ScreenGui")
gui.Name = "2TuffCheats"
gui.ResetOnSpawn = false
gui.Parent = CoreGui

-- Password Frame
local pwFrame = Instance.new("Frame")
pwFrame.Size = UDim2.new(0, 300, 0, 120)
pwFrame.Position = UDim2.new(0.5, -150, 0.5, -60)
pwFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
pwFrame.BorderSizePixel = 0
pwFrame.Parent = gui

local pwLabel = Instance.new("TextLabel")
pwLabel.Size = UDim2.new(1, 0, 0.4, 0)
pwLabel.Position = UDim2.new(0, 0, 0, 0)
pwLabel.Text = "Enter Password"
pwLabel.TextColor3 = Color3.new(1, 1, 1)
pwLabel.BackgroundTransparency = 1
pwLabel.Font = Enum.Font.GothamBold
pwLabel.TextSize = 20
pwLabel.Parent = pwFrame

local pwBox = Instance.new("TextBox")
pwBox.Size = UDim2.new(0.9, 0, 0.3, 0)
pwBox.Position = UDim2.new(0.05, 0, 0.45, 0)
pwBox.PlaceholderText = "Password"
pwBox.Text = ""
pwBox.ClearTextOnFocus = false
pwBox.TextColor3 = Color3.new(1,1,1)
pwBox.BackgroundColor3 = Color3.fromRGB(30,30,30)
pwBox.Font = Enum.Font.Gotham
pwBox.TextSize = 18
pwBox.Parent = pwFrame

local submit = Instance.new("TextButton")
submit.Size = UDim2.new(0.5, 0, 0.2, 0)
submit.Position = UDim2.new(0.25, 0, 0.8, 0)
submit.Text = "Submit"
submit.Font = Enum.Font.GothamBold
submit.TextSize = 18
submit.TextColor3 = Color3.new(1,1,1)
submit.BackgroundColor3 = Color3.fromRGB(65,105,225)
submit.Parent = pwFrame

-- Menu Frame (starts hidden)
local menuFrame = Instance.new("Frame")
menuFrame.Size = UDim2.new(0, 400, 0, 300)
menuFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
menuFrame.BackgroundColor3 = Color3.fromRGB(10,10,10)
menuFrame.BorderSizePixel = 0
menuFrame.Visible = false
menuFrame.Parent = gui

local menuTitle = Instance.new("TextLabel")
menuTitle.Size = UDim2.new(1, 0, 0, 40)
menuTitle.Text = "2TuffCheats"
menuTitle.BackgroundColor3 = Color3.fromRGB(65,105,225)
menuTitle.TextColor3 = Color3.new(1,1,1)
menuTitle.Font = Enum.Font.GothamBold
menuTitle.TextSize = 22
menuTitle.Parent = menuFrame

-- Submit Password
submit.MouseButton1Click:Connect(function()
	if pwBox.Text == "miners69" then
		pwFrame:Destroy()
		menuFrame.Visible = true

		-- Greet the user
		local greet = Instance.new("TextLabel")
		greet.Size = UDim2.new(0, 200, 0, 50)
		greet.Position = UDim2.new(0.5, -100, 0, -60)
		greet.Text = "Greetings slime."
		greet.TextColor3 = Color3.new(1,1,1)
		greet.BackgroundColor3 = Color3.fromRGB(65,105,225)
		greet.Font = Enum.Font.Gotham
		greet.TextSize = 18
		greet.Parent = gui

		task.delay(2, function()
			greet:Destroy()
		end)
	else
		pwBox.Text = ""
		pwBox.PlaceholderText = "Wrong Password"
	end
end)

-- Toggle menu with K
UserInputService.InputBegan:Connect(function(input, gpe)
	if input.KeyCode == Enum.KeyCode.K and not gpe then
		if menuFrame.Visible then
			menuFrame.Visible = false
		else
			menuFrame.Visible = true
		end
	end
end)
