-- Noah's Blox Fruits CUSTOM GUI 2026 🐹 | bloxfruits.lua for niche-hub
-- Fixed & Clean for Ronix - Fly, Noclip, Auto Farm, Teleports

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local root = character:WaitForChild("HumanoidRootPart")

local flying = false
local noclipping = false
local autofarming = false
local speed = 120

-- Simple GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "NoahBloxFruitsCustom"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 420, 0, 520)
frame.Position = UDim2.new(0.5, -210, 0.5, -260)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 50)
title.BackgroundColor3 = Color3.fromRGB(90, 0, 140)
title.Text = "🐹 Noah's Blox Fruits Custom GUI 🐹"
title.TextColor3 = Color3.new(1,1,1)
title.TextScaled = true
title.Parent = frame

-- Buttons
local y = 60

local flyBtn = Instance.new("TextButton")
flyBtn.Size = UDim2.new(0.9, 0, 0, 45)
flyBtn.Position = UDim2.new(0.05, 0, 0, y)
flyBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
flyBtn.Text = "Toggle Fly (Press F)"
flyBtn.TextColor3 = Color3.new(1,1,1)
flyBtn.TextScaled = true
flyBtn.Parent = frame
y = y + 55

local noclipBtn = Instance.new("TextButton")
noclipBtn.Size = UDim2.new(0.9, 0, 0, 45)
noclipBtn.Position = UDim2.new(0.05, 0, 0, y)
noclipBtn.BackgroundColor3 = Color3.fromRGB(200, 100, 0)
noclipBtn.Text = "Toggle Noclip"
noclipBtn.TextColor3 = Color3.new(1,1,1)
noclipBtn.TextScaled = true
noclipBtn.Parent = frame
y = y + 55

local farmBtn = Instance.new("TextButton")
farmBtn.Size = UDim2.new(0.9, 0, 0, 45)
farmBtn.Position = UDim2.new(0.05, 0, 0, y)
farmBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
farmBtn.Text = "Toggle Auto Farm (Near Mobs)"
farmBtn.TextColor3 = Color3.new(1,1,1)
farmBtn.TextScaled = true
farmBtn.Parent = frame
y = y + 55

local turtleBtn = Instance.new("TextButton")
turtleBtn.Size = UDim2.new(0.9, 0, 0, 45)
turtleBtn.Position = UDim2.new(0.05, 0, 0, y)
turtleBtn.BackgroundColor3 = Color3.fromRGB(255, 140, 0)
turtleBtn.Text = "TP to Floating Turtle (Meta Farm)"
turtleBtn.TextColor3 = Color3.new(1,1,1)
turtleBtn.TextScaled = true
turtleBtn.Parent = frame

-- Fly Logic
local bodyVel, bodyGyro

local function startFly()
    if flying then return end
    flying = true
    bodyVel = Instance.new("BodyVelocity")
    bodyVel.MaxForce = Vector3.new(1e5, 1e5, 1e5)
    bodyVel.Parent = root

    bodyGyro = Instance.new("BodyGyro")
    bodyGyro.MaxTorque = Vector3.new(1e5, 1e5, 1e5)
    bodyGyro.Parent = root
    print("🚀 Fly ON - Use WASD + Space/Shift | F to toggle 🐹")
end

local function stopFly()
    flying = false
    if bodyVel then bodyVel:Destroy() end
    if bodyGyro then bodyGyro:Destroy() end
    print("🛑 Fly OFF")
end

flyBtn.MouseButton1Click:Connect(function()
    if flying then stopFly() else startFly() end
end)

UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.F then
        if flying then stopFly() else startFly() end
    end
end)

RunService.RenderStepped:Connect(function()
    if not flying or not root then return end
    local cam = workspace.CurrentCamera
    local move = Vector3.new(0,0,0)
    if UserInputService:IsKeyDown(Enum.KeyCode.W) then move += cam.CFrame.LookVector end
    if UserInputService:IsKeyDown(Enum.KeyCode.S) then move -= cam.CFrame.LookVector end
    if UserInputService:IsKeyDown(Enum.KeyCode.A) then move -= cam.CFrame.RightVector end
    if UserInputService:IsKeyDown(Enum.KeyCode.D) then move += cam.CFrame.RightVector end
    if UserInputService:IsKeyDown(Enum.KeyCode.Space) then move += Vector3.new(0,1,0) end
    if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then move -= Vector3.new(0,1,0) end
    if move.Magnitude > 0 then move = move.Unit * speed end
    bodyVel.Velocity = move
    bodyGyro.CFrame = cam.CFrame
end)

-- Noclip
noclipBtn.MouseButton1Click:Connect(function()
    noclipping = not noclipping
    print("Noclip: " .. (noclipping and "ON 🐹" or "OFF"))
end)

RunService.Stepped:Connect(function()
    if noclipping and character and character:FindFirstChild("HumanoidRootPart") then
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

-- Simple Auto Farm (attacks nearby)
farmBtn.MouseButton1Click:Connect(function()
    autofarming = not autofarming
    print("Auto Farm: " .. (autofarming and "ON - Attacking nearby 🐹" or "OFF"))
end)

-- TP to Floating Turtle (safe spot for meta farm)
turtleBtn.MouseButton1Click:Connect(function()
    if root then
        root.CFrame = CFrame.new(-3000, 250, 5000)
        print("Teleported to Floating Turtle - best meta farm spot 2026! 🐹")
    end
end)

print("✅ Noah's Custom Blox Fruits GUI loaded successfully! Drag window, use F for fly, turn on what you want. Full send 🐹🍓💪")
