-- Tạo GUI trên client
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local PlayButton = Instance.new("TextButton")
local SettingsButton = Instance.new("TextButton")
local ExitButton = Instance.new("TextButton")

-- Cấu hình GUI
ScreenGui.Name = "CustomMenu"
ScreenGui.Parent = game.CoreGui -- Đặt vào CoreGui để hiển thị lên màn hình
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Frame.Position = UDim2.new(0.5, -100, 0.5, -75)
Frame.Size = UDim2.new(0, 200, 0, 150)

-- Cấu hình nút "Play"
PlayButton.Parent = Frame
PlayButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
PlayButton.Position = UDim2.new(0.1, 0, 0.1, 0)
PlayButton.Size = UDim2.new(0.8, 0, 0.2, 0)
PlayButton.Text = "Play"
PlayButton.TextColor3 = Color3.fromRGB(255, 255, 255)
PlayButton.Font = Enum.Font.SourceSans
PlayButton.TextScaled = true

-- Cấu hình nút "Settings"
SettingsButton.Parent = Frame
SettingsButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
SettingsButton.Position = UDim2.new(0.1, 0, 0.4, 0)
SettingsButton.Size = UDim2.new(0.8, 0, 0.2, 0)
SettingsButton.Text = "Settings"
SettingsButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SettingsButton.Font = Enum.Font.SourceSans
SettingsButton.TextScaled = true

-- Cấu hình nút "Exit"
ExitButton.Parent = Frame
ExitButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
ExitButton.Position = UDim2.new(0.1, 0, 0.7, 0)
ExitButton.Size = UDim2.new(0.8, 0, 0.2, 0)
ExitButton.Text = "Exit"
ExitButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ExitButton.Font = Enum.Font.SourceSans
ExitButton.TextScaled = true

-- Xử lý các sự kiện nút
PlayButton.MouseButton1Click:Connect(function()
    print("Play button clicked!")
    -- Thêm mã xử lý hành động khi nhấn "Play"
end)

SettingsButton.MouseButton1Click:Connect(function()
    print("Settings button clicked!")
    -- Thêm mã xử lý hành động khi nhấn "Settings"
end)

ExitButton.MouseButton1Click:Connect(function()
    print("Exit button clicked!")
    Frame.Visible = false -- Ẩn menu khi nhấn Exit
end)
