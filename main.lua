local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "2tuff cheats",
   Icon = 0,
   LoadingTitle = "cheats brah",
   LoadingSubtitle = "by luc",
   Theme = "Dark Blue",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil,
      FileName = "2tuff cheats"
   },
   KeySystem = true,
   KeySettings = {
      Title = "Untitled",
      Subtitle = "Key System",
      Note = "No method of obtaining the key is provided",
      FileName = "KeySystem",
      SaveKey = true,
      GrabKeyFromSite = false,
      Key = {"Rahh"}
   }
})

-- Player Tab
local PlayerTab = Window:CreateTab("Player", 4483362458)

-- Speed Slider
PlayerTab:CreateSlider({
   Name = "Speed",
   Range = {16, 500},
   Increment = 1,
   Suffix = "Speed",
   CurrentValue = 16,
   Flag = "SpeedSlider",
   Callback = function(Value)
      local hum = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
      if hum then
         hum.WalkSpeed = Value
      end
   end,
})

-- Jump Power Slider
PlayerTab:CreateSlider({
   Name = "Jump Power",
   Range = {50, 500},
   Increment = 10,
   Suffix = "Jump",
   CurrentValue = 50,
   Flag = "JumpSlider",
   Callback = function(Value)
      local plr = game.Players.LocalPlayer
      local function applyJumpPower()
         local hum = plr.Character and plr.Character:FindFirstChildOfClass("Humanoid")
         if hum then
            hum.UseJumpPower = true
            hum.JumpPower = Value
         end
      end
      applyJumpPower()
      plr.CharacterAdded:Connect(function()
         wait(0.5)
         applyJumpPower()
      end)
   end,
})

-- TP Tool
PlayerTab:CreateButton({
   Name = "TP Tool",
   Callback = function()
      local Tool = Instance.new("Tool")
      Tool.Name = "TP Tool"
      Tool.RequiresHandle = false
      Tool.CanBeDropped = false

      local player = game.Players.LocalPlayer
      local mouse = player:GetMouse()
      local connection

      Tool.Equipped:Connect(function()
         if connection then
            connection:Disconnect()
         end

         connection = mouse.Button1Down:Connect(function()
            local char = player.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if hrp then
               hrp.CFrame = CFrame.new(mouse.Hit.Position + Vector3.new(0, 5, 0))
            end
         end)
      end)

      Tool.Unequipped:Connect(function()
         if connection then
            connection:Disconnect()
            connection = nil
         end
      end)

      Tool.Parent = player.Backpack
   end,
})

-- Infinite Zoom
PlayerTab:CreateButton({
   Name = "Infinite Zoom",
   Callback = function()
      game.Players.LocalPlayer.CameraMaxZoomDistance = math.huge
   end,
})

-- Invisibility Toggle
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = game.Players.LocalPlayer
local isInvisible = false
local invisibilityEnabled = false
local originalHRPParent = nil

PlayerTab:CreateToggle({
   Name = "Invisible Toggle (Press R)",
   CurrentValue = false,
   Flag = "InvisibleToggle",
   Callback = function(Value)
      invisibilityEnabled = Value
   end,
})

UserInputService.InputBegan:Connect(function(input, gameProcessed)
   if gameProcessed then return end
   if input.KeyCode == Enum.KeyCode.R and invisibilityEnabled then
      local char = LocalPlayer.Character
      if not char then return end

      local hrp = char:FindFirstChild("HumanoidRootPart")
      if not hrp then return end

      if not isInvisible then
         originalHRPParent = hrp.Parent
         hrp.Parent = nil -- Server-invisible method
         for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") then
               part.Transparency = 0.7
            elseif part:IsA("Decal") or part:IsA("Texture") then
               part:Destroy()
            end
         end
         isInvisible = true
      else
         if originalHRPParent then
            hrp.Parent = originalHRPParent
         end
         for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") then
               part.Transparency = 0
            end
         end
         isInvisible = false
      end
   end
end)

-- Misc Tab
local MiscTab = Window:CreateTab("Misc", 4483362458)

-- Infinite Yield Button (FE v6.3.1)
MiscTab:CreateButton({
   Name = "Infinite Yield",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
   end,
})
local Window = Rayfield:CreateWindow({
   Name = "2tuff cheats",
   Icon = 0,
   LoadingTitle = "cheats brah",
   LoadingSubtitle = "by luc",
   Theme = "Dark Blue",  -- This is where the theme is defined, it will change to the one we provided
   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil,
      FileName = "2tuff cheats"
   },
   KeySystem = true,
   KeySettings = {
      Title = "Untitled",
      Subtitle = "Key System",
      Note = "No method of obtaining the key is provided",
      FileName = "KeySystem",
      SaveKey = true,
      GrabKeyFromSite = false,
      Key = {"Rahh"}
   }
})

-- Replace the Theme section with your new theme here
local customTheme = {
    TextColor = Color3.fromRGB(0, 47, 255),  -- Royal blue text color
    Background = Color3.fromRGB(0, 0, 0),  -- Black background
    Topbar = Color3.fromRGB(255, 255, 255),  -- White topbar
    Shadow = Color3.fromRGB(20, 20, 20),  -- Subtle shadow (black)

    NotificationBackground = Color3.fromRGB(0, 0, 0),  -- Black for notifications
    NotificationActionsBackground = Color3.fromRGB(230, 230, 230),  -- Light grey for notification actions

    TabBackground = Color3.fromRGB(0, 0, 0),  -- Black tab background
    TabStroke = Color3.fromRGB(85, 85, 85),  -- Darker grey stroke for tabs
    TabBackgroundSelected = Color3.fromRGB(0, 47, 255),  -- Royal blue for selected tab background
    TabTextColor = Color3.fromRGB(0, 47, 255),  -- Royal blue text for tabs
    SelectedTabTextColor = Color3.fromRGB(255, 255, 255),  -- White for selected tab text

    ElementBackground = Color3.fromRGB(25, 25, 25),  -- Dark grey elements
    ElementBackgroundHover = Color3.fromRGB(40, 40, 40),  -- Slightly lighter grey when hovered
    SecondaryElementBackground = Color3.fromRGB(0, 0, 0),  -- Black for secondary elements
    ElementStroke = Color3.fromRGB(50, 50, 50),  -- Dark grey strokes for elements
    SecondaryElementStroke = Color3.fromRGB(40, 40, 40),  -- Slightly lighter strokes

    SliderBackground = Color3.fromRGB(0, 47, 255),  -- Royal blue slider background
    SliderProgress = Color3.fromRGB(0, 47, 255),  -- Royal blue progress
    SliderStroke = Color3.fromRGB(0, 63, 255),  -- Lighter royal blue stroke

    ToggleBackground = Color3.fromRGB(30, 30, 30),  -- Dark background for toggles
    ToggleEnabled = Color3.fromRGB(0, 146, 214),  -- Bright blue for toggle enabled
    ToggleDisabled = Color3.fromRGB(100, 100, 100),  -- Grey for toggle disabled
    ToggleEnabledStroke = Color3.fromRGB(0, 170, 255),  -- Lighter blue for enabled toggle stroke
    ToggleDisabledStroke = Color3.fromRGB(125, 125, 125),  -- Lighter grey for disabled toggle stroke
    ToggleEnabledOuterStroke = Color3.fromRGB(100, 100, 100),  -- Outer stroke for enabled toggle
    ToggleDisabledOuterStroke = Color3.fromRGB(65, 65, 65),  -- Outer stroke for disabled toggle

    DropdownSelected = Color3.fromRGB(40, 40, 40),  -- Dark grey for dropdown selected
    DropdownUnselected = Color3.fromRGB(30, 30, 30),  -- Slightly lighter grey for unselected dropdown items

    InputBackground = Color3.fromRGB(30, 30, 30),  -- Dark grey background for input fields
    InputStroke = Color3.fromRGB(65, 65, 65),  -- Lighter grey stroke for input fields
    PlaceholderColor = Color3.fromRGB(178, 178, 178)  -- Placeholder text color (light grey)
}

-- Apply custom theme to the window
Window:SetTheme(customTheme)
