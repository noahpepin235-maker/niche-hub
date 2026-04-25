-- Noah's Fisch Ultimate GUI - Fly + TP + Autofarm (JJSploit Edition 2026) 🐹
-- Best autofarm in Carrot Garden for max XP/money while flying around!

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local root = character:WaitForChild("HumanoidRootPart")

local flying = false
local speed = 50
local bodyVel, bodyGyro
local autofarming = false

-- Create ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "NoahFischExploit"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 420, 0, 620)
frame.Position = UDim2.new(0.5, -210, 0.5, -310)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 50)
title.BackgroundColor3 = Color3.fromRGB(60, 60, 90)
title.Text = "🐹 Noah's Fisch God GUI 🐹 | JJSploit Ready"
title.TextColor3 = Color3.new(1,1,1)
title.TextScaled = true
title.Parent = frame

-- Fly Section (same as before)
local flyLabel = Instance.new("TextLabel")
flyLabel.Size = UDim2.new(1, 0, 0, 30)
flyLabel.Position = UDim2.new(0, 0, 0, 60)
flyLabel.BackgroundTransparency = 1
flyLabel.Text = "Fly Controls"
flyLabel.TextColor3 = Color3.new(1,1,1)
flyLabel.TextScaled = true
flyLabel.Parent = frame

local flyButton = Instance.new("TextButton")
flyButton.Size = UDim2.new(0.9, 0, 0, 40)
flyButton.Position = UDim2.new(0.05, 0, 0, 100)
flyButton.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
flyButton.Text = "Toggle Fly (F key)"
flyButton.TextColor3 = Color3.new(1,1,1)
flyButton.TextScaled = true
flyButton.Parent = frame

local speedSlider = Instance.new("TextBox")
speedSlider.Size = UDim2.new(0.9, 0, 0, 30)
speedSlider.Position = UDim2.new(0.05, 0, 0, 150)
speedSlider.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
speedSlider.Text = "Fly Speed: 50"
speedSlider.TextColor3 = Color3.new(1,1,1)
speedSlider.Parent = frame

-- Teleport Section (your old ones + new Carrot Garden)
local tpLabel = Instance.new("TextLabel")
tpLabel.Size = UDim2.new(1, 0, 0, 30)
tpLabel.Position = UDim2.new(0, 0, 0, 190)
tpLabel.BackgroundTransparency = 1
tpLabel.Text = "Teleport Locations"
tpLabel.TextColor3 = Color3.new(1,1,1)
tpLabel.TextScaled = true
tpLabel.Parent = frame

local locations = {
    {name = "Moosewood (Start)", pos = Vector3.new(0, 10, 0)},
    {name = "Ancient Isle", pos = Vector3.new(6050, 210, 335)},
    {name = "Roslit Bay", pos = Vector3.new(360, 140, 235)},
    {name = "Mushgrove Swamp", pos = Vector3.new(-1785, 160, 635)},
    {name = "Snowcap Island", pos = Vector3.new(-1520, 140, 610)},
    {name = "The Abyss", pos = Vector3.new(-1915, 175, 310)},
    {name = "Deep Ocean", pos = Vector3.new(1000, -1240, -530)},
    {name = "Deep Ocean Depths", pos = Vector3.new(-13.7, -700, 1230.9)},
    {name = "Carrot Garden (BEST AUTOFARM)", pos = Vector3.new(3200, 150, 800)}  -- Safe spot in Carrot Garden area for farming
}

local yPos = 230
for _, loc in ipairs(locations) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 35)
    btn.Position = UDim2.new(0.05, 0, 0, yPos)
    btn.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
    btn.Text = loc.name
    btn.TextColor3 = Color3.new(1,1,1)
    btn.TextScaled = true
    btn.Parent = frame
    
    btn.MouseButton1Click:Connect(function()
        if root then
            root.CFrame = CFrame.new(loc.pos + Vector3.new(0, 10, 0))
            print("Teleported to " .. loc.name .. " 🐹")
        end
    end)
    
    yPos = yPos + 45
end

-- Autofarm Section
local farmLabel = Instance.new("TextLabel")
farmLabel.Size = UDim2.new(1, 0, 0, 30)
farmLabel.Position = UDim2.new(0, 0, 0, yPos + 10)
farmLabel.BackgroundTransparency = 1
farmLabel.Text = "Autofarm (Best Spot: Carrot Garden)"
farmLabel.TextColor3 = Color3.new(1,1,1)
farmLabel.TextScaled = true
farmLabel.Parent = frame

local farmButton = Instance.new("TextButton")
farmButton.Size = UDim2.new(0.9, 0, 0, 45)
farmButton.Position = UDim2.new(0.05, 0, 0, yPos + 50)
farmButton.BackgroundColor3 = Color3.fromRGB(200, 0, 200)
farmButton.Text = "Toggle Autofarm (AFK XP/Money)"
farmButton.TextColor3 = Color3.new(1,1,1)
farmButton.TextScaled = true
farmButton.Parent = frame

local noclipButton = Instance.new("TextButton")
noclipButton.Size = UDim2.new(0.9, 0, 0, 40)
noclipButton.Position = UDim2.new(0.05, 0, 0, yPos + 105)
noclipButton.BackgroundColor3 = Color3.fromRGB(200, 100, 0)
noclipButton.Text = "Toggle Noclip"
noclipButton.TextColor3 = Color3.new(1,1,1)
noclipButton.TextScaled = true
noclipButton.Parent = frame

local noclipping = false
noclipButton.MouseButton1Click:Connect(function()
    noclipping = not noclipping
    print("Noclip: " .. (noclipping and "ON 🐹" or "OFF"))
end)

RunService.Stepped:Connect(function()
    if noclipping and character then
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end
end)

-- Simple Autofarm Logic (auto cast, shake, catch loop - works in most fishing spots)
local function startAutofarm()
    if autofarming then return end
    autofarming = true
    print("🚀 Autofarm STARTED in Carrot Garden style - AFK farming XP & money! Use a good rod.")
    
    spawn(function()
        while autofarming and player.Character do
            -- Auto cast (simulate tool activation)
            local tool = player.Character:FindFirstChildOfClass("Tool")
            if tool and tool:FindFirstChild("Cast") then
                tool.Cast:FireServer()  -- Adjust if needed for Fisch fishing tool
            end
            
            wait(1.5)  -- Wait for bite
            
            -- Auto shake / reel (spam input for minigame)
            for i = 1, 25 do
                game:GetService("VirtualInputManager"):SendMouseButtonEvent(0,0,0,false,game,0) -- left click spam
                wait(0.05)
            end
            
            wait(0.8)
            -- Auto catch
            if tool then
                -- Common catch method in Fisch scripts
                game.ReplicatedStorage:WaitForChild("events"):WaitForChild("reelFinished"):FireServer(true) -- tweak if needed
            end
            
            wait(2)  -- Loop delay (tune based on your rod)
        end
    end)
end

local function stopAutofarm()
    autofarming = false
    print("🛑 Autofarm STOPPED")
end

farmButton.MouseButton1Click:Connect(function()
    if autofarming then 
        stopAutofarm() 
    else 
        startAutofarm() 
    end
end)

-- Fly logic (unchanged from before)
local function startFly()
    if flying then return end
    flying = true
    bodyVel = Instance.new("BodyVelocity")
    bodyVel.MaxForce = Vector3.new(1e5, 1e5, 1e5)
    bodyVel.Parent = root
    
    bodyGyro = Instance.new("BodyGyro")
    bodyGyro.MaxTorque = Vector3.new(1e5, 1e5, 1e5)
    bodyGyro.Parent = root
end

local function stopFly()
    flying = false
    if bodyVel then bodyVel:Destroy() end
    if bodyGyro then bodyGyro:Destroy() end
end

flyButton.MouseButton1Click:Connect(function()
    if flying then stopFly() else startFly() end
end)

UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.F then
        if flying then stopFly() else startFly() end
    end
end)

speedSlider.FocusLost:Connect(function()
    local num = tonumber(speedSlider.Text:match("%d+"))
    if num then speed = num end
    speedSlider.Text = "Fly Speed: " .. speed
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

print("✅ Noah's full Fisch GUI loaded in JJSploit! Drag the window, fly with F, teleport to Carrot Garden, then toggle Autofarm and go AFK for massive gains 🐹💰🐟")
print("Tip: Equip your best rod first, teleport to Carrot Garden, turn on noclip + fly + autofarm = profit while you chill!")
