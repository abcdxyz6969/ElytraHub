-- Tạo GUI
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local CloseButton = Instance.new("TextButton")
local FastAttackButton = Instance.new("TextButton")
local IconButton = Instance.new("ImageButton")

-- Cấu hình GUI
ScreenGui.Name = "TestMenu"
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- MainFrame
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
MainFrame.Size = UDim2.new(0, 300, 0, 200)
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

-- Nút Fast Attack
FastAttackButton.Name = "FastAttackButton"
FastAttackButton.Parent = MainFrame
FastAttackButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
FastAttackButton.Position = UDim2.new(0.1, 0, 0.3, 0)
FastAttackButton.Size = UDim2.new(0.8, 0, 0.2, 0)
FastAttackButton.Font = Enum.Font.SourceSans
FastAttackButton.Text = "Fast Attack"
FastAttackButton.TextColor3 = Color3.fromRGB(255, 255, 255)
FastAttackButton.TextScaled = true

-- Chức năng Fast Attack
FastAttackButton.MouseButton1Click:Connect(function()
    print("Fast Attack activated!")
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    
    if humanoid then
        humanoid.Animator:Destroy() -- Tắt cooldown tấn công
        print("Cooldown bypassed!")
    end
end)

-- Icon ETH (Nút mở menu)
IconButton.Name = "IconButton"
IconButton.Parent = ScreenGui
IconButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0) -- Màu xanh lá cây
IconButton.Position = UDim2.new(0.05, 0, 0.05, 0)
IconButton.Size = UDim2.new(0, 50, 0, 50)
IconButton.Image = "rbxassetid://12345678" -- Thay bằng ID icon bạn muốn
IconButton.Active = true
IconButton.Draggable = true -- Cho phép di chuyển icon

-- Sự kiện mở menu
IconButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)
