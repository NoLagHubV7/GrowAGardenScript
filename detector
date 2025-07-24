local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "EggDetectorUI"
gui.ResetOnSpawn = false

-- Main Frame
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 300, 0, 240)
frame.Position = UDim2.new(0.5, -150, 0.5, -120)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 40)
frame.BorderSizePixel = 0
frame.Name = "EggDetectorMain"

-- Title
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 40)
title.Text = "🥚 Egg Detector"
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.GothamBold
title.TextScaled = true
title.BackgroundTransparency = 1

-- ESP Toggle Button
local espBtn = Instance.new("TextButton", frame)
espBtn.Size = UDim2.new(0.9, 0, 0, 30)
espBtn.Position = UDim2.new(0.05, 0, 0, 50)
espBtn.Text = "🔍 ESP: ON"
espBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
espBtn.TextColor3 = Color3.new(1,1,1)
espBtn.Font = Enum.Font.Gotham
espBtn.TextScaled = true
espBtn.BorderSizePixel = 0

-- Auto Randomize Button (placeholder)
local autoBtn = Instance.new("TextButton", frame)
autoBtn.Size = UDim2.new(0.9, 0, 0, 30)
autoBtn.Position = UDim2.new(0.05, 0, 0, 90)
autoBtn.Text = "🔄 Auto Randomize: ON"
autoBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
autoBtn.TextColor3 = Color3.new(1,1,1)
autoBtn.Font = Enum.Font.Gotham
autoBtn.TextScaled = true
autoBtn.BorderSizePixel = 0

-- Randomize Once Button (placeholder)
local onceBtn = Instance.new("TextButton", frame)
onceBtn.Size = UDim2.new(0.9, 0, 0, 30)
onceBtn.Position = UDim2.new(0.05, 0, 0, 130)
onceBtn.Text = "🎲 Randomize Once"
onceBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
onceBtn.TextColor3 = Color3.new(1,1,1)
onceBtn.Font = Enum.Font.Gotham
onceBtn.TextScaled = true
onceBtn.BorderSizePixel = 0

-- Countdown Label
local counter = Instance.new("TextLabel", frame)
counter.Size = UDim2.new(1, 0, 0, 25)
counter.Position = UDim2.new(0, 0, 0, 170)
counter.Text = "Randomize in: 0"
counter.BackgroundTransparency = 1
counter.TextColor3 = Color3.new(1, 1, 1)
counter.Font = Enum.Font.Gotham
counter.TextScaled = true

-- Footer Label
local footer = Instance.new("TextLabel", frame)
footer.Size = UDim2.new(1, 0, 0, 20)
footer.Position = UDim2.new(0, 0, 1, -20)
footer.Text = "Made By ShinScriptz 🔥🔥"
footer.BackgroundTransparency = 1
footer.TextColor3 = Color3.fromRGB(150, 150, 255)
footer.Font = Enum.Font.Gotham
footer.TextScaled = true

-- ESP Toggle logic
local espEnabled = true

espBtn.MouseButton1Click:Connect(function()
    espEnabled = not espEnabled
    espBtn.Text = espEnabled and "🔍 ESP: ON" or "🔍 ESP: OFF"
end)

-- 🧠 Egg Detection Logic
local RunService = game:GetService("RunService")

local function highlightEgg(egg)
    if egg and not egg:FindFirstChild("ClientESP") then
        local h = Instance.new("Highlight")
        h.Name = "ClientESP"
        h.FillColor = Color3.fromRGB(255, 255, 0)
        h.FillTransparency = 0.4
        h.OutlineTransparency = 0.1
        h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        h.Adornee = egg
        h.Parent = egg
    end
end

-- Customize this based on how Grow a Garden tracks eggs
local function isHatchingSoon(egg)
    local timer = egg:FindFirstChild("HatchTimer")
    if timer and timer:IsA("NumberValue") then
        return timer.Value <= 5
    end
    return false
end

-- Real-time scanner
RunService.RenderStepped:Connect(function()
    if not espEnabled then return end

    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Model") and obj.Name == "Egg" then
            if isHatchingSoon(obj) then
                highlightEgg(obj)
            end
        end
    end
end)
  
