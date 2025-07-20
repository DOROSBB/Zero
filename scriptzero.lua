local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local baseBlockName = "BaseBlock" -- Cambia esto al nombre exacto del bloqueo base

-- Crear GUI
local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "TPBlockMenu"

local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 280, 0, 120)
Frame.Position = UDim2.new(0.05, 0, 0.3, 0)
Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Frame.Active = true
Frame.Draggable = true

local UICorner = Instance.new("UICorner", Frame)
UICorner.CornerRadius = UDim.new(0, 12)

local Title = Instance.new("TextLabel", Frame)
Title.Text = "Teleport Bloqueo Base"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 24
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Position = UDim2.new(0, 0, 0, 0)

local TeleportButton = Instance.new("TextButton", Frame)
TeleportButton.Size = UDim2.new(0.9, 0, 0, 50)
TeleportButton.Position = UDim2.new(0.05, 0, 0, 60)
TeleportButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
TeleportButton.TextColor3 = Color3.fromRGB(255, 255, 255)
TeleportButton.Text = "Teleport a Bloqueo Base"
TeleportButton.Font = Enum.Font.GothamBold
TeleportButton.TextSize = 20

local cornerBtn = Instance.new("UICorner", TeleportButton)
cornerBtn.CornerRadius = UDim.new(0, 10)

TeleportButton.MouseButton1Click:Connect(function()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        local bloque = workspace:FindFirstChild(baseBlockName)
        if bloque and bloque:IsA("BasePart") then
            char.HumanoidRootPart.CFrame = bloque.CFrame + Vector3.new(0,5,0)
        else
            warn("No se encontró el objeto de bloqueo base con nombre: "..baseBlockName)
        end
    end
end)
