-- JeanXx Hub (LocalScript)
-- Pegar en StarterGui como LocalScript

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

-- UI creation
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "JeanXxHub"
screenGui.ResetOnSpawn = false
screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- Main frame
local mainFrame = Instance.new("Frame")
mainFrame.Name = "Main"
mainFrame.Size = UDim2.new(0, 420, 0, 280)
mainFrame.Position = UDim2.new(0.5, -210, 0.4, -140)
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui
mainFrame.Active = true
mainFrame.Draggable = false -- we'll do custom dragging

-- Rounded UI
local uICorner = Instance.new("UICorner", mainFrame)
uICorner.CornerRadius = UDim.new(0, 10)

-- Rainbow border using UIStroke
local stroke = Instance.new("UIStroke", mainFrame)
stroke.Thickness = 3
stroke.Transparency = 0
stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

-- Title bar
local titleBar = Instance.new("Frame")
titleBar.Name = "TitleBar"
titleBar.Size = UDim2.new(1, 0, 0, 36)
titleBar.BackgroundTransparency = 1
titleBar.Parent = mainFrame

local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "Title"
titleLabel.Size = UDim2.new(1, -120, 1, 0)
titleLabel.Position = UDim2.new(0, 12, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "JeanXx"
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.TextColor3 = Color3.fromRGB(235,235,235)
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 20
titleLabel.Parent = titleBar

-- Apple toggle (small image button to open/close)
local appleBtn = Instance.new("ImageButton")
appleBtn.Name = "Apple"
appleBtn.Size = UDim2.new(0, 28, 0, 28)
appleBtn.Position = UDim2.new(1, -36, 0.5, -14)
appleBtn.AnchorPoint = Vector2.new(1,0.5)
appleBtn.BackgroundColor3 = Color3.fromRGB(255,255,255)
appleBtn.BackgroundTransparency = 1
appleBtn.Image = "rbxassetid://6035047365" -- default placeholder apple-like icon; cámbialo si tienes otro
appleBtn.Parent = titleBar

-- Minimize, Maximize, Close buttons
local btnContainer = Instance.new("Frame", titleBar)
btnContainer.Size = UDim2.new(0, 90, 1, 0)
btnContainer.Position = UDim2.new(1, -120, 0, 0)
btnContainer.BackgroundTransparency = 1

local function makeSmallButton(name, posX, text)
	local b = Instance.new("TextButton")
	b.Name = name
	b.Size = UDim2.new(0, 28, 0, 22)
	b.Position = UDim2.new(0, posX, 0.5, -11)
	b.BackgroundColor3 = Color3.fromRGB(40,40,40)
	b.TextColor3 = Color3.fromRGB(240,240,240)
	b.Text = text
	b.Font = Enum.Font.Gotham
	b.TextSize = 14
	b.Parent = btnContainer
	local c = Instance.new("UICorner", b)
	c.CornerRadius = UDim.new(0,6)
	return b
end

local btnMin = makeSmallButton("Minimize", 0, "–")
local btnMax = makeSmallButton("Maximize", 34, "◻")
local btnClose = makeSmallButton("Close", 68, "✕")

-- Content frame (scrollable)
local content = Instance.new("Frame")
content.Name = "Content"
content.Size = UDim2.new(1, -18, 1, -52)
content.Position = UDim2.new(0, 12, 0, 44)
content.BackgroundTransparency = 1
content.Parent = mainFrame

local scroll = Instance.new("ScrollingFrame")
scroll.Size = UDim2.new(1, 0, 1, 0)
scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
scroll.ScrollBarThickness = 8
scroll.BackgroundTransparency = 1
scroll.Parent = content

local uiList = Instance.new("UIListLayout", scroll)
uiList.Padding = UDim.new(0, 8)
uiList.SortOrder = Enum.SortOrder.LayoutOrder

-- Helper to create option rows
local function createOption(titleText)
	local optionFrame = Instance.new("Frame")
	optionFrame.Size = UDim2.new(1, -12, 0, 60)
	optionFrame.BackgroundColor3 = Color3.fromRGB(32,32,32)
	optionFrame.Parent = scroll
	local c = Instance.new("UICorner", optionFrame)
	c.CornerRadius = UDim.new(0,8)
	
	local label = Instance.new("TextLabel", optionFrame)
	label.Text = titleText
	label.Size = UDim2.new(0.7, -12, 1, 0)
	label.Position = UDim2.new(0, 12, 0, 0)
	label.BackgroundTransparency = 1
	label.TextColor3 = Color3.fromRGB(235,235,235)
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Font = Enum.Font.GothamBold
	label.TextSize = 16
	
	local toggle = Instance.new("TextButton", optionFrame)
	toggle.Name = "Toggle"
	toggle.Size = UDim2.new(0, 86, 0, 34)
	toggle.Position = UDim2.new(1, -98, 0.5, -17)
	toggle.BackgroundColor3 = Color3.fromRGB(180, 50, 50) -- red (off)
	toggle.TextColor3 = Color3.fromRGB(255,255,255)
	toggle.Font = Enum.Font.GothamSemibold
	toggle.Text = "DESACTIVADO"
	toggle.TextSize = 12
	local uc = Instance.new("UICorner", toggle)
	uc.CornerRadius = UDim.new(0,6)
	
	return optionFrame, toggle
end

-- Create Option 1
local opt1Frame, opt1Toggle = createOption("Opción 1 - Hitbox visual 25% (local)")
scroll.CanvasSize = UDim2.new(0, 0, 0, uiList.AbsoluteContentSize + 20)

-- update canvasSize on layout changes
uiList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
	scroll.CanvasSize = UDim2.new(0, 0, 0, uiList.AbsoluteContentSize + 16)
end)

-- Dragging logic for mainFrame (custom)
local dragging = false
local dragStart = nil
local startPos = nil

titleBar.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = mainFrame.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
		local delta = input.Position - dragStart
		mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)

-- Minimize / Maximize / Close behavior
local savedSize = mainFrame.Size
local savedPos = mainFrame.Position
local minimized = false
local maximized = false

btnMin.MouseButton1Click:Connect(function()
	if not minimized then
		savedSize = mainFrame.Size
		savedPos = mainFrame.Position
		mainFrame.Size = UDim2.new(0, 320, 0, 64)
		mainFrame.Position = UDim2.new(0.5, -160, 0.1, 0)
		minimized = true
	else
		mainFrame.Size = savedSize
		mainFrame.Position = savedPos
		minimized = false
	end
end)

btnMax.MouseButton1Click:Connect(function()
	if not maximized then
		savedSize = mainFrame.Size
		savedPos = mainFrame.Position
		mainFrame.Size = UDim2.new(0.9, 0, 0.85, 0)
		mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
		maximized = true
	else
		mainFrame.Size = savedSize
		mainFrame.Position = savedPos
		maximized = false
	end
end)

btnClose.MouseButton1Click:Connect(function()
	screenGui.Enabled = false
end)

-- Apple button toggles display (collapses/expands)
local collapsed = false
appleBtn.MouseButton1Click:Connect(function()
	collapsed = not collapsed
	if collapsed then
		-- hide content, shrink
		content.Visible = false
		mainFrame.Size = UDim2.new(0, 120, 0, 36)
	else
		content.Visible = true
		mainFrame.Size = savedSize or UDim2.new(0, 420, 0, 280)
	end
end)

-- Rainbow stroke effect
local hue = 0
RunService.RenderStepped:Connect(function(dt)
	hue = (hue + dt * 0.12) % 1
	local color = Color3.fromHSV(hue, 1, 1)
	stroke.Color = color
end)

-- Option 1 behaviour (safe/local)
local opt1Active = false
local hitboxes = {} -- table of {player = player, size = Vector3, conn = connection}

local function createLocalHitboxFor(player)
	-- only create if character and root exist and not self
	if not player.Character or player == LocalPlayer then return end
	local hrp = player.Character:FindFirstChild("HumanoidRootPart")
	if not hrp then return end

	-- size: 25% of HRP size (approx)
	local baseSize = hrp.Size
	local s = Vector3.new(baseSize.X * 0.25, baseSize.Y * 0.25, baseSize.Z * 0.25)
	hitboxes[player] = {size = s}
end

local function removeLocalHitboxFor(player)
	hitboxes[player] = nil
end

local function rebuildHitboxes()
	hitboxes = {}
	for _, p in pairs(Players:GetPlayers()) do
		if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
			createLocalHitboxFor(p)
		end
	end
end

Players.PlayerAdded:Connect(function(p)
	if opt1Active then
		-- wait for char
		p.CharacterAdded:Wait()
		createLocalHitboxFor(p)
	end
end)
Players.PlayerRemoving:Connect(function(p)
	removeLocalHitboxFor(p)
end)

-- Visual Hit effect (floating text)
local function showHitEffectOn(player)
	if not player.Character then return end
	local hrp = player.Character:FindFirstChild("HumanoidRootPart")
	if not hrp then return end

	-- BillboardGui with text
	local bb = Instance.new("BillboardGui")
	bb.Adornee = hrp
	bb.Size = UDim2.new(0,100,0,40)
	bb.StudsOffset = Vector3.new(0, 3, 0)
	bb.AlwaysOnTop = true
	bb.Parent = screenGui

	local txt = Instance.new("TextLabel", bb)
	txt.Size = UDim2.new(1,0,1,0)
	txt.BackgroundTransparency = 1
	txt.Text = "Hit!"
	txt.Font = Enum.Font.GothamBold
	txt.TextSize = 22
	txt.TextColor3 = Color3.fromRGB(255, 120, 120)

	-- fade out
	spawn(function()
		for i=1,30 do
			txt.TextTransparency = i/30
			wait(0.02)
		end
		pcall(function() bb:Destroy() end)
	end)
end

-- Core loop: check distances to player HRP and simulate "hit" when local player is within radius of that player's local hitbox
local lastHitTimes = {} -- prevent spamming same target
RunService.Heartbeat:Connect(function()
	if not opt1Active then return end
	local myChar = LocalPlayer.Character
	if not myChar or not myChar:FindFirstChild("HumanoidRootPart") then return end
	local myPos = myChar.HumanoidRootPart.Position

	for p, info in pairs(hitboxes) do
		if p and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
			local targetPos = p.Character.HumanoidRootPart.Position
			local radius = math.max(info.size.X, info.size.Z) * 0.5 + 1 -- safety margin
			local dist = (myPos - targetPos).Magnitude

			-- if within radius -> consider a local hit (only client-side visuals)
			if dist <= radius then
				local now = tick()
				local last = lastHitTimes[p] or 0
				if now - last > 0.8 then -- cooldown per target
					lastHitTimes[p] = now
					-- show visual effect
					showHitEffectOn(p)
					-- play local sound if you want (optional)
				end
			end
		end
	end
end)

-- Toggle handler for Option 1
opt1Toggle.MouseButton1Click:Connect(function()
	opt1Active = not opt1Active
	if opt1Active then
		opt1Toggle.BackgroundColor3 = Color3.fromRGB(60, 180, 60) -- green
		opt1Toggle.Text = "ACTIVADO"
		-- build hitboxes locally
		rebuildHitboxes()
	else
		opt1Toggle.BackgroundColor3 = Color3.fromRGB(180, 50, 50) -- red
		opt1Toggle.Text = "DESACTIVADO"
		hitboxes = {}
	end
end)

-- initialize small safe behavior
rebuildHitboxes()

-- Feedback: show hub when player spawns
LocalPlayer.CharacterAdded:Connect(function()
	screenGui.Enabled = true
end)

-- Note: this script is local-only, it never modifies other players' Humanoids.
