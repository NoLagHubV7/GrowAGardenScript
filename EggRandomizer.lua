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
	btn.BorderSizePixel = 0
	return btn
end

local espBtn = makeBtn(50, "🔍 ESP: ON")
local autoBtn = makeBtn(90, "🔄 Auto Randomize: ON")
local onceBtn = makeBtn(130, "🎲 Randomize Once")

-- Countdown Label
local counter = Instance.new("TextLabel", frame)
counter.Size = UDim2.new(1, 0, 0, 25)
counter.Position = UDim2.new(0, 0, 0, 170)
counter.Text = "Randomize in: 0"
counter.BackgroundTransparency = 1
counter.TextColor3 = Color3.new(1, 1, 1)
counter.Font = Enum.Font.Gotham
counter.TextScaled = true

-- Footer
local footer = Instance.new("TextLabel", frame)
footer.Size = UDim2.new(1, 0, 0, 20)
footer.Position = UDim2.new(0, 0, 1, -20)
footer.Text = "Made By ShinScriptz 🔥🔥"
footer.BackgroundTransparency = 1
footer.TextColor3 = Color3.fromRGB(150, 150, 255)
footer.Font = Enum.Font.Gotham
footer.TextScaled = true

-- Toggle visibility
local function setMinimized(state)
	minimized = state
	for _, obj in pairs(frame:GetChildren()) do
		if obj ~= minimizeBtn and obj ~= title then
			obj.Visible = not minimized
		end
	end
	minimizeBtn.Text = minimized and "+" or "-"
end

minimizeBtn.MouseButton1Click:Connect(function()
	setMinimized(not minimized)
end)

-- ESP Logic
local function highlightEgg(egg)
	if not egg:FindFirstChild("ClientHighlight") then
		local h = Instance.new("Highlight")
		h.Name = "ClientHighlight"
		h.FillColor = Color3.fromRGB(255, 255, 0)
		h.FillTransparency = 0.3
		h.OutlineTransparency = 0.1
		h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
		h.Adornee = egg
		h.Parent = egg
	end
end

local function isTargetEgg(egg)
	for _, name in pairs(EGG_NAMES) do
		if egg.Name == name then
			return true
		end
	end
	return false
end

-- ESP toggle
espBtn.MouseButton1Click:Connect(function()
	espEnabled = not espEnabled
	espBtn.Text = espEnabled and "🔍 ESP: ON" or "🔍 ESP: OFF"
end)

-- Auto toggle
autoBtn.MouseButton1Click:Connect(function()
	autoEnabled = not autoEnabled
	autoBtn.Text = autoEnabled and "🔄 Auto Randomize: ON" or "🔄 Auto Randomize: OFF"
end)

-- ESP scanner
game:GetService("RunService").RenderStepped:Connect(function()
	if not espEnabled then return end
	for _, obj in pairs(workspace:GetDescendants()) do
		if obj:IsA("Model") and isTargetEgg(obj) then
			highlightEgg(obj)
		end
	end
end)

-- Auto randomizer logic
local lastRandom = 0

local function getRandomEgg()
	local eggs = {}
	for _, obj in pairs(workspace:GetDescendants()) do
		if obj:IsA("Model") and isTargetEgg(obj) then
			table.insert(eggs, obj)
		end
	end
	if #eggs > 0 then
		return eggs[math.random(1, #eggs)]
	end
end

local function randomizeOnce()
	local egg = getRandomEgg()
	if egg and not egg:FindFirstChild("ClientHighlight") then
		highlightEgg(egg)
	end
end

onceBtn.MouseButton1Click:Connect(randomizeOnce)

-- Auto loop
task.spawn(function()
	while true do
		for i = AUTO_RANDOMIZE_DELAY, 0, -1 do
			counter.Text = "Randomize in: " .. i
			task.wait(1)
		end
		if autoEnabled then
			randomizeOnce()
		end
	end
end)

-- Initial state
setMinimized(false)
