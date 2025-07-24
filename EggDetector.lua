local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "EggDetectorUI"
gui.ResetOnSpawn = false

-- ========== SETTINGS ==========
local EGG_NAMES = { "Bug Egg", "Paradise Egg", "Common Egg", "Legendary Egg" }
local AUTO_RANDOMIZE_DELAY = 5 -- seconds
-- ==============================

local minimized = false
local espEnabled = true
local autoEnabled = true

-- GUI Setup
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 280, 0, 250)
frame.Position = UDim2.new(0.5, -140, 0.5, -125)
frame.BackgroundColor3 = Color3.fromRGB(10, 10, 40)
frame.BorderSizePixel = 0

-- Title
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, -30, 0, 40)
title.Position = UDim2.new(0, 5, 0, 0)
title.Text = "🥚 Egg Detector"
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.GothamBold
title.TextScaled = true
title.BackgroundTransparency = 1

-- Minimize Button
local minimizeBtn = Instance.new("TextButton", frame)
minimizeBtn.Size = UDim2.new(0, 30, 0, 30)
minimizeBtn.Position = UDim2.new(1, -35, 0, 5)
minimizeBtn.Text = "-"
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.TextColor3 = Color3.new(1,1,1)
minimizeBtn.TextScaled = true
minimizeBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
minimizeBtn.BorderSizePixel = 0

-- Buttons
local function makeBtn(y, text)
	local btn = Instance.new("TextButton", frame)
	btn.Size = UDim2.new(0.9, 0, 0, 30)
	btn.Position = UDim2.new(0.05, 0, 0, y)
	btn.Text = text
	btn.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
	btn.TextColor3 = Color3.new(1,1,1)
	btn.Font = Enum.Font.Gotham
	btn.TextScaled = true
	btn.BorderSizePixel
    
