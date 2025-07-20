local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local RunService = game:GetService("RunService")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BrainrotMenu"
ScreenGui.Parent = PlayerGui

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 280, 0, 380)
Frame.Position = UDim2.new(0.05, 0, 0.25, 0)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.BorderSizePixel = 0
Frame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = Frame

local function crearBoton(texto, y, callback)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0.9, 0, 0, 45)
    button.Position = UDim2.new(0.05, 0, 0, y)
    button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Text = texto
    button.Font = Enum.Font.GothamBold
    button.TextSize = 20
    button.Parent = Frame

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = button

    button.MouseButton1Click:Connect(callback)
    return button
end

local speed_on = false
local jump_on = false

local speed_button = crearBoton("Speed (Off)", 10, function()
    speed_on = not speed_on
    speed_button.Text = speed_on and "Speed (On)" or "Speed (Off)"
end)

local jump_button = crearBoton("Super Jump (Off)", 65, function()
    jump_on = not jump_on
    jump_button.Text = jump_on and "Super Jump (On)" or "Super Jump (Off)"
end)

local baseBlockName = "BaseBlock" -- Cambia al nombre real del bloqueo base en tu mapa

crearBoton("Teleport a Bloqueo Base", 120, function()
    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    if char and char:FindFirstChild("HumanoidRootPart") then
        local bloque = workspace:FindFirstChild(baseBlockName)
        if bloque and bloque:IsA("BasePart") then
            char.HumanoidRootPart.CFrame = bloque.CFrame + Vector3.new(0, 5, 0)
        else
            warn("No se encontró el objeto para bloqueo base con nombre: "..baseBlockName)
        end
    end
end)

local baseCoords = Vector3.new(-114, 10, -25) -- Cambia aquí a las coordenadas de tu base personal

crearBoton("Teleport a Mi Base", 175, function()
    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    if char and char:FindFirstChild("HumanoidRootPart") then
        char.HumanoidRootPart.CFrame = CFrame.new(baseCoords)
    end
end)

crearBoton("Cerrar Menú", 230, function()
    ScreenGui:Destroy()
end)

-- Botón para explorar objetos cerca (5 studs)
crearBoton("Explorar Objetos Cercanos", 285, function()
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end

    local hrp = char.HumanoidRootPart
    local nearbyParts = {}

    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") then
            local dist = (obj.Position - hrp.Position).Magnitude
            if dist <= 10 then -- 10 studs rango para explorar
                table.insert(nearbyParts, obj)
            end
        end
    end

    print("Objetos cerca de tu personaje:")
    for _, part in pairs(nearbyParts) do
        print("Nombre:", part.Name, "Posición:", part.Position)
    end
end)

-- Mantener speed y jump activos si están encendidos
spawn(function()
    while task.wait(0.5) do
        local char = LocalPlayer.Character
        if char then
            local humanoid = char:FindFirstChild("Humanoid")
            if humanoid then
                if speed_on and humanoid.WalkSpeed ~= 50 then
                    humanoid.WalkSpeed = 50
                elseif not speed_on and humanoid.WalkSpeed ~= 16 then
                    humanoid.WalkSpeed = 16
                end

                if jump_on and humanoid.JumpPower ~= 120 then
                    humanoid.JumpPower = 120
                elseif not jump_on and humanoid.JumpPower ~= 50 then
                    humanoid.JumpPower = 50
                end
            end
        end
    end
end)

LocalPlayer.CharacterAdded:Connect(function(char)
    task.wait(1)
    local humanoid = char:WaitForChild("Humanoid")
    humanoid.WalkSpeed = speed_on and 50 or 16
    humanoid.JumpPower = jump_on and 120 or 50
end)
