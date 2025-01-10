-- Tạo GUI
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local CloseButton = Instance.new("TextButton")
local PlayerCategory = Instance.new("TextLabel")
local HumanoidButton = Instance.new("TextButton")
local AuraButton = Instance.new("TextButton")
local IconButton = Instance.new("ImageButton")

-- Biến trạng thái
local auraEnabled = false -- Trạng thái của Aura
local fastAttackEnabled = false -- Trạng thái của Humanoid (Fast Attack)

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

-- Nút Humanoid (Fast Attack)
HumanoidButton.Name = "HumanoidButton"
HumanoidButton.Parent = MainFrame
HumanoidButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
HumanoidButton.Position = UDim2.new(0.1, 0, 0.3, 0)
HumanoidButton.Size = UDim2.new(0.8, 0, 0.1, 0)
HumanoidButton.Font = Enum.Font.SourceSans
HumanoidButton.Text = "Humanoid (OFF)"
HumanoidButton.TextColor3 = Color3.fromRGB(255, 255, 255)
HumanoidButton.TextScaled = true

HumanoidButton.MouseButton1Click:Connect(function()
    fastAttackEnabled = not fastAttackEnabled
    HumanoidButton.Text = fastAttackEnabled and "Humanoid (ON)" or "Humanoid (OFF)"
    
    if fastAttackEnabled then
        print("Fast Attack activated!")
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        
        if humanoid then
            humanoid.Animator:Destroy() -- Tắt cooldown tấn công
            print("Cooldown bypassed!")
        end
    else
        print("Fast Attack deactivated!")
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

AuraButton.MouseButton1Click:Connect(function()
    auraEnabled = not auraEnabled
    AuraButton.Text = auraEnabled and "Aura (ON)" or "Aura (OFF)"
    
    if auraEnabled then
        print("Aura enabled!")
        -- Tự động tấn công quái/địch
        spawn(function()
            while auraEnabled do
                for _, enemy in pairs(workspace:GetDescendants()) do
                    if enemy:IsA("Model") and enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 then
                        local player = game.Players.LocalPlayer
                        local character = player.Character or player.CharacterAdded:Wait()
                        local tool = character:FindFirstChildOfClass("Tool")
                        
                        if tool and tool:FindFirstChild("Handle") then
                            firetouchinterest(tool.Handle, enemy:FindFirstChild("Head") or enemy.PrimaryPart, 0)
                            firetouchinterest(tool.Handle, enemy:FindFirstChild("Head") or enemy.PrimaryPart, 1)
                        end
                    end
                end
                wait(0.1) -- Giảm tải
            end
        end)
    else
        print("Aura disabled!")
    end
end)

-- Icon ETH (hình tròn, mở menu)
IconButton.Name = "IconButton"
IconButton.Parent = ScreenGui
IconButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0) -- Màu xanh lá cây
IconButton.Position = UDim2.new(0.05, 0, 0.05, 0)
IconButton.Size = UDim2.new(0, 50, 0, 50)
IconButton.Image = "rbxassetid://12345678" -- Thay bằng ID hình ảnh
IconButton.ImageColor3 = Color3.fromRGB(255, 255, 255)
IconButton.BackgroundTransparency = 1
IconButton.Active = true
IconButton.Draggable = true -- Cho phép di chuyển icon
IconButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)
