local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local baseBlockName = "BaseBlock" -- Cambia al nombre real

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

local function findBaseBlock()
    local obj = workspace:FindFirstChild(baseBlockName)
    if obj then
        if obj:IsA("BasePart") then
            return obj.CFrame
        elseif obj:IsA("Model") and obj.PrimaryPart then
            return obj.PrimaryPart.CFrame
        else
            warn("El objeto encontrado no es BasePart ni Modelo con PrimaryPart")
            return nil
        end
    else
        warn("No se encontró el objeto con nombre: " .. baseBlockName)
        return nil
    end
end

TeleportButton.MouseButton1Click:Connect(function()
    local char = LocalPlayer.Character
    if not char then
        warn("Tu personaje no está cargado")
        return
    end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then
        warn("No se encontró HumanoidRootPart")
        return
    end

    local cf = findBaseBlock()
    if cf then
        hrp.CFrame = cf + Vector3.new(0,5,0)
    else
        warn("No se pudo obtener la posición para teleportar")
    end
end)
