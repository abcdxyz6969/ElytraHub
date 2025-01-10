-- Tạo GUI
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local CloseButton = Instance.new("TextButton")
local PlayerCategory = Instance.new("TextButton")
local HumanoidButton = Instance.new("TextButton")
local AuraButton = Instance.new("TextButton")
local TriggerBotButton = Instance.new("TextButton")
local IconButton = Instance.new("ImageButton")

-- Biến trạng thái
local menuVisible = false -- Trạng thái menu (ẩn/hiện)
local modulesVisible = true -- Trạng thái hiển thị module trong Player
local auraEnabled = false -- Trạng thái Aura
local fastAttackEnabled = false -- Trạng thái Humanoid
local triggerBotEnabled = false -- Trạng thái TriggerBot

-- Cấu hình GUI
ScreenGui.Name = "TestMenu"
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- MainFrame
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -150)
MainFrame.Size = UDim2.new(0, 300, 0, 300)
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true -- Cho phép di chuyển

-- Tiêu đề
Title.Name = "Title"
Title.Parent = MainFrame
Title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Font = Enum.Font.SourceSansBold
Title.Text = "Test Menu"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextScaled = true

-- Nút đóng (X)
CloseButton.Name = "CloseButton"
CloseButton.Parent = MainFrame
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
CloseButton.Position = UDim2.new(1, -30, 0, 0)
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Font = Enum.Font.SourceSansBold
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextScaled = true
CloseButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
end)

-- Danh mục Player
PlayerCategory.Name = "PlayerCategory"
PlayerCategory.Parent = MainFrame
PlayerCategory.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
PlayerCategory.Position = UDim2.new(0.05, 0, 0.15, 0)
PlayerCategory.Size = UDim2.new(0.9, 0, 0.1, 0)
PlayerCategory.Font = Enum.Font.SourceSansBold
PlayerCategory.Text = "Player"
PlayerCategory.TextColor3 = Color3.fromRGB(255, 255, 255)
PlayerCategory.TextScaled = true
PlayerCategory.MouseButton1Click:Connect(function()
    modulesVisible = not modulesVisible
    HumanoidButton.Visible = modulesVisible
    AuraButton.Visible = modulesVisible
    TriggerBotButton.Visible = modulesVisible
end)

-- Nút Humanoid
HumanoidButton.Name = "HumanoidButton"
HumanoidButton.Parent = MainFrame
HumanoidButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
HumanoidButton.Position = UDim2.new(0.1, 0, 0.3, 0)
HumanoidButton.Size = UDim2.new(0.8, 0, 0.1, 0)
HumanoidButton.Font = Enum.Font.SourceSans
HumanoidButton.Text = "Humanoid (OFF)"
HumanoidButton.TextColor3 = Color3.fromRGB(255, 255, 255)
HumanoidButton.TextScaled = true
HumanoidButton.Visible = true

local fastAttackConnection
HumanoidButton.MouseButton1Click:Connect(function()
    fastAttackEnabled = not fastAttackEnabled
    HumanoidButton.Text = fastAttackEnabled and "Humanoid (ON)" or "Humanoid (OFF)"

    if fastAttackEnabled then
        print("Fast Attack Activated")
        fastAttackConnection = game:GetService("RunService").Stepped:Connect(function()
            local character = game.Players.LocalPlayer.Character
            if character and character:FindFirstChild("Humanoid") then
                local humanoid = character:FindFirstChild("Humanoid")
                if humanoid and humanoid:FindFirstChild("Animator") then
                    for _, animTrack in pairs(humanoid.Animator:GetPlayingAnimationTracks()) do
                        animTrack:AdjustSpeed(2) -- Tăng tốc độ đánh
                    end
                end
            end
        end)
    else
        print("Fast Attack Deactivated")
        if fastAttackConnection then
            fastAttackConnection:Disconnect()
            fastAttackConnection = nil
        end

        local character = game.Players.LocalPlayer.Character
        if character and character:FindFirstChild("Humanoid") then
            local humanoid = character:FindFirstChild("Humanoid")
            if humanoid and humanoid:FindFirstChild("Animator") then
                for _, animTrack in pairs(humanoid.Animator:GetPlayingAnimationTracks()) do
                    animTrack:AdjustSpeed(1) -- Khôi phục tốc độ gốc
                end
            end
        end
    end
end)

-- Nút Aura
AuraButton.Name = "AuraButton"
AuraButton.Parent = MainFrame
AuraButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
AuraButton.Position = UDim2.new(0.1, 0, 0.45, 0)
AuraButton.Size = UDim2.new(0.8, 0, 0.1, 0)
AuraButton.Font = Enum.Font.SourceSans
AuraButton.Text = "Aura (OFF)"
AuraButton.TextColor3 = Color3.fromRGB(255, 255, 255)
AuraButton.TextScaled = true
AuraButton.Visible = true
AuraButton.MouseButton1Click:Connect(function()
    auraEnabled = not auraEnabled
    AuraButton.Text = auraEnabled and "Aura (ON)" or "Aura (OFF)"

    if auraEnabled then
        print("Aura Activated")
        while auraEnabled do
            local player = game.Players.LocalPlayer
            local enemies = workspace:FindPartsInRegion3(Region3.new(player.Position - Vector3.new(10, 10, 10), player.Position + Vector3.new(10, 10, 10)))
            for _, enemy in pairs(enemies) do
                if enemy.Parent:FindFirstChild("Humanoid") then
                    mouse1press() wait() mouse1release()
                end
            end
            wait(0.1)
        end
    else
        print("Aura Deactivated")
    end
end)

-- Nút TriggerBot
TriggerBotButton.Name = "TriggerBotButton"
TriggerBotButton.Parent = MainFrame
TriggerBotButton.BackgroundColor3 = Color3.fromRGB(255, 85, 0)
TriggerBotButton.Position = UDim2.new(0.1, 0, 0.6, 0)
TriggerBotButton.Size = UDim2.new(0.8, 0, 0.1, 0)
TriggerBotButton.Font = Enum.Font.SourceSans
TriggerBotButton.Text = "TriggerBot (OFF)"
TriggerBotButton.TextColor3 = Color3.fromRGB(255, 255, 255)
TriggerBotButton.TextScaled = true
TriggerBotButton.Visible = true
TriggerBotButton.MouseButton1Click:Connect(function()
    triggerBotEnabled = not triggerBotEnabled
    TriggerBotButton.Text = triggerBotEnabled and "TriggerBot (ON)" or "TriggerBot (OFF)"
    if triggerBotEnabled then
        print("TriggerBot Activated")
        game:GetService("RunService").RenderStepped:Connect(function()
            local player = game.Players.LocalPlayer
            local mouse = player:GetMouse()
            if mouse.Target and mouse.Target.Parent:FindFirstChild("Humanoid") and mouse.Target.Parent.Name ~= player.Name then
                mouse1press() wait() mouse1release()
            end
        end)
    else
        print("TriggerBot Deactivated")
    end
end)

-- Icon ETH (hình tròn)
IconButton.Name = "IconButton"
IconButton.Parent = ScreenGui
IconButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
IconButton.Position = UDim2.new(0.05, 0, 0.05, 0)
IconButton.Size = UDim2.new(0, 50, 0, 50)
IconButton.Image = "rbxassetid://12345678" -- Thay bằng ID hình ảnh
IconButton.BackgroundTransparency = 1
IconButton.Active = true
IconButton.Draggable = true -- Cho phép di chuyển
local dragging = false
IconButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
    end
end)
IconButton.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
        menuVisible = not menuVisible
        MainFrame.Visible = menuVisible
    end
end)
