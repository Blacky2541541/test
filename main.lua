-- Five Nights: Hunted
-- Modern UI Edition - SVG Icons & Toggle Animationen
-- Schwarzer Hintergrund mit blauen Akzenten und flüssigen Animationen

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local TweenService = game:GetService("TweenService")

-- Modern GUI mit schwarzem Hintergrund und blauen Akzenten
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.IgnoreGuiInset = true

-- Hauptfenster mit viereckigem Design
local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui
MainFrame.Size = UDim2.new(0, 380, 0, 800)
MainFrame.Position = UDim2.new(0.5, -190, 0.5, -400)
MainFrame.BackgroundColor3 = Color3.new(0.05, 0.05, 0.08)
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = Color3.new(0.2, 0.4, 0.8)
MainFrame.Active = true
MainFrame.Draggable = true

-- Glowing Border mit blauem Akzent
local MainStroke = Instance.new("UIStroke")
MainStroke.Parent = MainFrame
MainStroke.Color = Color3.new(0.2, 0.4, 0.8)
MainStroke.Thickness = 2
MainStroke.Transparency = 0.3

-- Moderner Titel mit SVG-Icon und Animation
local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.Size = UDim2.new(1, -60, 0, 50)
Title.Position = UDim2.new(0, 30, 0, 15)
Title.BackgroundTransparency = 1
Title.Text = "⚡ F.N. Hunted - Modern UI"
Title.TextColor3 = Color3.new(0.9, 0.9, 1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20
Title.TextStrokeTransparency = 0.8
Title.TextStrokeColor3 = Color3.new(0.2, 0.4, 0.8)

-- Titel Animation mit pulsierendem Effekt
spawn(function()
    while ScreenGui.Parent do
        local pulseTween = TweenService:Create(Title, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1), {TextStrokeTransparency = 0.2})
        pulseTween:Play()
        wait(2)
    end
end)

-- Speed Label mit modernem Design
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

-- Moderner Speed Slider mit blauen Akzenten
local SpeedSlider = Instance.new("TextButton")
SpeedSlider.Parent = MainFrame
SpeedSlider.Size = UDim2.new(0, 320, 0, 10)
SpeedSlider.Position = UDim2.new(0, 30, 0, 110)
SpeedSlider.BackgroundColor3 = Color3.new(0.1, 0.1, 0.15)
SpeedSlider.BorderSizePixel = 0
SpeedSlider.Text = ""
SpeedSlider.AutoButtonColor = false

-- Slider Styling
local SliderCorner = Instance.new("UICorner")
SliderCorner.Parent = SpeedSlider
SliderCorner.CornerRadius = UDim.new(0, 8)

local SliderGradient = Instance.new("UIGradient")
SliderGradient.Parent = SpeedSlider
SliderGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.new(0.1, 0.1, 0.15)),
    ColorSequenceKeypoint.new(1, Color3.new(0.15, 0.15, 0.2))
}

-- Slider Fill mit blauem Gradient
local SliderFill = Instance.new("Frame")
SliderFill.Parent = SpeedSlider
SliderFill.Size = UDim2.new(0, 0, 1, 0)
SliderFill.Position = UDim2.new(0, 0, 0, 0)
SliderFill.BorderSizePixel = 0

local FillCorner = Instance.new("UICorner")
FillCorner.Parent = SliderFill
FillCorner.CornerRadius = UDim.new(0, 8)

local FillGradient = Instance.new("UIGradient")
FillGradient.Parent = SliderFill
FillGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.new(0.2, 0.4, 0.8)),
    ColorSequenceKeypoint.new(1, Color3.new(0.3, 0.6, 1))
}

-- Modern Toggle Button Factory mit SVG Icons und Animationen
local function createModernToggle(name, position, text, icon, defaultColor, activeColor)
    local button = Instance.new("TextButton")
    button.Parent = MainFrame
    button.Size = UDim2.new(0, 320, 0, 45)
    button.Position = position
    button.BackgroundColor3 = defaultColor
    button.BorderSizePixel = 0
    button.Text = icon .. " " .. text
    button.TextColor3 = Color3.new(0.9, 0.9, 1)
    button.Font = Enum.Font.Gotham
    button.TextSize = 16
    button.TextXAlignment = Enum.TextXAlignment.Left
    
    -- Keine abgerundeten Ecken - viereckige Buttons
    
    -- Gradient für default Zustand
    local gradient = Instance.new("UIGradient")
    gradient.Parent = button
    gradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, defaultColor),
        ColorSequenceKeypoint.new(1, Color3.new(defaultColor.R * 0.7, defaultColor.G * 0.7, defaultColor.B * 0.7))
    }
    
    -- Hover Gradient
    local hoverGradient = Instance.new("UIGradient")
    hoverGradient.Parent = button
    hoverGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, activeColor),
        ColorSequenceKeypoint.new(1, Color3.new(activeColor.R * 0.7, activeColor.G * 0.7, activeColor.B * 0.7))
    }
    hoverGradient.Transparency = 1
    
    -- Moderner Border
    local stroke = Instance.new("UIStroke")
    stroke.Parent = button
    stroke.Color = Color3.new(0.2, 0.4, 0.8)
    stroke.Thickness = 1
    stroke.Transparency = 0.5
    
    -- Animationen
    button.MouseEnter:Connect(function()
        local hoverTween = TweenService:Create(hoverGradient, TweenInfo.new(0.3), {Transparency = 0})
        hoverTween:Play()
        local scaleTween = TweenService:Create(button, TweenInfo.new(0.2), {Size = UDim2.new(0, 330, 0, 48)})
        scaleTween:Play()
        
        -- Glowing Effect
        local glowTween = TweenService:Create(stroke, TweenInfo.new(0.3), {
            Thickness = 2,
            Transparency = 0.2
        })
        glowTween:Play()
    end)
    
    button.MouseLeave:Connect(function()
        local hoverTween = TweenService:Create(hoverGradient, TweenInfo.new(0.3), {Transparency = 1})
        hoverTween:Play()
        local scaleTween = TweenService:Create(button, TweenInfo.new(0.2), {Size = UDim2.new(0, 320, 0, 45)})
        scaleTween:Play()
        
        -- Normal Border
        local glowTween = TweenService:Create(stroke, TweenInfo.new(0.3), {
            Thickness = 1,
            Transparency = 0.5
        })
        glowTween:Play()
    end)
    
    -- Toggle Animation
    local function toggleActive(isActive)
        local targetGradient = isActive and hoverGradient or gradient
        local targetColor = isActive and activeColor or defaultColor
        local targetText = icon .. " " .. text
        
        local toggleTween = TweenService:Create(button, TweenInfo.new(0.4), {
            BackgroundColor3 = targetColor,
            TextColor3 = isActive and Color3.new(1, 1, 1) or Color3.new(0.9, 0.9, 1)
        })
        toggleTween:Play()
        
        -- Pulse Animation bei Aktivierung
        if isActive then
            local pulseTween = TweenService:Create(button, TweenInfo.new(0.3), {Size = UDim2.new(0, 340, 0, 50)})
            pulseTween:Play()
            pulseTween.Completed:Connect(function()
                local restoreTween = TweenService:Create(button, TweenInfo.new(0.2), {Size = UDim2.new(0, 320, 0, 45)})
                restoreTween:Play()
            end)
        end
    end
    
    return button, toggleActive
end

-- Moderne Buttons mit SVG Icons und Animationen
local FlyButton, toggleFly = createModernToggle("Fly", UDim2.new(0, 30, 0, 140), "Fliegen: AUS", "✈️", Color3.new(0.15, 0.15, 0.2), Color3.new(0.2, 0.4, 0.8))
local NoClipButton, toggleNoClip = createModernToggle("NoClip", UDim2.new(0, 30, 0, 195), "NoClip: AUS", "👻", Color3.new(0.15, 0.15, 0.2), Color3.new(0.2, 0.4, 0.8))
local BarrierButton, toggleBarrier = createModernToggle("Barrier", UDim2.new(0, 30, 0, 250), "Barrieren: AKTIV", "🛡️", Color3.new(0.15, 0.15, 0.2), Color3.new(0.2, 0.4, 0.8))
local ESPButton, toggleESP = createModernToggle("ESP", UDim2.new(0, 30, 0, 305), "ESP: AUS", "👁️", Color3.new(0.15, 0.15, 0.2), Color3.new(0.2, 0.4, 0.8))
local InstaKillButton, toggleInstaKill = createModernToggle("InstaKill", UDim2.new(0, 30, 0, 360), "Insta-Kill: AUS", "⚔️", Color3.new(0.15, 0.15, 0.2), Color3.new(0.2, 0.4, 0.8))
local ATMFarmButton, toggleATMFarm = createModernToggle("ATMFarm", UDim2.new(0, 30, 0, 415), "ATM Farm: AUS", "💰", Color3.new(0.15, 0.15, 0.2), Color3.new(0.2, 0.4, 0.8))
local InvisibilityButton, toggleInvisibility = createModernToggle("Invisibility", UDim2.new(0, 30, 0, 470), "Unsichtbarkeit: AUS", "👤", Color3.new(0.15, 0.15, 0.2), Color3.new(0.2, 0.4, 0.8))
local SnakeButton, toggleSnake = createModernToggle("Snake", UDim2.new(0, 30, 0, 525), "Schlange: AUS", "🐍", Color3.new(0.15, 0.15, 0.2), Color3.new(0.2, 0.4, 0.8))
local TPButton, toggleTP = createModernToggle("TP", UDim2.new(0, 30, 0, 580), "TP: AUS", "⚡", Color3.new(0.15, 0.15, 0.2), Color3.new(0.8, 0.6, 0.2))
local DanceButton, toggleDance = createModernToggle("Dance", UDim2.new(0, 30, 0, 635), "Tanzen: AUS", "🎵", Color3.new(0.15, 0.15, 0.2), Color3.new(0.8, 0.2, 0.8))
local ParticleButton, toggleParticle = createModernToggle("Particle", UDim2.new(0, 30, 0, 690), "Partikel: AUS", "✨", Color3.new(0.15, 0.15, 0.2), Color3.new(0.2, 0.8, 0.4))

-- Moderner Close Button mit Animation
local CloseButton = Instance.new("TextButton")
CloseButton.Parent = MainFrame
CloseButton.Size = UDim2.new(0, 40, 0, 40)
CloseButton.Position = UDim2.new(1, -50, 0, 15)
CloseButton.BackgroundColor3 = Color3.new(0.8, 0.2, 0.2)
CloseButton.BorderSizePixel = 0
CloseButton.Text = "✕"
CloseButton.TextColor3 = Color3.new(1, 1, 1)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 18

-- Viereckiger Close Button ohne abgerundete Ecken

local CloseGradient = Instance.new("UIGradient")
CloseGradient.Parent = CloseButton
CloseGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.new(0.9, 0.3, 0.3)),
    ColorSequenceKeypoint.new(1, Color3.new(0.6, 0.1, 0.1))
}

-- Close Button Animationen
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
PlayerListFrame.BackgroundColor3 = Color3.new(0.05, 0.05, 0.08)
PlayerListFrame.BorderSizePixel = 0
PlayerListFrame.Active = true
PlayerListFrame.Draggable = true

-- Viereckige Spielerliste ohne abgerundete Ecken

local PlayerListStroke = Instance.new("UIStroke")
PlayerListStroke.Parent = PlayerListFrame
PlayerListStroke.Color = Color3.new(0.2, 0.4, 0.8)
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
PlayerScrollingFrame.BackgroundColor3 = Color3.new(0.08, 0.08, 0.12)
PlayerScrollingFrame.BorderSizePixel = 0
PlayerScrollingFrame.ScrollBarThickness = 6
PlayerScrollingFrame.ScrollBarImageColor3 = Color3.new(0.2, 0.4, 0.8)
PlayerScrollingFrame.ScrollBarImageTransparency = 0.3

-- Viereckiges ScrollingFrame ohne abgerundete Ecken

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
TPListFrame.BackgroundColor3 = Color3.new(0.05, 0.05, 0.08)
TPListFrame.BorderSizePixel = 0
TPListFrame.Active = true
TPListFrame.Draggable = true

-- Viereckige TP-Liste ohne abgerundete Ecken

local TPListStroke = Instance.new("UIStroke")
TPListStroke.Parent = TPListFrame
TPListStroke.Color = Color3.new(0.8, 0.6, 0.2)
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
TPScrollingFrame.ScrollBarImageColor3 = Color3.new(0.8, 0.6, 0.2)
TPScrollingFrame.ScrollBarImageTransparency = 0.3

-- Viereckiges TP-ScrollingFrame ohne abgerundete Ecken

local TPListLayout = Instance.new("UIListLayout")
TPListLayout.Parent = TPScrollingFrame
TPListLayout.SortOrder = Enum.SortOrder.Name
TPListLayout.Padding = UDim.new(0, 4)

-- Tabelle zum Speichern der Spieler-Buttons
local playerButtons = {}
local tpPlayerButtons = {}

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

-- ESP Variablen
local espEnabled = false
local espConnections = {}
local espObjects = {}
local instaKillEnabled = false

-- Target-Follow Variablen
local targetPlayer = nil
local isFollowing = false
local followConnection = nil

-- ATM-Raub Variablen
local atmFarmEnabled = false
local currentATM = nil
local isRobbing = false
local atmCooldown = 0

-- TP-Target Variable
local tpTargetPlayer = nil
local invisibilityEnabled = false
local originalTransparency = {}
local originalCharacterParts = {}

-- Schlangen-Transformations-Variablen
local isSnake = false
local originalBodyParts = {}
local snakeModel = nil
local snakeParts = {}

-- Geschwindigkeitsfunktion mit Animation
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

-- ESP Funktionen
local function createESP(player)
    if espObjects[player] then return end

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
    objects.box.Color = Color3.new(0.2, 0.4, 0.8)
    objects.box.Filled = false
    objects.box.Transparency = 1

    objects.name.Color = Color3.new(1, 1, 1)
    objects.name.Size = 14
    objects.name.Center = true
    objects.name.Outline = true
    objects.name.OutlineColor = Color3.new(0, 0, 0)

    objects.distance.Color = Color3.new(1, 0.9, 0.8)
    objects.distance.Size = 12
    objects.distance.Center = true
    objects.distance.Outline = true
    objects.distance.OutlineColor = Color3.new(0, 0, 0)

    objects.tracer.Color = Color3.new(0.8, 0.6, 0.2)
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

                objects.box.Size = Vector2.new(width, height)
                objects.box.Position = Vector2.new(pos.X - width / 2, pos.Y - height / 2)
                objects.box.Visible = true

                objects.name.Text = player.Name
                objects.name.Position = Vector2.new(pos.X, pos.Y - height / 2 - 15)
                objects.name.Visible = true

                objects.distance.Text = string.format("%.0f m", distance)
                objects.distance.Position = Vector2.new(pos.X, pos.Y + height / 2 + 15)
                objects.distance.Visible = true

                objects.tracer.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
                objects.tracer.To = Vector2.new(pos.X, pos.Y)
                objects.tracer.Visible = true
            else
                for _, drawing in pairs(objects) do
                    drawing.Visible = false
                end
            end
        else
            removeESP(player)
        end
    end
end

-- Fliegen-Funktionen
local function startFly()
    if flying then return end
    
    flying = true
    toggleFly(true)
    
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
    toggleFly(false)
    
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
local function toggleNoClipFunc()
    noClipEnabled = not noClipEnabled
    toggleNoClip(noClipEnabled)
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
local function toggleBarrierFunc()
    barriersEnabled = not barriersEnabled
    toggleBarrier(barriersEnabled)
end

-- Slider-Steuerung
SpeedSlider.MouseButton1Down:Connect(function()
    isDragging = true
end)

UserInputService.InputChanged:Connect(function(input)
    if isDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local mousePos = input.Position
        local sliderPos = SpeedSlider.AbsolutePosition
        local sliderSize = SpeedSlider.AbsoluteSize
        
        local relativeX = math.clamp((mousePos.X - sliderPos.X) / sliderSize.X, 0, 1)
        speedValue = 0.1 + (relativeX * 49.9)
        
        updateSpeed()
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        isDragging = false
    end
end)

-- Button-Events mit Animationen
FlyButton.MouseButton1Click:Connect(function()
    if flying then
        stopFly()
    else
        startFly()
    end
end)

ESPButton.MouseButton1Click:Connect(function()
    espEnabled = not espEnabled
    if espEnabled then
        toggleESP(true)
    else
        toggleESP(false)
        for player, _ in pairs(espObjects) do
            removeESP(player)
        end
    end
end)

NoClipButton.MouseButton1Click:Connect(toggleNoClipFunc)
BarrierButton.MouseButton1Click:Connect(toggleBarrierFunc)

-- Insta-Kill Funktion
local function onHit(hitPart)
    if not instaKillEnabled then return end
    
    local character = hitPart.Parent
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    
    if humanoid and humanoid ~= Humanoid and character ~= Character then
        humanoid.Health = 0
    end
end

local function toggleInstaKillFunc()
    instaKillEnabled = not instaKillEnabled
    toggleInstaKill(instaKillEnabled)
    
    if instaKillEnabled then
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

        connectToCharacter(Character)
        espConnections.InstakillRespawn = LocalPlayer.CharacterAdded:Connect(connectToCharacter)
    else
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

InstaKillButton.MouseButton1Click:Connect(toggleInstaKillFunc)

-- Teleport Funktion
local function teleportTargetToMe()
    if tpTargetPlayer and tpTargetPlayer.Character and tpTargetPlayer.Character:FindFirstChild("HumanoidRootPart") 
       and Character and Character:FindFirstChild("HumanoidRootPart") then
        
        local targetHRP = tpTargetPlayer.Character.HumanoidRootPart
        local myHRP = Character.HumanoidRootPart
        
        local originalPosition = targetHRP.CFrame
        
        targetHRP.CFrame = myHRP.CFrame * CFrame.new(0, 0, 3)
        
        wait(0.1)
        
        if (targetHRP.Position - myHRP.Position).Magnitude > 5 then
            print("Teleport erfolgreich!")
        else
            print("Teleport wurde vom Server korrigiert - funktioniert nicht zuverlässig")
        end
    end
end

-- ATM Farm Funktionen
local function findNearestAvailableATM()
    local nearestATM = nil
    local shortestDistance = math.huge
    local playerRoot = Humanoid.Parent:FindFirstChild("HumanoidRootPart")

    if not playerRoot then return nil end

    local possibleATMNames = {"ATM", "MoneyMachine", "CashMachine", "Bankomat"}

    for _, obj in pairs(workspace:GetDescendants()) do
        for _, name in pairs(possibleATMNames) do
            if obj.Name:lower():find(name:lower()) and obj:IsA("Model") then
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

local function startRobbery(atm)
    if not atm or not Character or not Humanoid or not Humanoid.Parent:FindFirstChild("HumanoidRootPart") then return end

    local hrp = Humanoid.Parent:FindFirstChild("HumanoidRootPart")
    hrp.CFrame = atm.PrimaryPart.CFrame * CFrame.new(0, 0, 3)

    wait(0.5)

    local VirtualInputManager = game:GetService("VirtualInputManager")

    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, game)
    print("Halte 'E'-Taste für ATM: " .. atm.Name .. " gedrückt.")

    wait(5)

    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.E, false, game)
    print("'E'-Taste für ATM: " .. atm.Name .. " losgelassen.")

    return true
end

local function farmATMs()
    if not atmFarmEnabled then return end

    if isRobbing then return end

    currentATM = findNearestAvailableATM()
    if currentATM then
        isRobbing = true
        print("Starte Raub an ATM: " .. currentATM.Name)
        local success = startRobbery(currentATM)
        
        if success then
            atmCooldown = 45 
            print("Raub beendet. Warte auf Abklingzeit.")
        else
            atmCooldown = 5
            print("Raub fehlgeschlagen. Kurze Pause.")
        end
        
        isRobbing = false
        currentATM = nil
    else
        atmCooldown = 10
        print("Kein verfügbarer ATM gefunden. Warte 10 Sekunden.")
    end
end

ATMFarmButton.MouseButton1Click:Connect(function()
    atmFarmEnabled = not atmFarmEnabled
    if atmFarmEnabled then
        toggleATMFarm(true)
        print("ATM-Farm aktiviert.")
    else
        toggleATMFarm(false)
        print("ATM-Farm deaktiviert.")
        isRobbing = false
        currentATM = nil
    end
end)

-- Unsichtbarkeits-Funktion
local function toggleInvisibilityFunc()
    invisibilityEnabled = not invisibilityEnabled
    toggleInvisibility(invisibilityEnabled)
    
    if invisibilityEnabled then
        for _, part in pairs(Character:GetDescendants()) do
            if part:IsA("BasePart") then
                originalTransparency[part] = part.Transparency
                part.Transparency = 1
            elseif part:IsA("Decal") or part:IsA("Texture") then
                originalTransparency[part] = part.Transparency
                part.Transparency = 1
            end
        end
        
        if Character:FindFirstChild("HumanoidRootPart") then
            Character.HumanoidRootPart.Transparency = 1
        end
        
        local head = Character:FindFirstChild("Head")
        if head and head:FindFirstChild("NameTag") then
            head.NameTag.Visible = false
        end
        
        if Humanoid then
            Humanoid.MaxHealth = 0
            Humanoid.Health = 0
            wait()
            Humanoid.MaxHealth = 100
            Humanoid.Health = 100
        end
    else
        for part, transparency in pairs(originalTransparency) do
            if part and part.Parent then
                part.Transparency = transparency
            end
        end
        
        local head = Character:FindFirstChild("Head")
        if head and head:FindFirstChild("NameTag") then
            head.NameTag.Visible = true
        end
        
        originalTransparency = {}
    end
end

InvisibilityButton.MouseButton1Click:Connect(toggleInvisibilityFunc)

-- Schlangen-Transformationsfunktion
local function toggleSnakeFunc()
    isSnake = not isSnake
    toggleSnake(isSnake)
    
    if isSnake then
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
        
        snakeModel = Instance.new("Model")
        snakeModel.Name = "SnakeModel"
        snakeModel.Parent = Character
        
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
            
            local mesh = Instance.new("SpecialMesh")
            mesh.MeshType = Enum.MeshType.Sphere
            mesh.Scale = Vector3.new(1, 0.7, 1.5)
            mesh.Parent = segment
        end
        
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
        
        local lastPart = head
        for i, segment in pairs(snakeParts) do
            local weld = Instance.new("Weld")
            weld.Part0 = lastPart
            weld.Part1 = segment
            weld.C0 = CFrame.new(0, 0, -segmentSize.Z / 2 - 1)
            weld.Parent = segment
            lastPart = segment
        end
        
        if Character:FindFirstChild("HumanoidRootPart") then
            local rootWeld = Instance.new("Weld")
            rootWeld.Part0 = Character.HumanoidRootPart
            rootWeld.Part1 = head
            rootWeld.C0 = CFrame.new(0, 0, 0)
            rootWeld.Parent = head
        end
        
        if Humanoid then
            Humanoid.WalkSpeed = 8
        end
        
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
        if snakeModel then
            snakeModel:Destroy()
            snakeModel = nil
        end
        
        for name, data in pairs(originalBodyParts) do
            if data.Part and Character:FindFirstChild(name) then
                Character[name]:Destroy()
                data.Part.Parent = Character
            end
        end
        
        originalBodyParts = {}
        snakeParts = {}
        
        if Humanoid then
            Humanoid.WalkSpeed = 16 * speedValue
        end
    end
end

SnakeButton.MouseButton1Click:Connect(toggleSnakeFunc)

-- Close Button mit Animation
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

-- ==================== SPIELERLISTEN-FUNKTIONEN ====================

-- Erstellt oder aktualisiert den Button für einen einzelnen Spieler
local function createOrUpdatePlayerButton(player)
    if player == LocalPlayer then return end

    local button = playerButtons[player]
    if not button then
        button = Instance.new("TextButton")
        button.Parent = PlayerScrollingFrame
        button.Size = UDim2.new(1, -10, 0, 35)
        button.BackgroundColor3 = Color3.new(0.1, 0.1, 0.15)
        button.BorderSizePixel = 0
        button.Text = player.Name
        button.TextColor3 = Color3.new(0.9, 0.9, 1)
        button.Font = Enum.Font.Gotham
        button.TextSize = 14
        playerButtons[player] = button
        
        -- Modernes Styling
        local corner = Instance.new("UICorner")
        corner.Parent = button
        corner.CornerRadius = UDim.new(0, 8)
        
        local gradient = Instance.new("UIGradient")
        gradient.Parent = button
        gradient.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.new(0.15, 0.15, 0.2)),
            ColorSequenceKeypoint.new(1, Color3.new(0.1, 0.1, 0.15))
        }
        
        local stroke = Instance.new("UIStroke")
        stroke.Parent = button
        stroke.Color = Color3.new(0.2, 0.4, 0.8)
        stroke.Thickness = 1
        stroke.Transparency = 0.5
        
        -- Hover Animation
        local hoverGradient = Instance.new("UIGradient")
        hoverGradient.Parent = button
        hoverGradient.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.new(0.2, 0.4, 0.8)),
            ColorSequenceKeypoint.new(1, Color3.new(0.3, 0.6, 1))
        }
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
    end
    
    -- Aktualisiere Button-Status mit Animation
    if isFollowing and targetPlayer == player then
        button.Text = player.Name .. " [🎯 FOLLOWING]"
        local activeGradient = button:FindFirstChild("UIGradient")
        if activeGradient then
            activeGradient.Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0, Color3.new(0.2, 0.8, 0.2)),
                ColorSequenceKeypoint.new(1, Color3.new(0.3, 0.9, 0.3))
            }
        end
        
        local stroke = button:FindFirstChild("UIStroke")
        if stroke then
            stroke.Color = Color3.new(0.2, 0.8, 0.2)
            stroke.Thickness = 2
            stroke.Transparency = 0.2
        end
    else
        button.Text = player.Name
        local defaultGradient = button:FindFirstChild("UIGradient")
        if defaultGradient then
            defaultGradient.Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0, Color3.new(0.15, 0.15, 0.2)),
                ColorSequenceKeypoint.new(1, Color3.new(0.1, 0.1, 0.15))
            }
        end
        
        local stroke = button:FindFirstChild("UIStroke")
        if stroke then
            stroke.Color = Color3.new(0.2, 0.4, 0.8)
            stroke.Thickness = 1
            stroke.Transparency = 0.5
        end
    end
end

-- Entfernt den Button eines Spielers, der gegangen ist
local function removePlayerButton(player)
    if playerButtons[player] then
        playerButtons[player]:Destroy()
        playerButtons[player] = nil
    end
end

-- Hauptfunktion, um die gesamte Liste zu aktualisieren
local function updatePlayerList()
    for player, _ in pairs(playerButtons) do
        if not Players:FindFirstChild(player.Name) then
            removePlayerButton(player)
        end
    end
    
    for _, player in pairs(Players:GetPlayers()) do
        createOrUpdatePlayerButton(player)
    end
    
    PlayerScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, PlayerListLayout.AbsoluteContentSize.Y)
end

-- Funktion zum Starten/Stoppen des Folgens
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
    updatePlayerList()
end

-- ==================== TELEPORT-SPIELERLISTEN FUNKTIONEN ====================

-- Erstellt oder aktualisiert den Button für einen einzelnen Spieler in der TP-Liste
local function createOrUpdateTPPlayerButton(player)
    if player == LocalPlayer then return end

    local button = tpPlayerButtons[player]
    if not button then
        button = Instance.new("TextButton")
        button.Parent = TPScrollingFrame
        button.Size = UDim2.new(1, -10, 0, 35)
        button.BackgroundColor3 = Color3.new(0.15, 0.1, 0.05)
        button.BorderSizePixel = 0
        button.Text = player.Name
        button.TextColor3 = Color3.new(0.9, 0.9, 1)
        button.Font = Enum.Font.Gotham
        button.TextSize = 14
        tpPlayerButtons[player] = button
        
        -- Modernes Styling
        local corner = Instance.new("UICorner")
        corner.Parent = button
        corner.CornerRadius = UDim.new(0, 8)
        
        local gradient = Instance.new("UIGradient")
        gradient.Parent = button
        gradient.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.new(0.15, 0.1, 0.05)),
            ColorSequenceKeypoint.new(1, Color3.new(0.1, 0.05, 0.05))
        }
        
        local stroke = Instance.new("UIStroke")
        stroke.Parent = button
        stroke.Color = Color3.new(0.8, 0.6, 0.2)
        stroke.Thickness = 1
        stroke.Transparency = 0.5
        
        -- Hover Animation
        local hoverGradient = Instance.new("UIGradient")
        hoverGradient.Parent = button
        hoverGradient.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.new(0.8, 0.6, 0.2)),
            ColorSequenceKeypoint.new(1, Color3.new(0.9, 0.8, 0.3))
        }
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
    end
    
    -- Aktualisiere TP-Button-Status mit Animation
    if tpTargetPlayer == player then
        button.Text = player.Name .. " [⚡ TARGET]"
        local activeGradient = button:FindFirstChild("UIGradient")
        if activeGradient then
            activeGradient.Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0, Color3.new(0.8, 0.8, 0.2)),
                ColorSequenceKeypoint.new(1, Color3.new(0.9, 0.8, 0.3))
            }
        end
        
        local stroke = button:FindFirstChild("UIStroke")
        if stroke then
            stroke.Color = Color3.new(0.8, 0.8, 0.2)
            stroke.Thickness = 2
            stroke.Transparency = 0.2
        end
    else
        button.Text = player.Name
        local defaultGradient = button:FindFirstChild("UIGradient")
        if defaultGradient then
            defaultGradient.Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0, Color3.new(0.15, 0.1, 0.05)),
                ColorSequenceKeypoint.new(1, Color3.new(0.1, 0.05, 0.05))
            }
        end
        
        local stroke = button:FindFirstChild("UIStroke")
        if stroke then
            stroke.Color = Color3.new(0.8, 0.6, 0.2)
            stroke.Thickness = 1
            stroke.Transparency = 0.5
        end
    end
end

-- Entfernt den Button eines Spielers, der gegangen ist
local function removeTPPlayerButton(player)
    if tpPlayerButtons[player] then
        tpPlayerButtons[player]:Destroy()
        tpPlayerButtons[player] = nil
    end
end

-- Hauptfunktion, um die gesamte TP-Liste zu aktualisieren
local function updateTPPlayerList()
    for player, _ in pairs(tpPlayerButtons) do
        if not Players:FindFirstChild(player.Name) then
            removeTPPlayerButton(player)
        end
    end
    
    for _, player in pairs(Players:GetPlayers()) do
        createOrUpdateTPPlayerButton(player)
    end
    
    TPScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, TPListLayout.AbsoluteContentSize.Y)
end

-- Funktion zum Auswählen eines TP-Ziels
local function selectTPTarget(playerToTP)
    if tpTargetPlayer == playerToTP then
        tpTargetPlayer = nil
        print("TP-Ziel entfernt.")
    else
        tpTargetPlayer = playerToTP
        print("TP-Ziel gesetzt: " .. tpTargetPlayer.Name)
    end
    updateTPPlayerList()
end

-- ==================== EVENT-HANDLER ====================

-- Wenn ein Button in der Spielerliste geklickt wird
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

-- Wenn ein Button in der TP-Spielerliste geklickt wird
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

-- Verbindung zu Events, wenn Spieler den Server betreten oder verlassen
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

-- ==================== INITIALISIERUNG ====================

-- Start-Animation für das gesamte GUI
local function animateGUIEntry()
    -- MainFrame Fade-in von unten
    MainFrame.Position = UDim2.new(0.5, -190, 1, 0)
    local mainTween = TweenService:Create(MainFrame, TweenInfo.new(0.8, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Position = UDim2.new(0.5, -190, 0.5, -400)})
    mainTween:Play()
    
    -- PlayerList Slide-in von links
    PlayerListFrame.Position = UDim2.new(-1, 0, 0.5, -175)
    local playerListTween = TweenService:Create(PlayerListFrame, TweenInfo.new(0.6, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Position = UDim2.new(0, -240, 0.5, -175)})
    playerListTween:Play()
    
    -- TPList Slide-in von rechts
    TPListFrame.Position = UDim2.new(2, 0, 0.5, -175)
    local tpListTween = TweenService:Create(TPListFrame, TweenInfo.new(0.6, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Position = UDim2.new(1, 10, 0.5, -175)})
    tpListTween:Play()
    
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

-- Warte kurz, bevor die Spielerlisten aktualisiert werden
spawn(function()
    wait(1)
    updatePlayerList()
    updateTPPlayerList()
end)

-- Regelmäßige Updates für Spielerlisten
spawn(function()
    while ScreenGui.Parent do
        wait(2)
        updatePlayerList()
        updateTPPlayerList()
    end
end)

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

-- ==================== ZENTRALE RESPAWN-FUNKTION ====================
LocalPlayer.CharacterAdded:Connect(function(newCharacter)
    Character = newCharacter
    Humanoid = Character:WaitForChild("Humanoid")
    
    if invisibilityEnabled then
        invisibilityEnabled = false
        toggleInvisibility(false)
        originalTransparency = {}
        originalCharacterParts = {}
    end
    
    if noClipEnabled then
        toggleNoClipFunc()
    end
    
    if flying then
        stopFly()
    end
    
    updatePlayerList()
    updateTPPlayerList()
end)

-- ==================== RUNTIME UPDATE ====================
RunService.Stepped:Connect(function()
    if noClipEnabled and Character and Humanoid then
        for _, part in pairs(Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
    
    controlFly()
    updateESP()
end)

-- Führe die Farm-Funktion regelmäßig aus
spawn(function()
    while ScreenGui.Parent do
        wait(1)
        farmATMs()
    end
end)

print("F.N. Hunted Modern UI mit SVG Icons und Animationen geladen!")
print("Features: Geschwindigkeit, Fliegen, NoClip, Barrieren, ESP, Insta-Kill, ATM Farm, Unsichtbarkeit, Schlange")
print("Fliegen-Steuerung: W/A/S/D zum Bewegen, Leertaste hoch, Strg runter")
print("Modernes Design mit schwarzem Hintergrund und blauen Akzenten")
