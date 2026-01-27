-- Services
local UIService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local HttpService = game:GetService("HttpService")
local RSService = game:GetService("ReplicatedStorage")
local WorkspaceService = game:GetService("Workspace")
local ENService = game:GetService("ExperienceNotificationService")
local RunService= game:GetService("RunService")
local RFService = game:GetService("ReplicatedFirst")
local TeamsService = game:GetService("Teams")
local TweenService = game:GetService("TweenService")
local TeleportService = game:GetService("TeleportService")
local TIService = game:GetService("TouchInputService")
local GuiService = game:GetService("GuiService")
local KeyboardService = game:GetService("KeyboardService")
local MouseService = game:GetService("MouseService")

-- Locals
local ArchivableLib = {
	Assets = {
		imagePlaceholder = "rbxasset://textures/ui/GuiImagePlaceholder.png",
		lolImage = "http://www.roblox.com/asset/?id=13866870186",
		Root = {
			name = "ArchivableLib",
			creator = "xolaDev",
			description = "",
			versionn = "0.5",
		},
		Files = {
			path = RSService,
		},
	},
	Settings = {},
}

_G.ALib = ArchivableLib

--Core
local function generateRandomString(length: number): string
	local characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
	local result = {}

	local randomObject = Random.new()

	for i = 1, length do
		local randomIndex = randomObject:NextInteger(1, #characters)
		table.insert(result, string.sub(characters, randomIndex, randomIndex))
	end

	return table.concat(result)
end
local generatedRandomStrinng = generateRandomString(30)

local function printPointer(text: string, level: number)
	if level == 1 then
		print("[" .. ArchivableLib.Assets.Root.name .. "] " .. text)
	elseif level == 2 then
		warn("[" .. ArchivableLib.Assets.Root.name .. "] " .. text)
	elseif level == 3 then
		error("[" .. ArchivableLib.Assets.Root.name .. "] " .. text)
	end
end

-- GUI
local DepthOfFieldForBlur = Instance.new("DepthOfFieldEffect")
DepthOfFieldForBlur.Name = "DepthOfField"
DepthOfFieldForBlur.Parent = game.Lighting
DepthOfFieldForBlur.Enabled = true
DepthOfFieldForBlur.FarIntensity = 0
DepthOfFieldForBlur.FocusDistance = 51.6
DepthOfFieldForBlur.InFocusRadius = 50
DepthOfFieldForBlur.NearIntensity = 1

local ArchivableGUI = Instance.new("ScreenGui")
ArchivableGUI.Name = ArchivableLib.Assets.Root.name .. "_" .. generatedRandomStrinng
ArchivableGUI.Parent = LocalPlayer:WaitForChild("PlayerGui")
ArchivableGUI.ResetOnSpawn = false
ArchivableGUI.Enabled = true
ArchivableGUI.IgnoreGuiInset = true
ArchivableLib.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ArchivableLib.ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets
ArchivableLib.AutoLocalize = false

local GUI_NotificationsHost = Instance.new("Frame")
GUI_NotificationsHost.Name = "NotificationsHost"
GUI_NotificationsHost.Parent = ArchivableGUI
GUI_NotificationsHost.BorderSizePixel = 0
GUI_NotificationsHost.AutoLocalize = false
GUI_NotificationsHost.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
GUI_NotificationsHost.BackgroundTransparency = 1
GUI_NotificationsHost.Size = UDim2.new(0.19503, 0, 0.98352, 0)
GUI_NotificationsHost.Position = UDim2.new(0.80497, 0, 0.00954, 0)
GUI_NotificationsHost.BorderColor3 = Color3.fromRGB(0, 0, 0)

local GUI_NotificationsHost_UIListLayout = Instance.new("UIListLayout")
GUI_NotificationsHost_UIListLayout.Parent = GUI_NotificationsHost
GUI_NotificationsHost_UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
GUI_NotificationsHost_UIListLayout.Wraps = true
GUI_NotificationsHost_UIListLayout.Padding = UDim.new(0, 7)
GUI_NotificationsHost_UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
GUI_NotificationsHost_UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
GUI_NotificationsHost_UIListLayout.ItemLineAlignment = Enum.ItemLineAlignment.Center

--Files
local ArchivableFiles
if not ArchivableLib.Assets.Files.path:FindFirstChild(ArchivableLib.Assets.Root.name) then
	ArchivableFiles = Instance.new("Folder")
	ArchivableFiles.Name = ArchivableLib.Assets.Root.name
	ArchivableFiles.Parent = ArchivableLib.Assets.Files.path
end

local ArchivableFilesTemp = Instance.new("Folder")
ArchivableFilesTemp.Name = "session_" .. generatedRandomStrinng
ArchivableFilesTemp.Parent = ArchivableFiles

-- Functions
function ArchivableLib:DestroyLib()
	ArchivableGUI:Destroy()
	ArchivableFilesTemp:Destroy()
	script:Destroy()
end

function ArchivableLib:MakeBlurEffect(FramePath: string)
	local newScript = Instance.new("LocalScript")
	newScript.Name = "BlurEffect"

	local function initializeBlurEffect(scriptInstance)
		local parentFrame = scriptInstance.Parent
		if not parentFrame then return end

		local function C_b()
			local RunService = game:GetService("RunService")
			local camera = workspace.CurrentCamera

			-- wait for camera to be valid
			do
				local function IsNotNaN(x) return x == x end
				local continue = IsNotNaN(camera:ScreenPointToRay(0,0).Origin.x)
				while not continue do
					RunService.RenderStepped:Wait()
					continue = IsNotNaN(camera:ScreenPointToRay(0,0).Origin.x)
				end
			end

			local binds = {}
			local root = Instance.new("Folder", camera)
			root.Name = "neon"

			-- uid generator
			local GenUid do
				local id = 0
				function GenUid()
					id += 1
					return "neon::"..tostring(id)
				end
			end

			-- quad drawing
			local DrawQuad do
				local acos, max, pi, sqrt = math.acos, math.max, math.pi, math.sqrt
				local sz = 0.2

				local function DrawTriangle(v1,v2,v3,p0,p1)
					local s1,s2,s3 = (v1-v2).Magnitude, (v2-v3).Magnitude, (v3-v1).Magnitude
					local smax = max(s1,s2,s3)
					local A,B,C
					if s1==smax then A,B,C=v1,v2,v3 elseif s2==smax then A,B,C=v2,v3,v1 else A,B,C=v3,v1,v2 end

					local para = ((B-A).X*(C-A).X+(B-A).Y*(C-A).Y+(B-A).Z*(C-A).Z)/(A-B).Magnitude
					local perp = sqrt((C-A).Magnitude^2-para*para)
					local dif_para = (A-B).Magnitude-para

					local st = CFrame.new(B,A)
					local za = CFrame.Angles(pi/2,0,0)

					local cf0 = st
					local Top_Look = (cf0*za).LookVector
					local Mid_Point = A+CFrame.new(A,B).LookVector*para
					local Needed_Look = CFrame.new(Mid_Point,C).LookVector
					local dot = Top_Look:Dot(Needed_Look)

					local ac = CFrame.Angles(0,0,acos(dot))
					cf0 = cf0*ac
					if ((cf0*za).LookVector-Needed_Look).Magnitude>0.01 then
						cf0 = cf0*CFrame.Angles(0,0,-2*acos(dot))
					end
					cf0 = cf0*CFrame.new(0,perp/2,-(dif_para+para/2))

					local cf1 = st*ac*CFrame.Angles(0,pi,0)
					if ((cf1*za).LookVector-Needed_Look).Magnitude>0.01 then
						cf1 = cf1*CFrame.Angles(0,0,2*acos(dot))
					end
					cf1 = cf1*CFrame.new(0,perp/2,dif_para/2)

					if not p0 then
						p0 = Instance.new("Part")
						p0.Anchored = true
						p0.CanCollide = false
						p0.Material = Enum.Material.Glass
						p0.Size = Vector3.new(sz,sz,sz)
						local mesh = Instance.new("SpecialMesh",p0)
						mesh.MeshType = Enum.MeshType.Wedge
						mesh.Name = "WedgeMesh"
					end
					p0.WedgeMesh.Scale = Vector3.new(0,perp/sz,para/sz)
					p0.CFrame = cf0

					if not p1 then p1 = p0:Clone() end
					p1.WedgeMesh.Scale = Vector3.new(0,perp/sz,dif_para/sz)
					p1.CFrame = cf1

					return p0,p1
				end

				function DrawQuad(v1,v2,v3,v4,parts)
					parts[1],parts[2] = DrawTriangle(v1,v2,v3,parts[1],parts[2])
					parts[3],parts[4] = DrawTriangle(v3,v2,v4,parts[3],parts[4])
				end
			end

			-- API merged
			local function BindFrame(frame,properties)
				if binds[frame] then return binds[frame].parts end

				local uid = GenUid()
				local parts = {}
				local f = Instance.new("Folder",root)
				f.Name = frame.Name

				local parents = {}
				local function add(c)
					if c:IsA("GuiObject") then
						table.insert(parents,c)
						add(c.Parent)
					end
				end
				add(frame)

				local function Update(fetchProps)
					local zIndex = 1-0.05*frame.ZIndex
					local tl,br = frame.AbsolutePosition,frame.AbsolutePosition+frame.AbsoluteSize
					local tr,bl = Vector2.new(br.X,tl.Y),Vector2.new(tl.X,br.Y)
					local rot=0
					for _,v in ipairs(parents) do rot+=v.Rotation end
					if rot~=0 and rot%180~=0 then
						local mid=tl:Lerp(br,0.5)
						local s,c=math.sin(math.rad(rot)),math.cos(math.rad(rot))
						tl=Vector2.new(c*(tl.X-mid.X)-s*(tl.Y-mid.Y),s*(tl.X-mid.X)+c*(tl.Y-mid.Y))+mid
						tr=Vector2.new(c*(tr.X-mid.X)-s*(tr.Y-mid.Y),s*(tr.X-mid.X)+c*(tr.Y-mid.Y))+mid
						bl=Vector2.new(c*(bl.X-mid.X)-s*(bl.Y-mid.Y),s*(bl.X-mid.X)+c*(bl.Y-mid.Y))+mid
						br=Vector2.new(c*(br.X-mid.X)-s*(br.Y-mid.Y),s*(br.X-mid.X)+c*(br.Y-mid.Y))+mid
					end
					DrawQuad(
						camera:ScreenPointToRay(tl.X,tl.Y,zIndex).Origin,
						camera:ScreenPointToRay(tr.X,tr.Y,zIndex).Origin,
						camera:ScreenPointToRay(bl.X,bl.Y,zIndex).Origin,
						camera:ScreenPointToRay(br.X,br.Y,zIndex).Origin,
						parts
					)
					if fetchProps then
						for _,pt in pairs(parts) do pt.Parent=f end
						for propName,propValue in pairs(properties) do
							for _,pt in pairs(parts) do pt[propName]=propValue end
						end
					end
				end
				
				frame:GetPropertyChangedSignal("Visible"):Connect(function()
					if frame.Visible then
						RunService:BindToRenderStep(uid, 2000, Update)
					else
						RunService:UnbindFromRenderStep(uid)
						-- Прячем детали
						for _, pt in pairs(parts) do
							pt.Transparency = 1
							pt.CFrame = CFrame.new(0, 5000, 0)
						end
					end
				end)

				Update(true)
				RunService:BindToRenderStep(uid,2000,Update)

				binds[frame] = {uid=uid,parts=parts}
				return binds[frame].parts
			end

			-- Apply blur effect to the parent frame
			BindFrame(parentFrame, {
				Transparency = 0.98,
				BrickColor = BrickColor.new("Institutional white")
			})
		end

		task.spawn(C_b)
	end

	local connection
	connection = newScript.AncestryChanged:Connect(function()
		if newScript.Parent == FramePath then
			connection:Disconnect()
			task.spawn(initializeBlurEffect, newScript)
		end
	end)

	newScript.Parent = FramePath
	newScript.Enabled = true

	return newScript
end

function ArchivableLib:MakeDraggable(FramePath: string)
	local newScript = Instance.new("LocalScript")
	newScript.Name = "DraggableEffect"

	local function initializeDraggable(scriptInstance)
		local UIS = game:GetService('UserInputService')
		local TweenService = game:GetService('TweenService')
		local frame = scriptInstance.Parent

		if not frame or not frame:IsA("GuiObject") then return end

		local dragToggle = false
		local dragSpeed = 0.25
		local dragStart = nil
		local startPos = nil

		local function updateInput(input)
			if not dragStart then return end
			local delta = input.Position - dragStart
			local position = UDim2.new(
				startPos.X.Scale, 
				startPos.X.Offset + delta.X,
				startPos.Y.Scale, 
				startPos.Y.Offset + delta.Y
			)
			TweenService:Create(frame, TweenInfo.new(dragSpeed), {Position = position}):Play()
		end

		frame.InputBegan:Connect(function(input)
			if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then 
				dragToggle = true
				dragStart = input.Position
				startPos = frame.Position

				local connection
				connection = input.Changed:Connect(function()
					if input.UserInputState == Enum.UserInputState.End then
						dragToggle = false
						connection:Disconnect()
					end
				end)
			end
		end)

		UIS.InputChanged:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
				if dragToggle then
					updateInput(input)
				end
			end
		end)
	end

	local connection
	connection = newScript.AncestryChanged:Connect(function()
		if newScript.Parent == FramePath then
			connection:Disconnect()
			task.spawn(initializeDraggable, newScript)
		end
	end)

	newScript.Parent = FramePath
	newScript.Enabled = true

	return newScript
end

function ArchivableLib:CreateNotification(TitleContent: string, MessageContent: string, TimeDelay: number, ImageID: string)
	local Notification = Instance.new("Frame")
	Notification.Name = "Notification"
	Notification.Parent = GUI_NotificationsHost
	Notification.BackgroundTransparency = 1
	Notification.BorderSizePixel = 0
	Notification.Size = UDim2.new(0.9158, 0, 0.08818, 0)
	Notification.Visible = false

	local Container = Instance.new("Frame")
	Container.Name = "Container"
	Container.Parent = Notification
	Container.BorderSizePixel = 0
	Container.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
	Container.BackgroundTransparency = 0.3
	Container.Size = UDim2.new(1, 0,0.997, 0)
	Container.Position = UDim2.new(1.5, 0, 0, 0)
	Container.BorderColor3 = Color3.fromRGB(0, 0, 0)

	local NotificationCorner = Instance.new("UICorner")
	NotificationCorner.Parent = Container

	local Title = Instance.new("TextLabel")
	Title.Name = "Title"
	Title.Parent = Container
	Title.TextWrapped = true
	Title.ZIndex = 3
	Title.BorderSizePixel = 0
	Title.TextSize = 18
	Title.TextScaled = true
	Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Title.FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	Title.TextColor3 = Color3.fromRGB(255, 255, 255)
	Title.BackgroundTransparency = 1
	Title.Size = UDim2.new(0.68895, 0, 0.26, 0)
	Title.Position = UDim2.new(0.27907, 0, 0.08, 0)
	Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Title.Text = TitleContent

	local Icon = Instance.new("ImageLabel")
	Icon.Name = "Icon"
	Icon.Parent = Container
	Icon.ZIndex = 3
	Icon.BorderSizePixel = 0
	Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Icon.BackgroundTransparency = 1
	Icon.Image = ImageID or ArchivableLib.Assets.imagePlaceholder
	Icon.Size = UDim2.new(0.24709, 0, 0.84, 0)
	Icon.Position = UDim2.new(0.01744, 0, 0.08, 0)
	Icon.BorderColor3 = Color3.fromRGB(0, 0, 0)

	local IconCorner = Instance.new("UICorner")
	IconCorner.Parent = Icon

	local IconAspectRatio = Instance.new("UIAspectRatioConstraint")
	IconAspectRatio.Parent = Icon

	local Message = Instance.new("TextLabel")
	Message.Name = "Message"
	Message.Parent = Container
	Message.TextWrapped = true
	Message.ZIndex = 3
	Message.BorderSizePixel = 0
	Message.TextSize = 18
	Message.TextScaled = true
	Message.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Message.FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	Message.TextColor3 = Color3.fromRGB(255, 255, 255)
	Message.BackgroundTransparency = 1
	Message.Size = UDim2.new(0.68895, 0, 0.49, 0)
	Message.Position = UDim2.new(0.27907, 0, 0.43, 0)
	Message.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Message.Text = MessageContent

	ArchivableLib:MakeBlurEffect(Container)

	local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
	local tweenIn = TweenService:Create(Container, tweenInfo, {Position = UDim2.new(0, 0, 0, 0)})
	local tweenOut = TweenService:Create(Container, tweenInfo, {Position = UDim2.new(1.5, 0, 0, 0)})
	
	Notification.Visible = true

	task.spawn(function()
		tweenIn:Play()
		task.wait(TimeDelay)
		tweenOut:Play()
		tweenOut.Completed:Wait()
		Notification:Destroy()
	end)
end

function ArchivableLib:CreateMenu(NameInExplorer: string, TitleText: string, IsDarkTheme: boolean)
	local Theme = {
		Bg = IsDarkTheme and Color3.fromRGB(30, 30, 30) or Color3.fromRGB(255, 255, 255),
		Text = IsDarkTheme and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(0, 0, 0),
		Accent = IsDarkTheme and Color3.fromRGB(45, 45, 45) or Color3.fromRGB(240, 240, 240),
		Close = Color3.fromRGB(255, 80, 80)
	}

	local Menu = Instance.new("Frame")
	Menu.Name = NameInExplorer
	Menu.Parent = ArchivableGUI
	Menu.BackgroundColor3 = Theme.Bg
	Menu.BackgroundTransparency = 0.2
	Menu.Size = UDim2.new(0.441, 0,0.52, 0)
	Menu.Position = UDim2.new(0.28, 0,0.241, 0)
	Menu.BorderSizePixel = 0

	local Corner = Instance.new("UICorner")
	Corner.Parent = Menu

	local Title = Instance.new("TextLabel")
	Title.Name = "Title"
	Title.Parent = Menu
	Title.Text = TitleText
	Title.TextColor3 = Theme.Text
	Title.BackgroundColor3 = Color3.new(1, 1, 1)
	Title.BackgroundTransparency = 1
	Title.Size = UDim2.new(0.933, 0,0.062, 0)
	Title.Position = UDim2.new(0.007, 0,0.01, 0)
	Title.FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Bold)
	Title.TextScaled = true
	Title.TextXAlignment = Enum.TextXAlignment.Left

	local Close = Instance.new("TextButton")
	Close.Name = "Close"
	Close.Parent = Menu
	Close.Text = "X"
	Close.TextColor3 = Theme.Close
	Close.BackgroundColor3 = Color3.new(1, 1, 1)
	Close.BackgroundTransparency = 1
	Close.Size = UDim2.new(0.039, 0,0.069, 0)
	Close.Position = UDim2.new(0.953, 0,0.006, 0)
	Close.FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Bold)
	Close.TextScaled = true

	local Line = Instance.new("Frame")
	Line.Name = "Line"
	Line.Parent = Menu
	Line.BackgroundColor3 = Theme.Text
	Line.BackgroundTransparency = 0.8
	Line.Size = UDim2.new(1, 0,0.002, 0)
	Line.Position = UDim2.new(0, 0,0.075, 0)
	Line.BorderSizePixel = 0

	local TabsList = Instance.new("Frame")
	TabsList.Name = "TabsList"
	TabsList.Parent = Menu
	TabsList.BackgroundColor3 = Theme.Accent
	TabsList.BackgroundTransparency = 0.5
	TabsList.Size = UDim2.new(0.225, 0,0.896, 0)
	TabsList.Position = UDim2.new(0.007, 0,0.089, 0)
	TabsList.BorderSizePixel = 0
	
	local TabsList_Corner = Instance.new("UICorner")
	TabsList_Corner.Parent = TabsList

	local ListLayout = Instance.new("UIListLayout")
	ListLayout.Parent = TabsList
	ListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	ListLayout.Padding = UDim.new(0, 7)
	ListLayout.SortOrder = Enum.SortOrder.LayoutOrder

	local CurrentTab = Instance.new("Frame")
	CurrentTab.Name = "CurrentTab"
	CurrentTab.Parent = Menu
	CurrentTab.BackgroundColor3 = Theme.Accent
	CurrentTab.BackgroundTransparency = 0.5
	CurrentTab.Size = UDim2.new(0.753, 0,0.896, 0)
	CurrentTab.Position = UDim2.new(0.239, 0,0.089, 0)
	CurrentTab.BorderSizePixel = 0
	
	local CurrentTabCorner = Instance.new("UICorner")
	CurrentTabCorner.Parent = CurrentTab

	Close.MouseButton1Click:Connect(function()
		Menu.Visible = false
	end)

	ArchivableLib:MakeBlurEffect(Menu)
	ArchivableLib:MakeDraggable(Menu)

	return {
		Gui = Menu,
		Main = Menu,
		Tabs = TabsList,
		Page = CurrentTab
	}
end

function ArchivableLib:AddTab(MenuData, TabName: string, ImageID: string) 
	local TabButton = Instance.new("TextButton")
	TabButton.Name = TabName .. "Tab"
	TabButton.Parent = MenuData.Tabs
	TabButton.Text = TabName
	TabButton.TextSize = 16
	TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	TabButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TabButton.BackgroundTransparency = 0.9
	TabButton.FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
	TabButton.Size = UDim2.new(0.9, 0, 0.08121, 0)
	TabButton.TextXAlignment = Enum.TextXAlignment.Left

	local UIPadding = Instance.new("UIPadding", TabButton)
	UIPadding.PaddingLeft = UDim.new(0, 35)

	local Icon = Instance.new("ImageLabel", TabButton)
	Icon.Name = "Icon"
	Icon.Image = ImageID or ArchivableLib.Assets.imagePlaceholder
	Icon.Size = UDim2.new(0, 24, 0, 24)
	Icon.BackgroundTransparency = 1
	Icon.Position = UDim2.new(-0.2562, 5, 0.5, -12)

	local IconCorner = Instance.new("UICorner", Icon)
	IconCorner.CornerRadius = UDim.new(0, 4)

	local ButtonCorner = Instance.new("UICorner", TabButton)
	ButtonCorner.CornerRadius = UDim.new(0, 6)

	local TabPage = Instance.new("ScrollingFrame")
	TabPage.Name = TabName .. "Page"
	TabPage.Parent = MenuData.Page
	TabPage.Size = UDim2.new(1, 0, 1, 0)
	TabPage.BackgroundTransparency = 1
	TabPage.BorderSizePixel = 0
	TabPage.ScrollBarThickness = 4
	TabPage.Visible = false
	TabPage.CanvasSize = UDim2.new(0, 0, 0, 0)
	TabPage.AutomaticCanvasSize = Enum.AutomaticSize.Y

	local List = Instance.new("UIListLayout", TabPage)
	List.Padding = UDim.new(0, 5)
	List.SortOrder = Enum.SortOrder.LayoutOrder

	local PagePadding = Instance.new("UIPadding", TabPage)
	PagePadding.PaddingLeft = UDim.new(0, 10)
	PagePadding.PaddingTop = UDim.new(0, 10)

	TabButton.MouseButton1Click:Connect(function()
		for _, child in pairs(MenuData.Page:GetChildren()) do
			if child:IsA("ScrollingFrame") then child.Visible = false end
		end
		for _, btn in pairs(MenuData.Tabs:GetChildren()) do
			if btn:IsA("TextButton") then btn.BackgroundTransparency = 0.9 end
		end
		TabPage.Visible = true
		TabButton.BackgroundTransparency = 0.7
	end)

	if #MenuData.Tabs:GetChildren() <= 1 then
		TabPage.Visible = true
		TabButton.BackgroundTransparency = 0.7
	end

	return TabPage
end

function ArchivableLib:CreateFloatingButton(NameInExplorer: string, ImageID: string, OnClickedButtonCallback)
	local floatingButton = Instance.new("ImageButton")
	floatingButton.Visible = false
	floatingButton.Name = NameInExplorer or "FloatingButton"
	floatingButton.Size = UDim2.new(0.034, 0,0.07, 0)
	floatingButton.Position = UDim2.new(0.483, 0,0.065, 0)
	floatingButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	floatingButton.BorderSizePixel = 0
	floatingButton.Image = ImageID or ArchivableLib.Assets.imagePlaceholder
	floatingButton.Parent = ArchivableGUI

	local uiCorner = Instance.new("UICorner")
	uiCorner.Parent = floatingButton
	
	
	ArchivableLib:MakeDraggable(floatingButton)
	
	floatingButton.Visible = true
	floatingButton.MouseButton1Click:Connect(function()
		OnClickedButtonCallback()
	end)
end

--End
ArchivableLib:CreateNotification("Hello!", "ArchivableLib Loaded!", 3, _G.ALib.Assets.lolImage)
ArchivableLib:CreateNotification("Developed:", "xolaDev", 3, _G.ALib.Assets.lolImage)
