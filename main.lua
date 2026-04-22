-- Five Nights: Hunted
-- Modern UI Edition mit flüssigen Animationen und Gradienten
-- Geschwindigkeitsregler, Barrieren-Deaktivierer, Fliegen und NoClip

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local TweenService = game:GetService("TweenService")

-- Modern GUI Erstellung mit Animationen
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.IgnoreGuiInset = true

-- Modernes Hauptfenster mit Gradienten und Animationen
local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui
MainFrame.Size = UDim2.new(0, 380, 0, 650)
MainFrame.Position = UDim2.new(0.5, -190, 0.5, -325)
MainFrame.BackgroundColor3 = Color3.new(0.08, 0.08, 0.12)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true

-- Gradient Overlay für modernen Look
local MainGradient = Instance.new("UIGradient")
MainGradient.Parent = MainFrame
MainGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.new(0.15, 0.1, 0.25)),
    ColorSequenceKeypoint.new(0.5, Color3.new(0.1, 0.08, 0.18)),
    ColorSequenceKeypoint.new(1, Color3.new(0.05, 0.05, 0.1))
}
MainGradient.Rotation = 45

-- Rounded Corners
local MainCorner = Instance.new("UICorner")
MainCorner.Parent = MainFrame
MainCorner.CornerRadius = UDim.new(0, 20)

-- Glowing Border Effect
local MainStroke = Instance.new("UIStroke")
MainStroke.Parent = MainFrame
MainStroke.Color = Color3.new(0.3, 0.6, 1)
MainStroke.Thickness = 2
MainStroke.Transparency = 0.5

-- Moderner Titel mit Animation
local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.Size = UDim2.new(1, -40, 0, 50)
Title.Position = UDim2.new(0, 20, 0, 10)
Title.BackgroundTransparency = 1
Title.Text = "⚡ F.N. Hunted - Modern UI"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 22
Title.TextStrokeTransparency = 0.8
Title.TextStrokeColor3 = Color3.new(0.3, 0.6, 1)

-- Titel Animation
local TitleGradient = Instance.new("UIGradient")
TitleGradient.Parent = Title
TitleGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.new(0.8, 0.9, 1)),
    ColorSequenceKeypoint.new(0.5, Color3.new(1, 1, 1)),
    ColorSequenceKeypoint.new(1, Color3.new(0.8, 0.9, 1))
}

-- Moderne Button-Factory Funktion
local function createModernButton(name, position, text, icon)
    local button = Instance.new("TextButton")
    button.Parent = MainFrame
    button.Size = UDim2.new(0, 320, 0, 45)
    button.Position = position
    button.BackgroundColor3 = Color3.new(0.15, 0.15, 0.2)
    button.BorderSizePixel = 0
    button.Text = (icon and icon .. " " or "") .. text
    button.TextColor3 = Color3.new(0.9, 0.9, 0.9)
    button.Font = Enum.Font.Gotham
    button.TextSize = 16
    button.TextXAlignment = Enum.TextXAlignment.Left
    
    -- Rounded Corners
    local corner = Instance.new("UICorner")
    corner.Parent = button
    corner.CornerRadius = UDim.new(0, 12)
    
    -- Gradient
    local gradient = Instance.new("UIGradient")
    gradient.Parent = button
    gradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.new(0.2, 0.2, 0.25)),
        ColorSequenceKeypoint.new(1, Color3.new(0.15, 0.15, 0.2))
    }
    
    -- Hover Effect
    local hoverGradient = Instance.new("UIGradient")
    hoverGradient.Parent = button
    hoverGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.new(0.3, 0.6, 1)),
        ColorSequenceKeypoint.new(1, Color3.new(0.2, 0.4, 0.8))
    }
    hoverGradient.Transparency = 1
    
    -- Stroke
    local stroke = Instance.new("UIStroke")
    stroke.Parent = button
    stroke.Color = Color3.new(0.3, 0.6, 1)
    stroke.Thickness = 1
    stroke.Transparency = 0.7
    
    -- Animationen
    button.MouseEnter:Connect(function()
        local tween = TweenService:Create(hoverGradient, TweenInfo.new(0.3), {Transparency = 0})
        tween:Play()
        local scaleTween = TweenService:Create(button, TweenInfo.new(0.2), {Size = UDim2.new(0, 330, 0, 48)})
        scaleTween:Play()
    end)
    
    button.MouseLeave:Connect(function()
        local tween = TweenService:Create(hoverGradient, TweenInfo.new(0.3), {Transparency = 1})
        tween:Play()
        local scaleTween = TweenService:Create(button, TweenInfo.new(0.2), {Size = UDim2.new(0, 320, 0, 45)})
        scaleTween:Play()
    end)
    
    return button
end

-- Moderner Speed Slider
local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Parent = MainFrame
SpeedLabel.Size = UDim2.new(0, 150, 0, 25)
SpeedLabel.Position = UDim2.new(0, 30, 0, 80)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Text = "🚀 Speed: 1.0x"
SpeedLabel.TextColor3 = Color3.new(0.8, 0.9, 1)
SpeedLabel.Font = Enum.Font.Gotham
SpeedLabel.TextSize = 16
SpeedLabel.TextXAlignment = Enum.TextXAlignment.Left

local SpeedSlider = Instance.new("TextButton")
SpeedSlider.Parent = MainFrame
SpeedSlider.Size = UDim2.new(0, 320, 0, 8)
SpeedSlider.Position = UDim2.new(0, 30, 0, 110)
SpeedSlider.BackgroundColor3 = Color3.new(0.1, 0.1, 0.15)
SpeedSlider.BorderSizePixel = 0
SpeedSlider.Text = ""
SpeedSlider.AutoButtonColor = false

-- Slider Styling
local SliderCorner = Instance.new("UICorner")
SliderCorner.Parent = SpeedSlider
SliderCorner.CornerRadius = UDim.new(0, 4)

local SliderGradient = Instance.new("UIGradient")
SliderGradient.Parent = SpeedSlider
SliderGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.new(0.3, 0.6, 1)),
    ColorSequenceKeypoint.new(1, Color3.new(0.6, 0.3, 1))
}

-- Slider Fill (visual feedback)
local SliderFill = Instance.new("Frame")
SliderFill.Parent = SpeedSlider
SliderFill.Size = UDim2.new(0, 0, 1, 0)
SliderFill.Position = UDim2.new(0, 0, 0, 0)
SliderFill.BackgroundColor3 = Color3.new(0.3, 0.6, 1)
SliderFill.BorderSizePixel = 0

local FillCorner = Instance.new("UICorner")
FillCorner.Parent = SliderFill
FillCorner.CornerRadius = UDim.new(0, 4)

local FillGradient = Instance.new("UIGradient")
FillGradient.Parent = SliderFill
FillGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.new(0.3, 0.6, 1)),
    ColorSequenceKeypoint.new(1, Color3.new(0.6, 0.3, 1))
}

-- Moderne Buttons mit Icons und Animationen
local FlyButton = createModernButton("Fly", UDim2.new(0, 30, 0, 140), "Fliegen: AUS", "✈️")
local NoClipButton = createModernButton("NoClip", UDim2.new(0, 30, 0, 195), "NoClip: AUS", "👻")
local BarrierButton = createModernButton("Barrier", UDim2.new(0, 30, 0, 250), "Barrieren: AKTIV", "🛡️")
local ESPButton = createModernButton("ESP", UDim2.new(0, 30, 0, 305), "ESP: AUS", "👁️")
local InstaKillButton = createModernButton("InstaKill", UDim2.new(0, 30, 0, 360), "Insta-Kill: AUS", "⚔️")
local ATMFarmButton = createModernButton("ATMFarm", UDim2.new(0, 30, 0, 415), "ATM Farm: AUS", "💰")
local InvisibilityButton = createModernButton("Invisibility", UDim2.new(0, 30, 0, 470), "Unsichtbarkeit: AUS", "👤")
local SnakeButton = createModernButton("Snake", UDim2.new(0, 30, 0, 525), "Schlange: AUS", "🐍")

-- Moderner Close Button
local CloseButton = Instance.new("TextButton")
CloseButton.Parent = MainFrame
CloseButton.Size = UDim2.new(0, 40, 0, 40)
CloseButton.Position = UDim2.new(1, -50, 0, 10)
CloseButton.BackgroundColor3 = Color3.new(0.8, 0.2, 0.2)
CloseButton.BorderSizePixel = 0
CloseButton.Text = "✕"
CloseButton.TextColor3 = Color3.new(1, 1, 1)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 20

local CloseCorner = Instance.new("UICorner")
CloseCorner.Parent = CloseButton
CloseCorner.CornerRadius = UDim.new(0, 20)

local CloseGradient = Instance.new("UIGradient")
CloseGradient.Parent = CloseButton
CloseGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.new(0.9, 0.3, 0.3)),
    ColorSequenceKeypoint.new(1, Color3.new(0.7, 0.1, 0.1))
}

-- Close Button Animation
CloseButton.MouseEnter:Connect(function()
    local tween = TweenService:Create(CloseButton, TweenInfo.new(0.2), {Size = UDim2.new(0, 45, 0, 45)})
    tween:Play()
end)

CloseButton.MouseLeave:Connect(function()
    local tween = TweenService:Create(CloseButton, TweenInfo.new(0.2), {Size = UDim2.new(0, 40, 0, 40)})
    tween:Play()
end)

-- ==================== MODERNE SPIELERLISTEN-GUI ====================
local PlayerListFrame = Instance.new("Frame")
PlayerListFrame.Parent = ScreenGui
PlayerListFrame.Size = UDim2.new(0, 220, 0, 350)
PlayerListFrame.Position = UDim2.new(0, -240, 0.5, -175)
PlayerListFrame.BackgroundColor3 = Color3.new(0.08, 0.08, 0.12)
PlayerListFrame.BorderSizePixel = 0
PlayerListFrame.Active = true
PlayerListFrame.Draggable = true

-- Modernes Gradient für Player List
local PlayerListGradient = Instance.new("UIGradient")
PlayerListGradient.Parent = PlayerListFrame
PlayerListGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.new(0.12, 0.08, 0.18)),
    ColorSequenceKeypoint.new(1, Color3.new(0.06, 0.06, 0.1))
}
PlayerListGradient.Rotation = 135

local PlayerListCorner = Instance.new("UICorner")
PlayerListCorner.Parent = PlayerListFrame
PlayerListCorner.CornerRadius = UDim.new(0, 15)

local PlayerListStroke = Instance.new("UIStroke")
PlayerListStroke.Parent = PlayerListFrame
PlayerListStroke.Color = Color3.new(0.3, 0.6, 1)
PlayerListStroke.Thickness = 1.5
PlayerListStroke.Transparency = 0.6

local PlayerListTitle = Instance.new("TextLabel")
PlayerListTitle.Parent = PlayerListFrame
PlayerListTitle.Size = UDim2.new(1, -20, 0, 40)
PlayerListTitle.Position = UDim2.new(0, 10, 0, 5)
PlayerListTitle.BackgroundTransparency = 1
PlayerListTitle.Text = "🎯 Target Follow"
PlayerListTitle.TextColor3 = Color3.new(0.8, 0.9, 1)
PlayerListTitle.Font = Enum.Font.GothamBold
PlayerListTitle.TextSize = 16
PlayerListTitle.TextXAlignment = Enum.TextXAlignment.Left

-- Modernes ScrollingFrame
local PlayerScrollingFrame = Instance.new("ScrollingFrame")
PlayerScrollingFrame.Parent = PlayerListFrame
PlayerScrollingFrame.Size = UDim2.new(1, -15, 1, -55)
PlayerScrollingFrame.Position = UDim2.new(0, 10, 0, 50)
PlayerScrollingFrame.BackgroundColor3 = Color3.new(0.05, 0.05, 0.08)
PlayerScrollingFrame.BorderSizePixel = 0
PlayerScrollingFrame.ScrollBarThickness = 6
PlayerScrollingFrame.ScrollBarImageColor3 = Color3.new(0.3, 0.6, 1)
PlayerScrollingFrame.ScrollBarImageTransparency = 0.3

local ScrollCorner = Instance.new("UICorner")
ScrollCorner.Parent = PlayerScrollingFrame
ScrollCorner.CornerRadius = UDim.new(0, 8)

-- Layout für automatische Sortierung
local PlayerListLayout = Instance.new("UIListLayout")
PlayerListLayout.Parent = PlayerScrollingFrame
PlayerListLayout.SortOrder = Enum.SortOrder.Name
PlayerListLayout.Padding = UDim.new(0, 4)

-- ==================== MODERNE TELEPORT-SPIELERLISTEN-GUI ====================
local TPListFrame = Instance.new("Frame")
TPListFrame.Parent = ScreenGui
TPListFrame.Size = UDim2.new(0, 220, 0, 350)
TPListFrame.Position = UDim2.new(1, 10, 0.5, -175)
TPListFrame.BackgroundColor3 = Color3.new(0.08, 0.08, 0.12)
TPListFrame.BorderSizePixel = 0
TPListFrame.Active = true
TPListFrame.Draggable = true

-- Modernes Gradient für TP List
local TPListGradient = Instance.new("UIGradient")
TPListGradient.Parent = TPListFrame
TPListGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.new(0.18, 0.12, 0.08)),
    ColorSequenceKeypoint.new(1, Color3.new(0.1, 0.06, 0.06))
}
TPListGradient.Rotation = 135

local TPListCorner = Instance.new("UICorner")
TPListCorner.Parent = TPListFrame
TPListCorner.CornerRadius = UDim.new(0, 15)

local TPListStroke = Instance.new("UIStroke")
TPListStroke.Parent = TPListFrame
TPListStroke.Color = Color3.new(1, 0.8, 0.3)
TPListStroke.Thickness = 1.5
TPListStroke.Transparency = 0.6

local TPListTitle = Instance.new("TextLabel")
TPListTitle.Parent = TPListFrame
TPListTitle.Size = UDim2.new(1, -20, 0, 40)
TPListTitle.Position = UDim2.new(0, 10, 0, 5)
TPListTitle.BackgroundTransparency = 1
TPListTitle.Text = "⚡ TP to Me"
TPListTitle.TextColor3 = Color3.new(1, 0.9, 0.8)
TPListTitle.Font = Enum.Font.GothamBold
TPListTitle.TextSize = 16
TPListTitle.TextXAlignment = Enum.TextXAlignment.Left

-- Modernes TP ScrollingFrame
local TPScrollingFrame = Instance.new("ScrollingFrame")
TPScrollingFrame.Parent = TPListFrame
TPScrollingFrame.Size = UDim2.new(1, -15, 1, -55)
TPScrollingFrame.Position = UDim2.new(0, 10, 0, 50)
TPScrollingFrame.BackgroundColor3 = Color3.new(0.08, 0.05, 0.05)
TPScrollingFrame.BorderSizePixel = 0
TPScrollingFrame.ScrollBarThickness = 6
TPScrollingFrame.ScrollBarImageColor3 = Color3.new(1, 0.8, 0.3)
TPScrollingFrame.ScrollBarImageTransparency = 0.3

local TPScrollCorner = Instance.new("UICorner")
TPScrollCorner.Parent = TPScrollingFrame
TPScrollCorner.CornerRadius = UDim.new(0, 8)

local TPListLayout = Instance.new("UIListLayout")
TPListLayout.Parent = TPScrollingFrame
TPListLayout.SortOrder = Enum.SortOrder.Name
TPListLayout.Padding = UDim.new(0, 4)

-- Tabelle zum Speichern der Spieler-Buttons
local playerButtons = {}

-- Tabelle zum Speichern der TP-Spieler-Buttons
local tpPlayerButtons = {}

-- Moderne Button-Factory für Spielerlisten
local function createModernPlayerButton(name, parent, colorScheme)
    local button = Instance.new("TextButton")
    button.Parent = parent
    button.Size = UDim2.new(1, -10, 0, 35)
    button.BackgroundColor3 = Color3.new(0.1, 0.1, 0.15)
    button.BorderSizePixel = 0
    button.Text = name
    button.TextColor3 = Color3.new(0.9, 0.9, 0.9)
    button.Font = Enum.Font.Gotham
    button.TextSize = 14
    button.TextXAlignment = Enum.TextXAlignment.Left
    
    -- Modernes Styling
    local corner = Instance.new("UICorner")
    corner.Parent = button
    corner.CornerRadius = UDim.new(0, 8)
    
    local gradient = Instance.new("UIGradient")
    gradient.Parent = button
    gradient.Color = colorScheme.default
    
    local stroke = Instance.new("UIStroke")
    stroke.Parent = button
    stroke.Color = colorScheme.stroke
    stroke.Thickness = 1
    stroke.Transparency = 0.5
    
    -- Hover Animation
    local hoverGradient = Instance.new("UIGradient")
    hoverGradient.Parent = button
    hoverGradient.Color = colorScheme.hover
    hoverGradient.Transparency = 1
    
    button.MouseEnter:Connect(function()
        local tween = TweenService:Create(hoverGradient, TweenInfo.new(0.2), {Transparency = 0})
        tween:Play()
        local scaleTween = TweenService:Create(button, TweenInfo.new(0.15), {Size = UDim2.new(1, -5, 0, 38)})
        scaleTween:Play()
    end)
    
    button.MouseLeave:Connect(function()
        local tween = TweenService:Create(hoverGradient, TweenInfo.new(0.2), {Transparency = 1})
        tween:Play()
        local scaleTween = TweenService:Create(button, TweenInfo.new(0.15), {Size = UDim2.new(1, -10, 0, 35)})
        scaleTween:Play()
    end)
    
    return button
end

-- Farbschemata für verschiedene Listen
local playerColorScheme = {
    default = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.new(0.15, 0.15, 0.2)),
        ColorSequenceKeypoint.new(1, Color3.new(0.1, 0.1, 0.15))
    },
    hover = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.new(0.3, 0.6, 1)),
        ColorSequenceKeypoint.new(1, Color3.new(0.2, 0.4, 0.8))
    },
    active = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.new(0.2, 0.8, 0.2)),
        ColorSequenceKeypoint.new(1, Color3.new(0.1, 0.6, 0.1))
    },
    stroke = Color3.new(0.3, 0.6, 1)
}

local tpColorScheme = {
    default = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.new(0.2, 0.15, 0.1)),
        ColorSequenceKeypoint.new(1, Color3.new(0.15, 0.1, 0.05))
    },
    hover = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.new(1, 0.8, 0.3)),
        ColorSequenceKeypoint.new(1, Color3.new(0.8, 0.6, 0.2))
    },
    active = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.new(0.8, 0.8, 0.2)),
        ColorSequenceKeypoint.new(1, Color3.new(0.6, 0.6, 0.1))
    },
    stroke = Color3.new(1, 0.8, 0.3)
}

-- Variablen
local speedValue = 1.0
local barriersEnabled = true
local isDragging = false
local barrierParts = {}
local flying = false
local noClipEnabled = false
local flySpeed = 50
local bodyVelocity
local bodyGyro
-- NEU: ESP Variablen
local espEnabled = false
local espConnections = {}
local espObjects = {}
local instaKillEnabled = false
-- NEU: Target-Follow Variablen
local targetPlayer = nil
local isFollowing = false
local followConnection = nil
-- NEU: ATM-Raub Variablen
local atmFarmEnabled = false
local currentATM = nil
local isRobbing = false
local atmCooldown = 0
-- NEU: TP-Target Variable
local tpTargetPlayer = nil

local invisibilityEnabled = false
local originalTransparency = {}
local originalCharacterParts = {}
-- Füge diese Variable bei den anderen Variablen am Anfang hinzu
local cameraOffset = nil
-- Variablen für die Klon-Methode
local characterClone = nil
local originalCharacter = nil

-- NEU: Schlangen-Transformations-Variablen
local isSnake = false
local originalBodyParts = {}
local snakeModel = nil
local snakeParts = {}


-- Geschwindigkeitsfunktion mit Animationen
local function updateSpeed()
    if Humanoid then
        Humanoid.WalkSpeed = 16 * speedValue
    end
    SpeedLabel.Text = "🚀 Speed: " .. string.format("%.1f", speedValue) .. "x"
    
    -- Animate the slider fill
    local fillPercentage = (speedValue - 0.1) / 49.9
    local tween = TweenService:Create(SliderFill, TweenInfo.new(0.3), {Size = UDim2.new(fillPercentage, 0, 1, 0)})
    tween:Play()
end

-- Funktion zum Aktualisieren von Button-Zuständen mit Animationen
local function animateButtonState(button, isActive, activeText, inactiveText, activeColor, inactiveColor)
    local targetText = isActive and activeText or inactiveText
    local targetColor = isActive and activeColor or inactiveColor
    
    -- Text Animation
    local textTween = TweenService:Create(button, TweenInfo.new(0.3), {TextColor3 = targetColor})
    textTween:Play()
    
    -- Pulse Animation für aktive Zustände
    if isActive then
        local originalSize = button.Size
        local pulseTween = TweenService:Create(button, TweenInfo.new(0.2), {Size = UDim2.new(0, 325, 0, 48)})
        pulseTween:Play()
        pulseTween.Completed:Connect(function()
            local restoreTween = TweenService:Create(button, TweenInfo.new(0.2), {Size = originalSize})
            restoreTween:Play()
        end)
    end
    
    button.Text = button.Text:gsub("AN|AUS|AKTIV|DEAKTIV", targetText)
end


-- NEU: ESP Funktionen
local function createESP(player)
    if espObjects[player] then return end -- Verhindert doppelte Erstellung

    local character = player.Character
    if not character then return end

    espObjects[player] = {
        box = Drawing.new("Square"),
        name = Drawing.new("Text"),
        distance = Drawing.new("Text"),
        tracer = Drawing.new("Line")
    }

    local objects = espObjects[player]
    objects.box.Thickness = 1
    objects.box.Color = Color3.new(0, 1, 0)
    objects.box.Filled = false
    objects.box.Transparency = 1

    objects.name.Color = Color3.new(1, 1, 1)
    objects.name.Size = 14
    objects.name.Center = true
    objects.name.Outline = true
    objects.name.OutlineColor = Color3.new(0, 0, 0)

    objects.distance.Color = Color3.new(1, 1, 0)
    objects.distance.Size = 12
    objects.distance.Center = true
    objects.distance.Outline = true
    objects.distance.OutlineColor = Color3.new(0, 0, 0)

    objects.tracer.Color = Color3.new(1, 0, 0)
    objects.tracer.Thickness = 1
    objects.tracer.Transparency = 1
end

local function removeESP(player)
    if espObjects[player] then
        for _, drawing in pairs(espObjects[player]) do
            drawing:Remove()
        end
        espObjects[player] = nil
    end
end

local function updateESP()
    if not espEnabled then
        for player, _ in pairs(espObjects) do
            removeESP(player)
        end
        return
    end

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            if not espObjects[player] then
                createESP(player)
            end

            local rootPart = player.Character.HumanoidRootPart
            local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
            local pos, onScreen = Camera:WorldToViewportPoint(rootPart.Position)
            
            local objects = espObjects[player]
            if onScreen then
                local distance = (Camera.CFrame.Position - rootPart.Position).Magnitude
                local scale = 1000 / distance
                local headPos = Camera:WorldToViewportPoint(rootPart.Position + Vector3.new(0, humanoid.HipHeight, 0))
                local footPos = Camera:WorldToViewportPoint(rootPart.Position - Vector3.new(0, humanoid.HipHeight, 0))
                
                local height = math.abs(headPos.Y - footPos.Y)
                local width = height * 0.6

                -- Box
                objects.box.Size = Vector2.new(width, height)
                objects.box.Position = Vector2.new(pos.X - width / 2, pos.Y - height / 2)
                objects.box.Visible = true

                -- Name
                objects.name.Text = player.Name
                objects.name.Position = Vector2.new(pos.X, pos.Y - height / 2 - 15)
                objects.name.Visible = true

                -- Distance
                objects.distance.Text = string.format("%.0f m", distance)
                objects.distance.Position = Vector2.new(pos.X, pos.Y + height / 2 + 15)
                objects.distance.Visible = true

                -- Tracer
                objects.tracer.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
                objects.tracer.To = Vector2.new(pos.X, pos.Y)
                objects.tracer.Visible = true
            else
                -- Verstecke alle Objekte, wenn der Spieler außerhalb des Bildschirms ist
                for _, drawing in pairs(objects) do
                    drawing.Visible = false
                end
            end
        else
            -- Entferne ESP, wenn der Spieler kein Character mehr hat
            removeESP(player)
        end
    end
end

-- NEU: Verbesserte Unsichtbarkeits-Funktion
local function toggleInvisibility()
    invisibilityEnabled = not invisibilityEnabled
    
    if invisibilityEnabled then
        InvisibilityButton.Text = "Unsichtbarkeit: AN"
        InvisibilityButton.TextColor3 = Color3.new(0, 1, 0)
        
        -- Speichere alle Original-Transparenzwerte
        for _, part in pairs(Character:GetDescendants()) do
            if part:IsA("BasePart") then
                originalTransparency[part] = part.Transparency
                part.Transparency = 1
            elseif part:IsA("Decal") or part:IsA("Texture") then
                originalTransparency[part] = part.Transparency
                part.Transparency = 1
            end
        end
        
        -- Verstecke den HumanoidRootPart komplett
        if Character:FindFirstChild("HumanoidRootPart") then
            Character.HumanoidRootPart.Transparency = 1
        end
        
        -- Verstecke den Namen über dem Kopf
        local head = Character:FindFirstChild("Head")
        if head and head:FindFirstChild("NameTag") then
            head.NameTag.Visible = false
        end
        
        -- Deaktiviere die Schatten
        if Humanoid then
            Humanoid.MaxHealth = 0
            Humanoid.Health = 0
            wait()
            Humanoid.MaxHealth = 100
            Humanoid.Health = 100
        end
        
    else
        InvisibilityButton.Text = "Unsichtbarkeit: AUS"
        InvisibilityButton.TextColor3 = Color3.new(1, 0, 0)
        
        -- Stelle alle ursprünglichen Transparenzwerte wieder her
        for part, transparency in pairs(originalTransparency) do
            if part and part.Parent then
                part.Transparency = transparency
            end
        end
        
        -- Zeige den Namen über dem Kopf wieder
        local head = Character:FindFirstChild("Head")
        if head and head:FindFirstChild("NameTag") then
            head.NameTag.Visible = true
        end
        
        -- Leere die Tabelle
        originalTransparency = {}
    end
end

-- NEU: Partikel-Effekt-Show
local function startParticleShow()
    if not Character or not Character:FindFirstChild("HumanoidRootPart") then return end
    
    local rootPart = Character.HumanoidRootPart
    
    -- Erstelle verschiedene Partikel-Effekte
    for i = 1, 10 do
        local particle = Instance.new("ParticleEmitter")
        particle.Color = ColorSequence.new(Color3.new(math.random(), math.random(), math.random()))
        particle.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 1)})
        particle.LightEmission = 0.5
        particle.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 2), NumberSequenceKeypoint.new(1, 5)})
        particle.Texture = "rbxassetid://247312807"
        particle.Lifetime = NumberRange.new(1, 3)
        particle.Rate = 100
        particle.Speed = NumberRange.new(5, 10)
        particle.SpreadAngle = Vector2.new(0, 360)
        particle.Parent = rootPart
        
        -- Zerstöre den Partikel-Effekt nach 10 Sekunden
        spawn(function()
            wait(10)
            particle:Destroy()
        end)
    end
    
    -- Sende eine Nachricht an alle Spieler
    local message = Instance.new("Message")
    message.Text = LocalPlayer.Name .. " startet eine Partikel-Show!"
    message.Parent = workspace
    
    wait(3)
    message:Destroy()
end

-- NEU: Schlangen-Transformationsfunktion
local function toggleSnake()
    isSnake = not isSnake
    
    if isSnake then
        SnakeButton.Text = "Schlange: AN"
        SnakeButton.TextColor3 = Color3.new(0, 1, 0)
        
        -- Speichere die ursprünglichen Körperteile
        for _, part in pairs(Character:GetChildren()) do
            if part:IsA("BasePart") then
                originalBodyParts[part.Name] = {
                    Part = part:Clone(),
                    Parent = part.Parent
                }
                part.Transparency = 1
                part.CanCollide = false
            end
        end
        
        -- Erstelle ein neues Schlangenmodell
        snakeModel = Instance.new("Model")
        snakeModel.Name = "SnakeModel"
        snakeModel.Parent = Character
        
        -- Erstelle den Schlangenkörper
        local snakeColors = {Color3.new(0.2, 0.8, 0.2), Color3.new(0.1, 0.6, 0.1)}
        local segmentCount = 10
        local segmentSize = Vector3.new(2, 2, 3)
        
        for i = 1, segmentCount do
            local segment = Instance.new("Part")
            segment.Size = segmentSize
            segment.Color = snakeColors[math.random(1, 2)]
            segment.Material = Enum.Material.Plastic
            segment.TopSurface = Enum.SurfaceType.Smooth
            segment.BottomSurface = Enum.SurfaceType.Smooth
            segment.CanCollide = false
            segment.Parent = snakeModel
            
            table.insert(snakeParts, segment)
            
            -- Füge einen Mesh hinzu, damit es wie eine Schlangen-Segment aussieht
            local mesh = Instance.new("SpecialMesh")
            mesh.MeshType = Enum.MeshType.Sphere
            mesh.Scale = Vector3.new(1, 0.7, 1.5)
            mesh.Parent = segment
        end
        
        -- Erstelle den Kopf
        local head = Instance.new("Part")
        head.Size = Vector3.new(3, 3, 4)
        head.Color = Color3.new(0.1, 0.5, 0.1)
        head.Material = Enum.Material.Plastic
        head.TopSurface = Enum.SurfaceType.Smooth
        head.BottomSurface = Enum.SurfaceType.Smooth
        head.CanCollide = false
        head.Parent = snakeModel
        
        local headMesh = Instance.new("SpecialMesh")
        headMesh.MeshType = Enum.MeshType.Sphere
        headMesh.Scale = Vector3.new(1, 0.8, 1.2)
        headMesh.Parent = head
        
        -- Füge Augen hinzu
        for i = -1, 1, 2 do
            local eye = Instance.new("Part")
            eye.Size = Vector3.new(0.5, 0.5, 0.5)
            eye.Color = Color3.new(1, 0, 0)
            eye.Material = Enum.Material.Neon
            eye.CanCollide = false
            eye.Parent = snakeModel
            
            local eyeWeld = Instance.new("Weld")
            eyeWeld.Part0 = head
            eyeWeld.Part1 = eye
            eyeWeld.C0 = CFrame.new(i * 0.8, 0.5, 1)
            eyeWeld.Parent = eye
        end
        
        -- Füge eine Zunge hinzu
        local tongue = Instance.new("Part")
        tongue.Size = Vector3.new(0.2, 0.2, 3)
        tongue.Color = Color3.new(1, 0, 0)
        tongue.Material = Enum.Material.Neon
        tongue.CanCollide = false
        tongue.Parent = snakeModel
        
        local tongueWeld = Instance.new("Weld")
        tongueWeld.Part0 = head
        tongueWeld.Part1 = tongue
        tongueWeld.C0 = CFrame.new(0, 0, 2)
        tongueWeld.Parent = tongue
        
        -- Verbinde alle Segmente mit Welds
        local lastPart = head
        for i, segment in pairs(snakeParts) do
            local weld = Instance.new("Weld")
            weld.Part0 = lastPart
            weld.Part1 = segment
            weld.C0 = CFrame.new(0, 0, -segmentSize.Z / 2 - 1)
            weld.Parent = segment
            lastPart = segment
        end
        
        -- Positioniere die Schlange am HumanoidRootPart
        if Character:FindFirstChild("HumanoidRootPart") then
            local rootWeld = Instance.new("Weld")
            rootWeld.Part0 = Character.HumanoidRootPart
            rootWeld.Part1 = head
            rootWeld.C0 = CFrame.new(0, 0, 0)
            rootWeld.Parent = head
        end
        
        -- Ändere die Bewegungsgeschwindigkeit
        if Humanoid then
            Humanoid.WalkSpeed = 8
        end
        
        -- Füge eine schlangenförmige Animation hinzu
        spawn(function()
            while isSnake do
                for i, segment in pairs(snakeParts) do
                    if segment and segment.Parent then
                        local offset = math.sin(tick() * 2 + i * 0.5) * 0.3
                        segment.CFrame = segment.CFrame * CFrame.new(offset, 0, 0)
                    end
                end
                wait(0.1)
            end
        end)
          else
        SnakeButton.Text = "Schlange: AUS"
        SnakeButton.TextColor3 = Color3.new(1, 0, 0)
        
        -- Zerstöre das Schlangenmodell
        if snakeModel then
            snakeModel:Destroy()
            snakeModel = nil
        end
        
        -- Stelle die ursprünglichen Körperteile wieder her
        for name, data in pairs(originalBodyParts) do
            if data.Part and Character:FindFirstChild(name) then
                Character[name]:Destroy()
                data.Part.Parent = Character
            end
        end
        
        -- Leere die Tabellen
        originalBodyParts = {}
        snakeParts = {}
        
        -- Stelle die ursprüngliche Bewegungsgeschwindigkeit wieder her
        if Humanoid then
            Humanoid.WalkSpeed = 16 * speedValue
        end
    end
end

-- NEU: Tanz-Animation
local function startDance()
    if not Character or not Humanoid then return end
    
    -- Erstelle eine neue Animation
    local danceAnim = Instance.new("Animation")
    danceAnim.AnimationId = "rbxassetid://507777136" -- Beispiel-Tanz-Animation
    
    -- Lade die Animation
    local animator = Humanoid:FindFirstChild("Animator")
    if not animator then
        animator = Instance.new("Animator")
        animator.Parent = Humanoid
    end
    
    local danceTrack = animator:LoadAnimation(danceAnim)
    danceTrack:Play()
    
    -- Sende eine Nachricht an alle Spieler
    local message = Instance.new("Message")
    message.Text = LocalPlayer.Name .. " tanzt wie nie zuvor!"
    message.Parent = workspace
    
    wait(3)
    message:Destroy()
    
    -- Stoppe die Animation nach 10 Sekunden
    wait(7)
    danceTrack:Stop()
end

-- NEU: Insta-Kill Funktion
local function onHit(hitPart)
    if not instaKillEnabled then return end
    
    local character = hitPart.Parent
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    
    -- Überprüfen, ob es ein gültiger Gegner ist (nicht du selbst)
    if humanoid and humanoid ~= Humanoid and character ~= Character then
        -- Setze die Gesundheit des Gegners auf 0
        humanoid.Health = 0
    end
end

-- ==================== NEUE TARGET-FOLLOW FUNKTIONEN ====================

-- Modernisierte Spielerlisten-Funktionen
local function createOrUpdatePlayerButton(player)
    if player == LocalPlayer then return end

    local button = playerButtons[player]
    if not button then
        button = createModernPlayerButton(player.Name, PlayerScrollingFrame, playerColorScheme)
        playerButtons[player] = button
    end
    
    -- Aktualisiere Button-Status mit Animation
    if isFollowing and targetPlayer == player then
        button.Text = player.Name .. " [🎯 FOLLOWING]"
        -- Aktive Farbe mit Animation
        local gradient = button:FindFirstChild("UIGradient")
        if gradient then
            gradient.Color = playerColorScheme.active
        end
    else
        button.Text = player.Name
        local gradient = button:FindFirstChild("UIGradient")
        if gradient then
            gradient.Color = playerColorScheme.default
        end
    end
end

local function createOrUpdateTPPlayerButton(player)
    if player == LocalPlayer then return end

    local button = tpPlayerButtons[player]
    if not button then
        button = createModernPlayerButton(player.Name, TPScrollingFrame, tpColorScheme)
        tpPlayerButtons[player] = button
    end
    
    -- Aktualisiere TP-Button-Status mit Animation
    if tpTargetPlayer == player then
        button.Text = player.Name .. " [⚡ TARGET]"
        local gradient = button:FindFirstChild("UIGradient")
        if gradient then
            gradient.Color = tpColorScheme.active
        end
    else
        button.Text = player.Name
        local gradient = button:FindFirstChild("UIGradient")
        if gradient then
            gradient.Color = tpColorScheme.default
        end
    end
end

-- Hilfsfunktionen für Spielerlisten
local function removePlayerButton(player)
    if playerButtons[player] then
        playerButtons[player]:Destroy()
        playerButtons[player] = nil
    end
end

local function updatePlayerList()
    -- Alte Buttons entfernen
    for player, _ in pairs(playerButtons) do
        if not Players:FindFirstChild(player.Name) then
            removePlayerButton(player)
        end
    end
    
    -- Buttons für aktuelle Spieler erstellen/aktualisieren
    for _, player in pairs(Players:GetPlayers()) do
        createOrUpdatePlayerButton(player)
    end
    
    -- Canvas Größe anpassen
    PlayerScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, PlayerListLayout.AbsoluteContentSize.Y)
end

local function updateTPPlayerList()
    -- Alte TP-Buttons entfernen
    for player, _ in pairs(tpPlayerButtons) do
        if not Players:FindFirstChild(player.Name) then
            removeTPPlayerButton(player)
        end
    end
    
    -- TP-Buttons für aktuelle Spieler erstellen/aktualisieren
    for _, player in pairs(Players:GetPlayers()) do
        createOrUpdateTPPlayerButton(player)
    end
    
    -- Canvas Größe anpassen
    TPScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, TPListLayout.AbsoluteContentSize.Y)
end

-- Toggle Follow Funktion mit Animation
local function toggleFollow(playerToFollow)
    if isFollowing and targetPlayer == playerToFollow then
        isFollowing = false
        targetPlayer = nil
        if followConnection then
            followConnection:Disconnect()
            followConnection = nil
        end
        print("Folgen beendet.")
    else
        if isFollowing and followConnection then
            followConnection:Disconnect()
        end
        isFollowing = true
        targetPlayer = playerToFollow
        print("Folge jetzt: " .. targetPlayer.Name)

        followConnection = RunService.Heartbeat:Connect(function()
            if isFollowing and targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") and Character and Character:FindFirstChild("HumanoidRootPart") then
                local targetCFrame = targetPlayer.Character.HumanoidRootPart.CFrame
                Character.HumanoidRootPart.CFrame = targetCFrame * CFrame.new(0, 0, 3)
            else
                if isFollowing then
                    print("Ziel verloren. Folgen wird beendet.")
                    toggleFollow(targetPlayer)
                end
            end
        end)
    end
    updatePlayerList() -- Update buttons to show new state
end

-- Select TP Target Funktion mit Animation
local function selectTPTarget(playerToTP)
    if tpTargetPlayer == playerToTP then
        tpTargetPlayer = nil
        print("TP-Ziel entfernt.")
    else
        tpTargetPlayer = playerToTP
        print("TP-Ziel gesetzt: " .. tpTargetPlayer.Name)
    end
    updateTPPlayerList() -- Update buttons to show new state
end

local function toggleInstaKill()
    instaKillEnabled = not instaKillEnabled
    if instaKillEnabled then
        InstaKillButton.Text = "Insta-Kill: AN"
        InstaKillButton.TextColor3 = Color3.new(0, 1, 0)
        
        -- Funktion, um die Events zu verbinden
        local function connectToCharacter(char)
            if not char then return end
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    local connection = part.Touched:Connect(onHit)
                    if not espConnections["InstaKill"] then espConnections["InstaKill"] = {} end
                    table.insert(espConnections["InstaKill"], connection)
                end
            end
        end

        -- Verbinde mit dem aktuellen Charakter
        connectToCharacter(Character)
        
        -- Verbinde erneut, wenn der Charakter respawnt
        espConnections.InstakillRespawn = LocalPlayer.CharacterAdded:Connect(connectToCharacter)

    else
        InstaKillButton.Text = "Insta-Kill: AUS"
        InstaKillButton.TextColor3 = Color3.new(1, 0, 0)
        
        -- Trenne alle Verbindungen
        if espConnections["InstaKill"] then
            for _, connection in pairs(espConnections["InstaKill"]) do
                connection:Disconnect()
            end
            espConnections["InstaKill"] = nil
        end
        if espConnections.InstakillRespawn then
            espConnections.InstakillRespawn:Disconnect()
            espConnections.InstakillRespawn = nil
        end
    end
end


-- Verbesserte Version mit serverseitiger Validierung
local function teleportTargetToMe()
    if tpTargetPlayer and tpTargetPlayer.Character and tpTargetPlayer.Character:FindFirstChild("HumanoidRootPart") 
       and Character and Character:FindFirstChild("HumanoidRootPart") then
        
        -- Versuche, den Spieler zu teleportieren
        local targetHRP = tpTargetPlayer.Character.HumanoidRootPart
        local myHRP = Character.HumanoidRootPart
        
        -- Speichere die ursprüngliche Position
        local originalPosition = targetHRP.CFrame
        
        -- Teleport-Versuch
        targetHRP.CFrame = myHRP.CFrame * CFrame.new(0, 0, 3)
        
        -- Warte kurz und prüfe, ob der Teleport "gehalten" hat
        wait(0.1)
        
        if (targetHRP.Position - myHRP.Position).Magnitude > 5 then
            print("Teleport erfolgreich!")
        else
            print("Teleport wurde vom Server korrigiert - funktioniert nicht zuverlässig")
            -- Optional: Teleportiere dich stattdessen zum Ziel
            -- myHRP.CFrame = originalPosition * CFrame.new(0, 0, 3)
        end
    end
end

local function toggleESP()
    espEnabled = not espEnabled
    if espEnabled then
        ESPButton.Text = "ESP: AN"
        ESPButton.TextColor3 = Color3.new(0, 1, 0)
    else
        ESPButton.Text = "ESP: AUS"
        ESPButton.TextColor3 = Color3.new(1, 0, 0)
        -- Räume alle bestehenden ESPs auf
        for player, _ in pairs(espObjects) do
            removeESP(player)
        end
    end
end

-- ==================== NEUE ATM-RAUB-FUNKTIONEN ====================

-- Funktion zum Finden des nächsten verfügbaren ATMs
local function findNearestAvailableATM()
    local nearestATM = nil
    local shortestDistance = math.huge
    local playerRoot = Humanoid.Parent:FindFirstChild("HumanoidRootPart")

    if not playerRoot then return nil end

    -- Wir gehen davon aus, dass ATMs einen bestimmten Namen haben, z.B. "ATM", "MoneyMachine" etc.
    -- Passe die Namen bei Bedarf an dein Spiel an.
    local possibleATMNames = {"ATM", "MoneyMachine", "CashMachine", "Bankomat"}

    for _, obj in pairs(workspace:GetDescendants()) do
        for _, name in pairs(possibleATMNames) do
            if obj.Name:lower():find(name:lower()) and obj:IsA("Model") then
                -- Überprüfen, ob der ATM gerade ausgeraubt wird (oft ein BoolValue oder ein spezieller Zustand)
                local isBeingRobbed = obj:FindFirstChild("IsBeingRobbed") or obj:FindFirstChild("InUse")
                if not isBeingRobbed or (isBeingRobbed:IsA("BoolValue") and not isBeingRobbed.Value) then
                    local distance = (playerRoot.Position - obj.PrimaryPart.Position).Magnitude
                    if distance < shortestDistance then
                        shortestDistance = distance
                        nearestATM = obj
                    end
                end
            end
        end
    end
    return nearestATM
end

-- Funktion zum Starten des Raubs (simuliert das HALTEN der Taste)
local function startRobbery(atm)
    if not atm or not Character or not Humanoid or not Humanoid.Parent:FindFirstChild("HumanoidRootPart") then return end

    -- Teleportiere den Spieler zum ATM
    local hrp = Humanoid.Parent:FindFirstChild("HumanoidRootPart")
    hrp.CFrame = atm.PrimaryPart.CFrame * CFrame.new(0, 0, 3)

    -- Warte einen kurzen Moment, damit der Spieler "ankommt" und die Kollision sich setzt
    wait(0.5)

    -- Finde den VirtualInputManager
    local VirtualInputManager = game:GetService("VirtualInputManager")

    -- Simuliere das Drücken UND HALTEN der 'E'-Taste
    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, game)
    print("Halte 'E'-Taste für ATM: " .. atm.Name .. " gedrückt.")

    -- Warte, bis der Raub abgeschlossen ist (z.B. 5 Sekunden, passe dies an!)
    -- Passe diese Zeit an die Dauer des Raubs in deinem Spiel an!
    wait(5)

    -- Simuliere das Loslassen der 'E'-Taste
    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.E, false, game)
    print("'E'-Taste für ATM: " .. atm.Name .. " losgelassen.")

    -- Gib true zurück, um zu signalisieren, dass der Versuch stattgefunden hat
    return true
end
-- Hauptfunktion, die den Farm-Prozess steuert
local function farmATMs()
    if not atmFarmEnabled then return end

    -- Wenn wir gerade einen Raub durchführen, tu nichts
    if isRobbing then return end

    currentATM = findNearestAvailableATM()
    if currentATM then
        isRobbing = true
        print("Starte Raub an ATM: " .. currentATM.Name)
        local success = startRobbery(currentATM)
        
        if success then
            -- Nach dem Raub eine Pause einlegen, damit der ATM sich zurücksetzen kann
            -- Passe diese Zeit an die Abklingzeit im Spiel an (z.B. 30-60 Sekunden)
            atmCooldown = 45 
            print("Raub beendet. Warte auf Abklingzeit.")
        else
            -- Wenn etwas schiefging, nur eine kurze Pause
            atmCooldown = 5
            print("Raub fehlgeschlagen. Kurze Pause.")
        end
        
        isRobbing = false
        currentATM = nil
    else
        -- Wenn kein ATM gefunden wurde, warte eine Weile vor dem nächsten Versuch
        atmCooldown = 10
        print("Kein verfügbarer ATM gefunden. Warte 10 Sekunden.")
    end
end
-- Fliegen-Funktionen
local function startFly()
    if flying then return end
    
    flying = true
    FlyButton.Text = "Fliegen: AN"
    FlyButton.TextColor3 = Color3.new(0, 1, 0)
    
    bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.Velocity = Vector3.new(0, 0, 0)
    bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    bodyVelocity.Parent = Humanoid.RootPart
    
    bodyGyro = Instance.new("BodyGyro")
    bodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
    bodyGyro.P = 10000
    bodyGyro.Parent = Humanoid.RootPart
    
    Humanoid.PlatformStand = true
end

local function stopFly()
    if not flying then return end
    
    flying = false
    FlyButton.Text = "Fliegen: AUS"
    FlyButton.TextColor3 = Color3.new(1, 0, 0)
    
    if bodyVelocity then
        bodyVelocity:Destroy()
        bodyVelocity = nil
    end
    
    if bodyGyro then
        bodyGyro:Destroy()
        bodyGyro = nil
    end
    
    Humanoid.PlatformStand = false
end

local function controlFly()
    if not flying then return end
    
    local camera = workspace.CurrentCamera
    local moveDirection = Vector3.new(0, 0, 0)
    
    if UserInputService:IsKeyDown(Enum.KeyCode.W) then
        moveDirection = moveDirection + camera.CFrame.LookVector
    end
    if UserInputService:IsKeyDown(Enum.KeyCode.S) then
        moveDirection = moveDirection - camera.CFrame.LookVector
    end
    if UserInputService:IsKeyDown(Enum.KeyCode.A) then
        moveDirection = moveDirection - camera.CFrame.RightVector
    end
    if UserInputService:IsKeyDown(Enum.KeyCode.D) then
        moveDirection = moveDirection + camera.CFrame.RightVector
    end
    if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
        moveDirection = moveDirection + Vector3.new(0, 1, 0)
    end
    if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
        moveDirection = moveDirection - Vector3.new(0, 1, 0)
    end
    
    if bodyVelocity then
        bodyVelocity.Velocity = moveDirection * flySpeed * speedValue
    end
    
    if bodyGyro then
        bodyGyro.CFrame = camera.CFrame
    end
end

-- NoClip-Funktion
local function toggleNoClip()
    noClipEnabled = not noClipEnabled
    if noClipEnabled then
        NoClipButton.Text = "NoClip: AN"
        NoClipButton.TextColor3 = Color3.new(0, 1, 0)
    else
        NoClipButton.Text = "NoClip: AUS"
        NoClipButton.TextColor3 = Color3.new(1, 0, 0)
    end
end

-- Barrieren finden
local function findBarriers()
    barrierParts = {}
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Part") or obj:IsA("MeshPart") or obj:IsA("WedgePart") then
            if obj.Name:lower():find("barrier") or obj.Name:lower():find("wall") or obj.Name:lower():find("block") or obj.Name:lower():find("fence") then
                table.insert(barrierParts, obj)
            end
        end
    end
end

-- Barrieren umschalten
local function toggleBarriers()
    barriersEnabled = not barriersEnabled
    if barriersEnabled then
        BarrierButton.Text = "Barrieren: AKTIV"
        BarrierButton.TextColor3 = Color3.new(1, 0, 0)
        for _, part in pairs(barrierParts) do
            if part and part.Parent then
                part.CanCollide = true
                part.Transparency = 0
            end
        end
    else
        BarrierButton.Text = "Barrieren: DEAKTIV"
        BarrierButton.TextColor3 = Color3.new(0, 1, 0)
        for _, part in pairs(barrierParts) do
            if part and part.Parent then
                part.CanCollide = false
                part.Transparency = 0.5
            end
        end
    end
end

-- Slider-Steuerung Fly 
SpeedSlider.MouseButton1Down:Connect(function()
    isDragging = true
end)

UserInputService.InputChanged:Connect(function(input)
    if isDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local mousePos = input.Position
        local sliderPos = SpeedSlider.AbsolutePosition
        local sliderSize = SpeedSlider.AbsoluteSize
        
        local relativeX = math.clamp((mousePos.X - sliderPos.X) / sliderSize.X, 0, 1)
       speedValue = 0.1 + (relativeX * 49.9) -- 0.1 bis 50.0
        
        updateSpeed()
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        isDragging = false
    end
end)

-- Modernisierte Button-Event-Handler mit Animationen
FlyButton.MouseButton1Click:Connect(function()
    if flying then
        stopFly()
        animateButtonState(FlyButton, false, "Fliegen: AUS", "Fliegen: AN", Color3.new(1, 0, 0), Color3.new(0, 1, 0))
    else
        startFly()
        animateButtonState(FlyButton, true, "Fliegen: AN", "Fliegen: AUS", Color3.new(0, 1, 0), Color3.new(1, 0, 0))
    end
end)

NoClipButton.MouseButton1Click:Connect(function()
    toggleNoClip()
    animateButtonState(NoClipButton, noClipEnabled, "NoClip: AN", "NoClip: AUS", Color3.new(0, 1, 0), Color3.new(1, 0, 0))
end)

BarrierButton.MouseButton1Click:Connect(function()
    toggleBarriers()
    animateButtonState(BarrierButton, not barriersEnabled, "Barrieren: DEAKTIV", "Barrieren: AKTIV", Color3.new(0, 1, 0), Color3.new(1, 0, 0))
end)

ESPButton.MouseButton1Click:Connect(function()
    toggleESP()
    animateButtonState(ESPButton, espEnabled, "ESP: AN", "ESP: AUS", Color3.new(0, 1, 0), Color3.new(1, 0, 0))
end)

InstaKillButton.MouseButton1Click:Connect(function()
    toggleInstaKill()
    animateButtonState(InstaKillButton, instaKillEnabled, "Insta-Kill: AN", "Insta-Kill: AUS", Color3.new(0, 1, 0), Color3.new(1, 0, 0))
end)

ATMFarmButton.MouseButton1Click:Connect(function()
    atmFarmEnabled = not atmFarmEnabled
    if atmFarmEnabled then
        animateButtonState(ATMFarmButton, true, "ATM Farm: AN", "ATM Farm: AUS", Color3.new(0, 1, 0), Color3.new(1, 0, 0))
        print("ATM-Farm aktiviert.")
    else
        animateButtonState(ATMFarmButton, false, "ATM Farm: AUS", "ATM Farm: AN", Color3.new(1, 0, 0), Color3.new(0, 1, 0))
        print("ATM-Farm deaktiviert.")
        isRobbing = false
        currentATM = nil
    end
end)

InvisibilityButton.MouseButton1Click:Connect(function()
    toggleInvisibility()
    animateButtonState(InvisibilityButton, invisibilityEnabled, "Unsichtbarkeit: AN", "Unsichtbarkeit: AUS", Color3.new(0, 1, 0), Color3.new(1, 0, 0))
end)

SnakeButton.MouseButton1Click:Connect(function()
    toggleSnake()
    animateButtonState(SnakeButton, isSnake, "Schlange: AN", "Schlange: AUS", Color3.new(0, 1, 0), Color3.new(1, 0, 0))
end)

-- Führe die Farm-Funktion regelmäßig aus (z.B. jede Sekunde)
spawn(function()
    while ScreenGui.Parent do
        wait(1)
        farmATMs()
    end
end)

-- Event für den neuen Unsichtbarkeits-Button
DanceButton.MouseButton1Click:Connect(startDance)
ParticleButton.MouseButton1Click:Connect(startParticleShow)
SnakeButton.MouseButton1Click:Connect(toggleSnake)
InvisibilityButton.MouseButton1Click:Connect(toggleInvisibility)
ESPButton.MouseButton1Click:Connect(toggleESP)
NoClipButton.MouseButton1Click:Connect(toggleNoClip)
BarrierButton.MouseButton1Click:Connect(toggleBarriers)
InstaKillButton.MouseButton1Click:Connect(toggleInstaKill)
TPButton.MouseButton1Click:Connect(teleportTargetToMe)
CloseButton.MouseButton1Click:Connect(function()
    -- Räume alle ESP-Objekte auf
    for player, _ in pairs(espObjects) do
        removeESP(player)
    end
    -- Trenne alle Verbindungen (einschließlich Insta-Kill)
    for key, connections in pairs(espConnections) do
        if type(connections) == "table" then
            for _, connection in pairs(connections) do
                connection:Disconnect()
            end
        else
            connections:Disconnect()
        end
    end
    espConnections = {}
    ScreenGui:Destroy()
end)

-- NEU
RunService.Stepped:Connect(function()
    -- NoClip
    if noClipEnabled and Character and Humanoid then
        for _, part in pairs(Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
    
    -- Fliegen-Steuerung
    controlFly()
    
    -- NEU: ESP Update
    updateESP()
end)

-- Start-Animation für das gesamte GUI
local function animateGUIEntry()
    -- MainFrame Fade-in
    MainFrame.Position = UDim2.new(0.5, -190, 1, 0)
    local mainTween = TweenService:Create(MainFrame, TweenInfo.new(0.8, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Position = UDim2.new(0.5, -190, 0.5, -325)})
    mainTween:Play()
    
    -- PlayerList Slide-in von links
    PlayerListFrame.Position = UDim2.new(-1, 0, 0.5, -175)
    local playerListTween = TweenService:Create(PlayerListFrame, TweenInfo.new(0.6, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Position = UDim2.new(0, -240, 0.5, -175)})
    playerListTween:Play()
    
    -- TPList Slide-in von rechts
    TPListFrame.Position = UDim2.new(2, 0, 0.5, -175)
    local tpListTween = TweenService:Create(TPListFrame, TweenInfo.new(0.6, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Position = UDim2.new(1, 10, 0.5, -175)})
    tpListTween:Play()
    
    -- Titel Pulse Animation
    spawn(function()
        while ScreenGui.Parent do
            local pulseTween = TweenService:Create(Title, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1), {TextStrokeTransparency = 0.2})
            pulseTween:Play()
            wait(2)
        end
    end)
    
    -- Button Stagger Animation
    local buttons = {FlyButton, NoClipButton, BarrierButton, ESPButton, InstaKillButton, ATMFarmButton, InvisibilityButton, SnakeButton}
    for i, button in pairs(buttons) do
        if button then
            button.Position = button.Position + UDim2.new(0, 0, 1, 0)
            local delay = (i - 1) * 0.1
            spawn(function()
                wait(delay)
                local buttonTween = TweenService:Create(button, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Position = button.Position - UDim2.new(0, 0, 1, 0)})
                buttonTween:Play()
            end)
        end
    end
end

-- Initialisierung mit Animationen
findBarriers()
updateSpeed()
animateGUIEntry()

-- Automatische Aktualisierung der Barrieren
spawn(function()
    while ScreenGui.Parent do
        wait(5)
        findBarriers()
        if not barriersEnabled then
            for _, part in pairs(barrierParts) do
                if part and part.Parent then
                    part.CanCollide = false
                    part.Transparency = 0.5
                end
            end
        end
    end
end)

-- Spieler-Verbindungen für ESP
local function onPlayerAdded(player)
    local connection
    connection = player.CharacterAdded:Connect(function()
        if espEnabled then
            createESP(player)
        end
    end)
    espConnections[player] = connection
end

local function onPlayerRemoving(player)
    if player then
        removeESP(player)
        if espConnections[player] then
            espConnections[player]:Disconnect()
            espConnections[player] = nil
        end
    end
end

for _, player in pairs(Players:GetPlayers()) do
    onPlayerAdded(player)
end

Players.PlayerAdded:Connect(onPlayerAdded)
Players.PlayerRemoving:Connect(onPlayerRemoving)

-- ==================== ZENTRALE RESPAWN-FUNKTION (BEHEBT ALLE PROBLEME) ====================

-- Simplified respawn handler
LocalPlayer.CharacterAdded:Connect(function(newCharacter)
    Character = newCharacter
    Humanoid = Character:WaitForChild("Humanoid")
    
    -- Reset invisibility state
    if invisibilityEnabled then
        invisibilityEnabled = false
        InvisibilityButton.Text = "Unsichtbarkeit: AUS"
        InvisibilityButton.TextColor3 = Color3.new(1, 0, 0)
        originalTransparency = {}
        originalCharacterParts = {}
    end
    
    -- Reset other states as needed
    if noClipEnabled then
        toggleNoClip()
    end
    
    if flying then
        stopFly()
    end
    
    -- Update player lists
    updatePlayerList()
    updateTPPlayerList()
end)

-- ==================== EVENT-HANDLER FÜR MODERNE SPIELERLISTEN ====================

-- Event-Handler für Player-List Buttons
PlayerScrollingFrame.ChildAdded:Connect(function(child)
    if child:IsA("TextButton") then
        child.MouseButton1Click:Connect(function()
            local playerName = child.Text:gsub(" %[%w+%s*FOLLOWING%]", "")
            local player = Players:FindFirstChild(playerName)
            if player then
                toggleFollow(player)
            end
        end)
    end
end)

-- Event-Handler für TP-List Buttons
TPScrollingFrame.ChildAdded:Connect(function(child)
    if child:IsA("TextButton") then
        child.MouseButton1Click:Connect(function()
            local playerName = child.Text:gsub(" %[%w+%s*TARGET%]", "")
            local player = Players:FindFirstChild(playerName)
            if player then
                selectTPTarget(player)
            end
        end)
    end
end)

-- Spieler Join/Leave Events mit Animationen
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function()
        updatePlayerList()
        updateTPPlayerList()
    end)
    updatePlayerList()
    updateTPPlayerList()
end)

Players.PlayerRemoving:Connect(function(player)
    if targetPlayer == player then
        toggleFollow(player)
    end
    if tpTargetPlayer == player then
        tpTargetPlayer = nil
    end
    removeTPPlayerButton(player)
    removePlayerButton(player)
end)

-- Initiale Listen mit Animation
spawn(function()
    wait(1) -- Warte auf GUI-Animation
    updatePlayerList()
    updateTPPlayerList()
end)

-- Regelmäßige Updates
spawn(function()
    while ScreenGui.Parent do
        wait(5)
        updatePlayerList()
        updateTPPlayerList()
    end
end)

-- ==================== MODERNISIERTE CLOSE-FUNKTION ====================
CloseButton.MouseButton1Click:Connect(function()
    -- Close Animation
    local closeTween = TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
        Position = UDim2.new(0.5, -190, 1, 0),
        Size = UDim2.new(0, 380, 0, 0)
    })
    closeTween:Play()
    
    local playerListCloseTween = TweenService:Create(PlayerListFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
        Position = UDim2.new(-1, 0, 0.5, -175)
    })
    playerListCloseTween:Play()
    
    local tpListCloseTween = TweenService:Create(TPListFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
        Position = UDim2.new(2, 0, 0.5, -175)
    })
    tpListCloseTween:Play()
    
    -- Warte auf Animation und räume dann auf
    wait(0.6)
    
    -- Räume alle ESP-Objekte auf
    for player, _ in pairs(espObjects) do
        removeESP(player)
    end
    
    -- Trenne alle Verbindungen
    for key, connections in pairs(espConnections) do
        if type(connections) == "table" then
            for _, connection in pairs(connections) do
                connection:Disconnect()
            end
        else
            connections:Disconnect()
        end
    end
    espConnections = {}
    
    ScreenGui:Destroy()
end)

print("F.N. Hunted Multi-Hack geladen!")
print("Features: Geschwindigkeit, Fliegen, NoClip, Barrieren")
print("Fliegen-Steuerung: W/A/S/D zum Bewegen, Leertaste hoch, Strg runter")
