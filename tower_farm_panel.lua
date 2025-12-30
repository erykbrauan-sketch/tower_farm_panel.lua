-- TOWER PANEL + AUTO FARM | Roblox

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local root = character:WaitForChild("HumanoidRootPart")

local noclip = false
local autoUp = false
local autoMoney = false
local autoEgg = false

local NORMAL_SPEED = 16
local FAST_SPEED = 60
local UP_SPEED = 1.5

player.CharacterAdded:Connect(function(char)
    character = char
    humanoid = char:WaitForChild("Humanoid")
    root = char:WaitForChild("HumanoidRootPart")
end)

-- NOCLIP
RunService.Stepped:Connect(function()
    if noclip and character then
        for _, v in pairs(character:GetDescendants()) do
            if v:IsA("BasePart") then
                v.CanCollide = false
            end
        end
    end
end)

-- AUTO SUBIR
RunService.Heartbeat:Connect(function()
    if autoUp and root then
        root.CFrame = root.CFrame + Vector3.new(0, UP_SPEED, 0)
    end
end)

-- AUTO COLETAR
task.spawn(function()
    while task.wait(0.5) do
        if (autoMoney or autoEgg) and root then
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj:IsA("BasePart") then
                    local name = obj.Name:lower()

                    if autoMoney and (name:find("coin") or name:find("money") or name:find("cash")) then
                        root.CFrame = obj.CFrame + Vector3.new(0, 2, 0)
                    end

                    if autoEgg and name:find("egg") then
                        root.CFrame = obj.CFrame + Vector3.new(0, 2, 0)
                    end
                end
            end
        end
    end
end)

-- GUI
local gui = Instance.new("ScreenGui", player.PlayerGui)
gui.Name = "TowerPanel"
gui.ResetOnSpawn = false

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 240, 0, 340)
frame.Position = UDim2.new(0, 20, 0.5, -170)
frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 40)
title.Text = "Tower Farm Panel"
title.TextColor3 = Color3.new(1,1,1)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 18

local function button(text, y, color, callback)
    local b = Instance.new("TextButton", frame)
    b.Size = UDim2.new(1, -20, 0, 35)
    b.Position = UDim2.new(0, 10, 0, y)
    b.Text = text
    b.BackgroundColor3 = color
    b.TextColor3 = Color3.new(1,1,1)
    b.Font = Enum.Font.Gotham
    b.TextSize = 14
    b.BorderSizePixel = 0
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)
    b.MouseButton1Click:Connect(callback)
end

button("Noclip ON / OFF", 50, Color3.fromRGB(80,80,80), function()
    noclip = not noclip
end)

button("Speed ON", 95, Color3.fromRGB(0,170,0), function()
    humanoid.WalkSpeed = FAST_SPEED
end)

button("Speed Normal", 140, Color3.fromRGB(170,170,0), function()
    humanoid.WalkSpeed = NORMAL_SPEED
end)

button("Auto Subir (AFK)", 185, Color3.fromRGB(0,120,255), function()
    autoUp = not autoUp
end)

button("Auto Coletar Dinheiro", 230, Color3.fromRGB(0,200,150), function()
    autoMoney = not autoMoney
end)

button("Auto Coletar Ovos", 275, Color3.fromRGB(200,100,255), function()
    autoEgg = not autoEgg
end)

button("Fechar", 320, Color3.fromRGB(170,0,0), function()
    gui:Destroy()
end)
