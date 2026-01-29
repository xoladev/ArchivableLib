-- Services
local UIService = game:GetService("UserInputService")
local MarketplaceService = game:GetService("MarketplaceService")
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
local PlayersService = game:GetService("Players")

-- Locals
local ArchivableLib = {
	Assets = {
		imagePlaceholder = "rbxasset://textures/ui/GuiImagePlaceholder.png",
		dogLOLImage = 13866870186,
		catLOLImage = 107857607232375,
		NotSetText = "Element Value Not Set!",
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
	Themes = {
		DarkTheme = {
			Bg = Color3.fromRGB(30, 30, 30),
			ElementBG = Color3.fromRGB(177, 177, 177),
			Text = Color3.fromRGB(217, 217, 217),
			Accent = Color3.fromRGB(38, 38, 38),
			Close = Color3.fromRGB(182, 182, 182),
			PlaceHoldersColor = Color3.new(0.462745, 0.462745, 0.462745),
			ElementActiveBG = Color3.fromRGB(157, 157, 157),
		},
		WhiteTheme = {
			Bg = Color3.fromRGB(255, 255, 255),
			ElementBG = Color3.fromRGB(240, 240, 240),
			Text = Color3.fromRGB(67, 67, 67),
			Accent = Color3.fromRGB(240, 240, 240),
			Close = Color3.fromRGB(31, 31, 31),
			PlaceHoldersColor = Color3.new(0.462745, 0.462745, 0.462745),
			ElementActiveBG = Color3.fromRGB(157, 157, 157),
		},
		RedTheme = {
			Bg = Color3.fromRGB(122, 0, 0),
			ElementBG = Color3.fromRGB(255, 67, 67),
			Text = Color3.fromRGB(255, 255, 255),
			Accent = Color3.fromRGB(255, 67, 67),
			Close = Color3.fromRGB(255, 80, 80),
			PlaceHoldersColor = Color3.new(0.462745, 0.462745, 0.462745),
			ElementActiveBG = Color3.fromRGB(157, 157, 157),
		}
	},
	MenuThemes = {},
}

local ArchivableLibGlobal = {
	Assets = {
		imagePlaceholder = ArchivableLib.Assets.imagePlaceholder,
		dogLOLImage = ArchivableLib.Assets.dogLOLImage,
		catLOLImage = ArchivableLib.Assets.catLOLImage,
	},
}
_G.ALib = ArchivableLibGlobal

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
local generatedRandomString = generateRandomString(30)
local function printPointer(text: string, level: number)
	if level == 1 then
		print("[" .. ArchivableLib.Assets.Root.name .. "] " .. text)
	elseif level == 2 then
		warn("[" .. ArchivableLib.Assets.Root.name .. "] " .. text)
	elseif level == 3 then
		error("[" .. ArchivableLib.Assets.Root.name .. "] " .. text)
	end
end
local function processImageID(ImageID)
	return "rbxassetid://" .. tostring(ImageID)
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
ArchivableGUI.Name = ArchivableLib.Assets.Root.name .. "_" .. generatedRandomString
ArchivableGUI.Parent = LocalPlayer:WaitForChild("PlayerGui")
ArchivableGUI.ResetOnSpawn = false
ArchivableGUI.Enabled = true
ArchivableGUI.IgnoreGuiInset = true
ArchivableGUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ArchivableGUI.ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets
ArchivableGUI.AutoLocalize = false

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
GUI_NotificationsHost.ZIndex = 10

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
ArchivableFilesTemp.Name = "session_" .. generatedRandomString
ArchivableFilesTemp.Parent = ArchivableFiles

-- Functions
function ArchivableLibGlobal:DestroyLib()
	ArchivableGUI:Destroy()
	ArchivableFilesTemp:Destroy()
	script:Destroy()
end

function ArchivableLibGlobal:MakeBlurEffect(FramePath)
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

function ArchivableLibGlobal:MakeDraggable(FramePath: string)
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

function ArchivableLibGlobal:CreateNotification(TitleContent: string, MessageContent: string, TimeDelay: number, ImageID: number)
	ImageID = processImageID(ImageID)
	TitleContent = #TitleContent > 23 and string.sub(TitleContent, 1, 23) or TitleContent
	
	local Notification = Instance.new("Frame")
	Notification.Name = "Notification"
	Notification.Parent = GUI_NotificationsHost
	Notification.BackgroundTransparency = 1
	Notification.BorderSizePixel = 0
	Notification.Size = UDim2.new(0.9158, 0, 0.08818, 0)
	Notification.Visible = false
	GUI_NotificationsHost.ZIndex = 11

	local Container = Instance.new("Frame")
	Container.Name = "Container"
	Container.Parent = Notification
	Container.BorderSizePixel = 0
	Container.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
	Container.BackgroundTransparency = 0.3
	Container.Size = UDim2.new(1, 0,0.997, 0)
	Container.Position = UDim2.new(1.5, 0, 0, 0)
	Container.BorderColor3 = Color3.fromRGB(0, 0, 0)
	GUI_NotificationsHost.ZIndex = 12

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
	Title.Text = TitleContent or ArchivableLib.Assets.NotSetText
	GUI_NotificationsHost.ZIndex = 13

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
	GUI_NotificationsHost.ZIndex = 13

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
	Message.Text = MessageContent or ArchivableLib.Assets.NotSetText
	GUI_NotificationsHost.ZIndex = 13

	ArchivableLibGlobal:MakeBlurEffect(Container)

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

function ArchivableLibGlobal:CreateMenu(NameInExplorer: string, TitleText: string, ThemeName: string)
	TitleText = #TitleText > 78 and string.sub(TitleText, 1, 78) or TitleText
	local Theme = ArchivableLib.Themes[ThemeName] or ArchivableLib.Themes.DarkTheme

	local Menu = Instance.new("Frame")
	Menu.Name = NameInExplorer
	Menu.Visible = false
	Menu.Parent = ArchivableGUI
	Menu.BackgroundColor3 = Theme.Bg
	Menu.BackgroundTransparency = 0.3
	Menu.Size = UDim2.new(0.42173, 0, 0.48649, 0)
	Menu.Position = UDim2.new(0.28911, 0, 0.25622, 0)
	Menu.BorderSizePixel = 0
	Menu.ZIndex = 10

	local Corner = Instance.new("UICorner")
	Corner.Parent = Menu
	Corner.CornerRadius = UDim.new(0, 10)

	local AspectRatio = Instance.new("UIAspectRatioConstraint", Menu)
	AspectRatio.AspectRatio = 1.76

	local Title = Instance.new("TextLabel")
	Title.Name = "Title"
	Title.Parent = Menu
	Title.Text = TitleText or ArchivableLib.Assets.NotSetText
	Title.TextColor3 = Theme.Text
	Title.BackgroundColor3 = Color3.new(1, 1, 1)
	Title.BackgroundTransparency = 1
	Title.Size = UDim2.new(0.92729, 0, 0.09929, 0)
	Title.Position = UDim2.new(0.01212, 0, 0, 0)
	Title.FontFace = Font.new("rbxasset://fonts/families/HighwayGothic.json", Enum.FontWeight.Bold)
	Title.TextScaled = true
	Title.TextXAlignment = Enum.TextXAlignment.Left
	Title.ZIndex = 11

	local TitleTextSizeConstraint = Instance.new("UITextSizeConstraint", Title)
	TitleTextSizeConstraint.MaxTextSize = 20

	local TitleAspectRatio = Instance.new("UIAspectRatioConstraint", Title)
	TitleAspectRatio.AspectRatio = 16.43698

	local Close = Instance.new("TextButton")
	Close.Name = "Close"
	Close.Parent = Menu
	Close.Text = "X"
	Close.TextColor3 = Theme.Close
	Close.BackgroundColor3 = Color3.new(1, 1, 1)
	Close.BackgroundTransparency = 1
	Close.Size = UDim2.new(0.03662, 0, 0.06444, 0)
	Close.Position = UDim2.new(0.9491, 0, 0.01735, 0)
	Close.FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Bold)
	Close.TextScaled = true
	Close.ZIndex = 11

	local CloseAspectRatio = Instance.new("UIAspectRatioConstraint", Close)

	local Line1 = Instance.new("Frame")
	Line1.Name = "Line"
	Line1.Parent = Menu
	Line1.BackgroundColor3 = Theme.Text
	Line1.BackgroundTransparency = 0.8
	Line1.Size = UDim2.new(1, 0, 0.00222, 0)
	Line1.Position = UDim2.new(0, 0, 0.09929, 0)
	Line1.BorderSizePixel = 0
	Line1.ZIndex = 11

	local Line1AspectRatio = Instance.new("UIAspectRatioConstraint", Line1)
	Line1AspectRatio.AspectRatio = 792

	local Line2 = Instance.new("Frame")
	Line2.Name = "Line"
	Line2.Parent = Menu
	Line2.BackgroundColor3 = Theme.Text
	Line2.BackgroundTransparency = 0.8
	Line2.Size = UDim2.new(1, 0, 0.00444, 0)
	Line2.Position = UDim2.new(0, 0, 0.86596, 0)
	Line2.BorderSizePixel = 0
	Line2.ZIndex = 11

	local Line2AspectRatio = Instance.new("UIAspectRatioConstraint", Line2)
	Line2AspectRatio.AspectRatio = 396

	local TabsList = Instance.new("Frame")
	TabsList.Name = "TabsList"
	TabsList.Parent = Menu
	TabsList.BackgroundColor3 = Theme.Accent
	TabsList.BackgroundTransparency = 0.4
	TabsList.Size = UDim2.new(0.24116, 0, 0.72889, 0)
	TabsList.Position = UDim2.new(0.01212, 0, 0.12, 0)
	TabsList.BorderSizePixel = 0
	TabsList.ZIndex = 12

	local TabsList_Corner = Instance.new("UICorner", TabsList)

	local TabsListAspectRatio = Instance.new("UIAspectRatioConstraint", TabsList)
	TabsListAspectRatio.AspectRatio = 0.58232

	local TabsScrollingFrame = Instance.new("ScrollingFrame")
	TabsScrollingFrame.Name = "List"
	TabsScrollingFrame.Parent = TabsList
	TabsScrollingFrame.Active = true
	TabsScrollingFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TabsScrollingFrame.BackgroundTransparency = 1
	TabsScrollingFrame.Size = UDim2.new(1, 0, 0.96341, 0)
	TabsScrollingFrame.Position = UDim2.new(0, 0, 0.018, 0)
	TabsScrollingFrame.BorderSizePixel = 0
	TabsScrollingFrame.ScrollBarThickness = 0
	TabsScrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0)
	TabsScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
	TabsScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
	TabsScrollingFrame.ScrollingDirection = Enum.ScrollingDirection.Y

	local ListLayout = Instance.new("UIListLayout", TabsScrollingFrame)
	ListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	ListLayout.Padding = UDim.new(0, 4)
	ListLayout.Wraps = false
	ListLayout.ItemLineAlignment = Enum.ItemLineAlignment.End

	local CurrentTab = Instance.new("Frame")
	CurrentTab.Name = "CurrentTab"
	CurrentTab.Parent = Menu
	CurrentTab.BackgroundColor3 = Theme.Accent
	CurrentTab.BackgroundTransparency = 1
	CurrentTab.Size = UDim2.new(0.72348, 0, 0.64902, 0)
	CurrentTab.Position = UDim2.new(0.26212, 0, 0.19987, 0)
	CurrentTab.BorderSizePixel = 0
	CurrentTab.ZIndex = 12

	local CurrentTabCorner = Instance.new("UICorner", CurrentTab)

	local CurrentTabAspectRatio = Instance.new("UIAspectRatioConstraint", CurrentTab)
	CurrentTabAspectRatio.AspectRatio = 1.96192

	local CurrentTabName = Instance.new("TextLabel")
	CurrentTabName.Name = "CurrentTabName"
	CurrentTabName.Parent = CurrentTab
	CurrentTabName.Text = ""
	CurrentTabName.TextColor3 = Theme.Text
	CurrentTabName.BackgroundColor3 = Color3.new(1, 1, 1)
	CurrentTabName.BackgroundTransparency = 1
	CurrentTabName.Size = UDim2.new(0.99694, 0, 0.09314, 0)
	CurrentTabName.Position = UDim2.new(-0.00183, 0, -0.10515, 0)
	CurrentTabName.FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Bold)
	CurrentTabName.TextScaled = true
	CurrentTabName.TextXAlignment = Enum.TextXAlignment.Left
	CurrentTabName.BorderSizePixel = 0

	local CurrentTabNameTextSizeConstraint = Instance.new("UITextSizeConstraint", CurrentTabName)
	CurrentTabNameTextSizeConstraint.MaxTextSize = 25

	local CurrentTabNameAspectRatio = Instance.new("UIAspectRatioConstraint", CurrentTabName)
	CurrentTabNameAspectRatio.AspectRatio = 21

	local PlayerAvatar = Instance.new("ImageLabel")
	PlayerAvatar.Name = "PlayerAvatar"
	PlayerAvatar.Parent = Menu
	PlayerAvatar.BackgroundColor3 = Color3.new(1, 1, 1)
	PlayerAvatar.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
	PlayerAvatar.Size = UDim2.new(0.05051, 0, 0.08889, 0)
	PlayerAvatar.Position = UDim2.new(0.01136, 0, 0.88889, 0)
	PlayerAvatar.BorderSizePixel = 0
	PlayerAvatar.ZIndex = 11

	local PlayerAvatarCorner = Instance.new("UICorner", PlayerAvatar)
	PlayerAvatarCorner.CornerRadius = UDim.new(0, 10)

	local PlayerAvatarAspectRatio = Instance.new("UIAspectRatioConstraint", PlayerAvatar)

	local NameOfPlayer = Instance.new("TextLabel")
	NameOfPlayer.Name = "NameOfPlayer"
	NameOfPlayer.Parent = PlayerAvatar
	NameOfPlayer.Text = "Hello!"
	NameOfPlayer.TextColor3 = Theme.Text
	NameOfPlayer.BackgroundColor3 = Color3.new(1, 1, 1)
	NameOfPlayer.BackgroundTransparency = 1
	NameOfPlayer.Size = UDim2.new(18.125, 0, 0.475, 0)
	NameOfPlayer.Position = UDim2.new(1.21212, 0, 0, 0)
	NameOfPlayer.FontFace = Font.new("rbxasset://fonts/families/JosefinSans.json", Enum.FontWeight.Bold)
	NameOfPlayer.TextScaled = true
	NameOfPlayer.TextXAlignment = Enum.TextXAlignment.Left
	NameOfPlayer.ZIndex = 11

	local NameOfPlayerAspectRatio = Instance.new("UIAspectRatioConstraint", NameOfPlayer)
	NameOfPlayerAspectRatio.AspectRatio = 38.15789

	local PlaceName = Instance.new("TextLabel")
	PlaceName.Name = "PlaceName"
	PlaceName.Parent = PlayerAvatar
	PlaceName.Text = ""
	PlaceName.TextColor3 = Theme.Text
	PlaceName.BackgroundColor3 = Color3.new(1, 1, 1)
	PlaceName.BackgroundTransparency = 1
	PlaceName.Size = UDim2.new(18.125, 0, 0.525, 0)
	PlaceName.Position = UDim2.new(1.21212, 0, 0.475, 0)
	PlaceName.FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Bold)
	PlaceName.TextScaled = true
	PlaceName.TextXAlignment = Enum.TextXAlignment.Left
	PlaceName.ZIndex = 11

	local IDOfPlayerAspectRatio = Instance.new("UIAspectRatioConstraint", PlaceName)
	IDOfPlayerAspectRatio.AspectRatio = 34.52381

	local lcPlayer = PlayersService.LocalPlayer
	NameOfPlayer.Text = "Dear, " .. lcPlayer.DisplayName .. "."
	PlaceName.Text = MarketplaceService:GetProductInfoAsync(game.PlaceId).Name

	local playerAvatarImageLocal = PlayersService:GetUserThumbnailAsync(lcPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420) 
	PlayerAvatar.Image = playerAvatarImageLocal 

	Close.MouseButton1Click:Connect(function()
		Menu.Visible = false
	end)

	local MenuObject = {
		Gui = Menu,
		Main = Menu,
		Tabs = TabsScrollingFrame,
		Page = CurrentTab,
		Theme = Theme,
		ThemeName = ThemeName
	}

	ArchivableLib.MenuThemes[Menu] = Theme
	
	ArchivableLibGlobal:MakeDraggable(Menu)
	ArchivableLibGlobal:MakeBlurEffect(Menu)
	Menu.Visible = true

	return MenuObject
end

function ArchivableLibGlobal:AddTab(MenuData, TabName: string, ImageID: number)
	ImageID = processImageID(ImageID)
	TabName = #TabName > 12 and string.sub(TabName, 1, 12) or TabName
	local Theme = MenuData.Theme

	local TabButton = Instance.new("TextButton")
	TabButton.Name = TabName .. "_Tab"
	TabButton.Parent = MenuData.Tabs
	TabButton.Text = ""
	TabButton.BackgroundColor3 = Theme.Text
	TabButton.BackgroundTransparency = 1
	TabButton.Size = UDim2.new(0.92, 0, 0.08, 0)
	
	local UIScaler = Instance.new("UIScale", TabButton)
	UIScaler.Scale = 1.5

	local TabButtonCorner = Instance.new("UICorner", TabButton)

	local TabButtonAspectRatio = Instance.new("UIAspectRatioConstraint", TabButton)
	TabButtonAspectRatio.AspectRatio = 4.464

	local Icon = Instance.new("ImageLabel", TabButton)
	Icon.Name = "Image"
	Icon.Image = ImageID or ArchivableLib.Assets.imagePlaceholder
	Icon.Size = UDim2.new(0.18386, 0, 0.78327, 0)
	Icon.Position = UDim2.new(0.025, 0, 0.08621, 0)
	Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Icon.BackgroundTransparency = 1
	Icon.BorderSizePixel = 0

	local IconCorner = Instance.new("UICorner", Icon)

	local IconAspectRatio = Instance.new("UIAspectRatioConstraint", Icon)

	local TabNameLabel = Instance.new("TextLabel", TabButton)
	TabNameLabel.Name = "TextLabel"
	TabNameLabel.Text = TabName or ArchivableLib.Assets.NotSetText
	TabNameLabel.TextColor3 = Theme.Text
	TabNameLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TabNameLabel.BackgroundTransparency = 1
	TabNameLabel.Size = UDim2.new(0.68391, 0, 0.52632, 0)
	TabNameLabel.Position = UDim2.new(0.27527, 0, 0.23684, 0)
	TabNameLabel.FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Bold)
	TabNameLabel.TextScaled = true
	TabNameLabel.TextXAlignment = Enum.TextXAlignment.Left

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
	TabPage.ScrollBarThickness = 0

	local List = Instance.new("UIListLayout", TabPage)
	List.Padding = UDim.new(0, 5)
	List.SortOrder = Enum.SortOrder.LayoutOrder
	List.Wraps = false
	List.ItemLineAlignment = Enum.ItemLineAlignment.End

	--local PagePadding = Instance.new("UIPadding", TabPage)
	--PagePadding.PaddingLeft = UDim.new(0, 10)
	--PagePadding.PaddingTop = UDim.new(0, 10)

	TabButton.MouseButton1Click:Connect(function()
		for _, child in pairs(MenuData.Page:GetChildren()) do
			if child:IsA("ScrollingFrame") then 
				child.Visible = false 
			end
		end
		for _, btn in pairs(MenuData.Tabs:GetChildren()) do
			if btn:IsA("TextButton") then 
				btn.BackgroundTransparency = 1 
			end
		end
		TabPage.Visible = true
		TabButton.BackgroundTransparency = 0.8
		if MenuData.Page:FindFirstChild("CurrentTabName") then
			MenuData.Page.CurrentTabName.Text = TabName
		end
	end)

	TabButton.MouseEnter:Connect(function()
		if not TabPage.Visible then
			TabButton.BackgroundTransparency = 0.9
		end
	end)

	TabButton.MouseLeave:Connect(function()
		if not TabPage.Visible then
			TabButton.BackgroundTransparency = 1
		end
	end)

	local tabCount = 0
	for _, child in pairs(MenuData.Tabs:GetChildren()) do
		if child:IsA("TextButton") then
			tabCount = tabCount + 1
		end
	end

	if tabCount == 1 then
		TabPage.Visible = true
		TabButton.BackgroundTransparency = 0.8
		if MenuData.Page:FindFirstChild("CurrentTabName") then
			MenuData.Page.CurrentTabName.Text = TabName
		end
	end

	return {
		Page = TabPage,
		MenuData = MenuData
	}
end

function ArchivableLibGlobal:CreateFloatingButton(NameInExplorer: string, ImageID: number, zindex: number, OnClickedButtonCallback)
	ImageID = processImageID(ImageID)
	
	local floatingButton = Instance.new("ImageButton")
	floatingButton.Visible = false
	floatingButton.Name = NameInExplorer or "FloatingButton"
	floatingButton.Size = UDim2.new(0.034, 0,0.07, 0)
	floatingButton.Position = UDim2.new(0.483, 0,0.065, 0)
	floatingButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	floatingButton.BorderSizePixel = 0
	floatingButton.Image = ImageID or ArchivableLib.Assets.imagePlaceholder
	floatingButton.Parent = ArchivableGUI
	floatingButton.ZIndex = zindex or 999999

	local uiCorner = Instance.new("UICorner")
	uiCorner.Parent = floatingButton
	
	local uiaspect = Instance.new("UIAspectRatioConstraint")
	uiaspect.Parent = floatingButton
	uiaspect.Name = "UIAspectRatioConstraint"
	uiaspect.DominantAxis = Enum.DominantAxis.Width
	uiaspect.AspectType = Enum.AspectType.FitWithinMaxSize
	uiaspect.AspectRatio = 0.999
	
	ArchivableLibGlobal:MakeDraggable(floatingButton)
	
	floatingButton.Visible = true
	floatingButton.MouseButton1Click:Connect(function() if type(OnClickedButtonCallback) == "function" then OnClickedButtonCallback() end end)
	
	return floatingButton
end

function ArchivableLibGlobal:CreateKeySystem(ValidKey: string, GetKeyURL: string, WindowTitle: string, ThemeName: string, OKCallBack)
	WindowTitle = #WindowTitle > 51 and string.sub(WindowTitle, 1, 51) or WindowTitle
	local Theme = ArchivableLib.Themes[ThemeName] or ArchivableLib.Themes.DarkTheme

	local MainFrame = Instance.new("Frame")
	MainFrame.Name = "KeySystem_Hi3WMbztyKl4np9a0iCkYwra8bXg4a"
	MainFrame.ZIndex = 10
	MainFrame.BorderSizePixel = 0
	MainFrame.BackgroundColor3 = Theme.Bg
	MainFrame.Size = UDim2.new(0.251, 0, 0.151, 0)
	MainFrame.Position = UDim2.new(0.374, 0, 0.42, 0)
	MainFrame.BackgroundTransparency = 0.3
	MainFrame.Visible = false
	MainFrame.Parent = ArchivableGUI

	local UICorner = Instance.new("UICorner")
	UICorner.CornerRadius = UDim.new(0, 10)
	UICorner.Parent = MainFrame

	local Title = Instance.new("TextLabel")
	Title.Name = "Title"
	Title.Parent = MainFrame
	Title.TextWrapped = true
	Title.ZIndex = 11
	Title.TextScaled = true
	Title.FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	Title.TextColor3 = Theme.Text
	Title.BackgroundTransparency = 1
	Title.Size = UDim2.new(0.969, 0, 0.148, 0)
	Title.Text = WindowTitle or "keysystemtest"
	Title.Position = UDim2.new(0.012, 0, 0.024, 0)

	local TitleAspectRatio = Instance.new("UIAspectRatioConstraint")
	TitleAspectRatio.AspectRatio = 21.36863
	TitleAspectRatio.Parent = Title

	local TextBox = Instance.new("TextBox")
	TextBox.Parent = MainFrame
	TextBox.PlaceholderColor3 = Theme.PlaceHoldersColor
	TextBox.ZIndex = 11
	TextBox.TextWrapped = true
	TextBox.TextSize = 31
	TextBox.TextColor3 = Theme.Text
	TextBox.TextScaled = true
	TextBox.BackgroundColor3 = Theme.Accent
	TextBox.FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	TextBox.PlaceholderText = "Enter Key"
	TextBox.Size = UDim2.new(0.43637, 0, 0.35605, 0)
	TextBox.Position = UDim2.new(0.538, 0, 0.343, 0)
	TextBox.Text = ""

	local TextBoxCorner = Instance.new("UICorner")
	TextBoxCorner.CornerRadius = UDim.new(0, 10)
	TextBoxCorner.Parent = TextBox

	local TextBoxAspectRatio = Instance.new("UIAspectRatioConstraint")
	TextBoxAspectRatio.AspectRatio = 4
	TextBoxAspectRatio.Parent = TextBox

	local TextBoxSizeConstraint = Instance.new("UITextSizeConstraint")
	TextBoxSizeConstraint.MaxTextSize = 32
	TextBoxSizeConstraint.Parent = TextBox

	local CheckKey = Instance.new("TextButton")
	CheckKey.Name = "CheckKey"
	CheckKey.Parent = MainFrame
	CheckKey.TextWrapped = true
	CheckKey.TextSize = 32
	CheckKey.TextScaled = true
	CheckKey.TextColor3 = Theme.Text
	CheckKey.BackgroundColor3 = Theme.Accent
	CheckKey.FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	CheckKey.ZIndex = 11
	CheckKey.Size = UDim2.new(0.43637, 0, 0.32757, 0)
	CheckKey.Text = "Check Key"
	CheckKey.Position = UDim2.new(0.028, 0, 0.229, 0)

	local CheckKeyCorner = Instance.new("UICorner")
	CheckKeyCorner.CornerRadius = UDim.new(0, 10)
	CheckKeyCorner.Parent = CheckKey

	local CheckKeyAspectRatio = Instance.new("UIAspectRatioConstraint")
	CheckKeyAspectRatio.AspectRatio = 4.34783
	CheckKeyAspectRatio.Parent = CheckKey

	local CheckKeySizeConstraint = Instance.new("UITextSizeConstraint")
	CheckKeySizeConstraint.MaxTextSize = 32
	CheckKeySizeConstraint.Parent = CheckKey

	local GetKey = Instance.new("TextButton")
	GetKey.Name = "GetKey"
	GetKey.Parent = MainFrame
	GetKey.TextWrapped = true
	GetKey.TextSize = 32
	GetKey.TextScaled = true
	GetKey.TextColor3 = Theme.Text
	GetKey.BackgroundColor3 = Theme.Accent
	GetKey.FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	GetKey.ZIndex = 11
	GetKey.Size = UDim2.new(0.43637, 0, 0.32757, 0)
	GetKey.Text = "Get Key"
	GetKey.Position = UDim2.new(0.028, 0, 0.604, 0)

	local GetKeyCorner = Instance.new("UICorner")
	GetKeyCorner.CornerRadius = UDim.new(0, 10)
	GetKeyCorner.Parent = GetKey

	local GetKeyAspectRatio = Instance.new("UIAspectRatioConstraint")
	GetKeyAspectRatio.AspectRatio = 4.34783
	GetKeyAspectRatio.Parent = GetKey

	local GetKeySizeConstraint = Instance.new("UITextSizeConstraint")
	GetKeySizeConstraint.MaxTextSize = 32
	GetKeySizeConstraint.Parent = GetKey

	local FrameAspectRatio = Instance.new("UIAspectRatioConstraint")
	FrameAspectRatio.AspectRatio = 3.26373
	FrameAspectRatio.Parent = MainFrame

	CheckKey.MouseButton1Click:Connect(function()
		if TextBox.Text == ValidKey then
			if type(OKCallBack) == "function" then task.spawn(OKCallBack) end MainFrame:Destroy()
		else
			TextBox.Text = "Invalid Key"
			TextBox.TextColor3 = Color3.new(0.870588, 0.25098, 0.25098)
			wait(0.5)
			TextBox.TextColor3 = Theme.Text
			TextBox.Text = ""
		end
	end)

	GetKey.MouseButton1Click:Connect(function()
		if setclipboard then
			setclipboard(GetKeyURL)
			ArchivableLibGlobal:CreateNotification("Info", "Text copied to clipboard.", 1.5, ArchivableLib.Assets.catLOLImage)
		else
			printPointer("Your executor does not support this function.", 2)
			ArchivableLibGlobal:CreateNotification("Error", "Your executor does not support this function.", 1.5, ArchivableLib.Assets.catLOLImage)
		end
	end)
	
	ArchivableLibGlobal:MakeDraggable(MainFrame)
	ArchivableLibGlobal:MakeBlurEffect(MainFrame)
	MainFrame.Visible = true

	return MainFrame
end

function ArchivableLibGlobal:AddTextLabel(TabData, BlockTitle: string, BlockDescription: string)
	local Theme = TabData.MenuData.Theme
	BlockTitle = #BlockTitle > 27 and string.sub(BlockTitle, 1, 27) or BlockTitle
	BlockDescription = #BlockDescription > 27 and string.sub(BlockDescription, 1, 27) or BlockDescription
	
	local TextLabelRandom = Instance.new("Frame")
	TextLabelRandom.Name = "TextLabel_" .. generateRandomString(10)
	TextLabelRandom.Parent = TabData.Page
	TextLabelRandom.BackgroundColor3 = Theme.ElementBG
	TextLabelRandom.BackgroundTransparency = 0.7
	TextLabelRandom.BorderSizePixel = 0
	TextLabelRandom.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TextLabelRandom.Size = UDim2.new(0.982, 0,0.178, 0)
	TextLabelRandom.Position = UDim2.new(0.01431, 0, 0, 0)

	local Corner = Instance.new("UICorner")
	Corner.Parent = TextLabelRandom

	local FrameAspectRatio = Instance.new("UIAspectRatioConstraint", TextLabelRandom)
	FrameAspectRatio.AspectRatio = 10.654

	local TitleLabel = Instance.new("TextLabel")
	TitleLabel.Name = "Title"
	TitleLabel.Parent = TextLabelRandom
	TitleLabel.Text = BlockTitle or ArchivableLib.Assets.NotSetText
	TitleLabel.TextColor3 = Theme.Text
	TitleLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TitleLabel.BackgroundTransparency = 1
	TitleLabel.Size = UDim2.new(0.59399, 0, 0.46296, 0)
	TitleLabel.Position = UDim2.new(-0.00188, 0, 0.05556, 0)
	TitleLabel.FontFace = Font.new("rbxasset://fonts/families/RobotoMono.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	TitleLabel.TextSize = 14
	TitleLabel.TextScaled = true
	TitleLabel.TextWrapped = true
	TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
	TitleLabel.BorderSizePixel = 0
	TitleLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)

	local TitlePadding = Instance.new("UIPadding")
	TitlePadding.Parent = TitleLabel
	TitlePadding.PaddingLeft = UDim.new(0, 10)

	local TitleTextSizeConstraint = Instance.new("UITextSizeConstraint", TitleLabel)
	TitleTextSizeConstraint.MaxTextSize = 25

	local TitleAspectRatio = Instance.new("UIAspectRatioConstraint", TitleLabel)
	TitleAspectRatio.AspectRatio = 12.64

	local DescriptionLabel = Instance.new("TextLabel")
	DescriptionLabel.Name = "Description"
	DescriptionLabel.Parent = TextLabelRandom
	DescriptionLabel.Text = BlockDescription or ArchivableLib.Assets.NotSetText
	DescriptionLabel.TextColor3 = Theme.Text
	DescriptionLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	DescriptionLabel.BackgroundTransparency = 1
	DescriptionLabel.Size = UDim2.new(0.59399, 0, 0.46296, 0)
	DescriptionLabel.Position = UDim2.new(0, 0, 0.51852, 0)
	DescriptionLabel.FontFace = Font.new("rbxasset://fonts/families/RobotoMono.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	DescriptionLabel.TextSize = 14
	DescriptionLabel.TextScaled = true
	DescriptionLabel.TextWrapped = true
	DescriptionLabel.TextXAlignment = Enum.TextXAlignment.Left
	DescriptionLabel.BorderSizePixel = 0
	DescriptionLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)

	local DescriptionPadding = Instance.new("UIPadding")
	DescriptionPadding.Parent = DescriptionLabel
	DescriptionPadding.PaddingLeft = UDim.new(0, 10)

	local DescriptionTextSizeConstraint = Instance.new("UITextSizeConstraint", DescriptionLabel)
	DescriptionTextSizeConstraint.MaxTextSize = 25

	local DescriptionAspectRatio = Instance.new("UIAspectRatioConstraint", DescriptionLabel)
	DescriptionAspectRatio.AspectRatio = 12.64

	return TextLabelRandom
end

function ArchivableLibGlobal:AddButton(TabData, BlockTitle: string, BlockDescription: string, PressCallback)
	local Theme = TabData.MenuData.Theme
	BlockTitle = #BlockTitle > 27 and string.sub(BlockTitle, 1, 27) or BlockTitle
	BlockDescription = #BlockDescription > 27 and string.sub(BlockDescription, 1, 27) or BlockDescription
	
	local ButtonRandom = Instance.new("TextButton")
	ButtonRandom.Name = "Button_" .. generateRandomString(10)
	ButtonRandom.Parent = TabData.Page
	ButtonRandom.Text = ""
	ButtonRandom.TextColor3 = Color3.fromRGB(0, 0, 0)
	ButtonRandom.BackgroundColor3 = Theme.ElementBG
	ButtonRandom.BackgroundTransparency = 0.7
	ButtonRandom.BorderSizePixel = 0
	ButtonRandom.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ButtonRandom.Size = UDim2.new(0.982, 0, 0.178, 0)
	ButtonRandom.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
	ButtonRandom.TextSize = 14
	ButtonRandom.TextWrapped = true

	local Corner = Instance.new("UICorner")
	Corner.Parent = ButtonRandom

	local ButtonAspectRatio = Instance.new("UIAspectRatioConstraint", ButtonRandom)
	ButtonAspectRatio.AspectRatio = 10.654

	local TitleLabel = Instance.new("TextLabel")
	TitleLabel.Name = "Title"
	TitleLabel.Parent = ButtonRandom
	TitleLabel.Text = BlockTitle or ArchivableLib.Assets.NotSetText
	TitleLabel.TextColor3 = Theme.Text
	TitleLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TitleLabel.BackgroundTransparency = 1
	TitleLabel.Size = UDim2.new(0.59399, 0, 0.46296, 0)
	TitleLabel.Position = UDim2.new(-0.00188, 0, 0.05556, 0)
	TitleLabel.FontFace = Font.new("rbxasset://fonts/families/RobotoMono.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	TitleLabel.TextSize = 14
	TitleLabel.TextScaled = true
	TitleLabel.TextWrapped = true
	TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
	TitleLabel.BorderSizePixel = 0
	TitleLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)

	local TitlePadding = Instance.new("UIPadding", TitleLabel)
	TitlePadding.PaddingLeft = UDim.new(0, 10)

	local TitleTextSizeConstraint = Instance.new("UITextSizeConstraint", TitleLabel)
	TitleTextSizeConstraint.MaxTextSize = 25

	local TitleAspectRatio = Instance.new("UIAspectRatioConstraint", TitleLabel)
	TitleAspectRatio.AspectRatio = 12.64

	local DescriptionLabel = Instance.new("TextLabel")
	DescriptionLabel.Name = "Description"
	DescriptionLabel.Parent = ButtonRandom
	DescriptionLabel.Text = BlockDescription or ArchivableLib.Assets.NotSetText
	DescriptionLabel.TextColor3 = Theme.Text
	DescriptionLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	DescriptionLabel.BackgroundTransparency = 1
	DescriptionLabel.Size = UDim2.new(0.59399, 0, 0.46296, 0)
	DescriptionLabel.Position = UDim2.new(0, 0, 0.51852, 0)
	DescriptionLabel.FontFace = Font.new("rbxasset://fonts/families/RobotoMono.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	DescriptionLabel.TextSize = 14
	DescriptionLabel.TextScaled = true
	DescriptionLabel.TextWrapped = true
	DescriptionLabel.TextXAlignment = Enum.TextXAlignment.Left
	DescriptionLabel.BorderSizePixel = 0
	DescriptionLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)

	local DescriptionPadding = Instance.new("UIPadding", DescriptionLabel)
	DescriptionPadding.PaddingLeft = UDim.new(0, 10)

	local DescriptionTextSizeConstraint = Instance.new("UITextSizeConstraint", DescriptionLabel)
	DescriptionTextSizeConstraint.MaxTextSize = 25

	local DescriptionAspectRatio = Instance.new("UIAspectRatioConstraint", DescriptionLabel)
	DescriptionAspectRatio.AspectRatio = 12.64

	local Icon = Instance.new("ImageLabel", ButtonRandom)
	Icon.Name = "ImageLabel"
	Icon.Image = "rbxassetid://128862014045443"
	Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Icon.BackgroundTransparency = 1
	Icon.BorderSizePixel = 0
	Icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Icon.Size = UDim2.new(0.06432, 0, 0.68523, 0)
	Icon.Position = UDim2.new(0.92433, 0, 0.15345, 0)

	local IconAspectRatio = Instance.new("UIAspectRatioConstraint", Icon)

	if type(PressCallback) == "function" then
		ButtonRandom.MouseButton1Click:Connect(PressCallback)

		ButtonRandom.MouseEnter:Connect(function()
			ButtonRandom.BackgroundTransparency = 0.5
		end)

		ButtonRandom.MouseLeave:Connect(function()
			ButtonRandom.BackgroundTransparency = 0.7
		end)
	end

	return ButtonRandom
end

function ArchivableLibGlobal:AddSlider(TabData, BlockTitle: string, BlockDescription: string, PressCallback)
	local Theme = TabData.MenuData.Theme
	BlockTitle = #BlockTitle > 27 and string.sub(BlockTitle, 1, 27) or BlockTitle
	BlockDescription = #BlockDescription > 27 and string.sub(BlockDescription, 1, 27) or BlockDescription
	
	local Slider_Random = Instance.new("TextButton")
	Slider_Random.Parent = TabData.Page
	Slider_Random.TextWrapped = true
	Slider_Random.BorderSizePixel = 0
	Slider_Random.TextSize = 14
	Slider_Random.TextColor3 = Color3.fromRGB(0, 0, 0)
	Slider_Random.BackgroundColor3 = Theme.ElementBG
	Slider_Random.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
	Slider_Random.BackgroundTransparency = 0.7
	Slider_Random.Size = UDim2.new(0.982, 0, 0.178, 0)
	Slider_Random.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Slider_Random.Text = ""
	Slider_Random.Name = "Slider_" .. generateRandomString(10)

	local UICorner_3 = Instance.new("UICorner", Slider_Random)

	local UIAspectRatioConstraint_3 = Instance.new("UIAspectRatioConstraint", Slider_Random)
	UIAspectRatioConstraint_3.AspectRatio = 10.654

	local Title = Instance.new("TextLabel")
	Title.Parent = Slider_Random
	Title.TextWrapped = true
	Title.BorderSizePixel = 0
	Title.TextSize = 14
	Title.TextXAlignment = Enum.TextXAlignment.Left
	Title.TextScaled = true
	Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Title.FontFace = Font.new("rbxasset://fonts/families/RobotoMono.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	Title.TextColor3 = Theme.Text
	Title.BackgroundTransparency = 1
	Title.Size = UDim2.new(0.59399, 0, 0.46296, 0)
	Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Title.Text = BlockTitle or ArchivableLib.Assets.NotSetText
	Title.Name = "Title"
	Title.Position = UDim2.new(-0.00188, 0, 0.05556, 0)

	local UIPadding_1 = Instance.new("UIPadding", Title)
	UIPadding_1.PaddingLeft = UDim.new(0, 10)

	local UITextSizeConstraint_1 = Instance.new("UITextSizeConstraint", Title)
	UITextSizeConstraint_1.MaxTextSize = 25
	local UIAspectRatioConstraint_4 = Instance.new("UIAspectRatioConstraint", Title)
	UIAspectRatioConstraint_4.AspectRatio = 12.64

	local Description = Instance.new("TextLabel")
	Description.Parent = Slider_Random
	Description.TextWrapped = true
	Description.BorderSizePixel = 0
	Description.TextSize = 14
	Description.TextXAlignment = Enum.TextXAlignment.Left
	Description.TextScaled = true
	Description.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Description.FontFace = Font.new("rbxasset://fonts/families/RobotoMono.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	Description.TextColor3 = Theme.Text
	Description.BackgroundTransparency = 1
	Description.Size = UDim2.new(0.59399, 0, 0.46296, 0)
	Description.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Description.Text = BlockDescription or ArchivableLib.Assets.NotSetText
	Description.Name = "Description"
	Description.Position = UDim2.new(0, 0, 0.51852, 0)

	local UIPadding_2 = Instance.new("UIPadding", Description)
	UIPadding_2.PaddingLeft = UDim.new(0, 10)
	
	local UITextSizeConstraint_2 = Instance.new("UITextSizeConstraint", Description)
	UITextSizeConstraint_2.MaxTextSize = 25

	local UIAspectRatioConstraint_5 = Instance.new("UIAspectRatioConstraint", Description)
	UIAspectRatioConstraint_5.AspectRatio = 12.64

	local Slider = Instance.new("Frame")
	Slider.Parent = Slider_Random
	Slider.BorderSizePixel = 0
	Slider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Slider.Size = UDim2.new(0.07585, 0, 0.36367, 0)
	Slider.Position = UDim2.new(0.89373, 0, 0.31049, 0)
	Slider.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Slider.Name = "Slider"

	local Dot = Instance.new("Frame")
	Dot.Parent = Slider
	Dot.BorderSizePixel = 0
	Dot.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Dot.Size = UDim2.new(0.625, 0, 1.38889, 0)
	Dot.Position = UDim2.new(-0.13486, 0, -0.2381, 0)
	Dot.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Dot.Name = "Dot"

	local UICorner_4 = Instance.new("UICorner", Dot)
	UICorner_4.CornerRadius = UDim.new(1, 0)

	local UIAspectRatioConstraint_6 = Instance.new("UIAspectRatioConstraint", Dot)

	local UICorner_5 = Instance.new("UICorner", Slider)
	UICorner_5.CornerRadius = UDim.new(0, 6)

	local UIAspectRatioConstraint_7 = Instance.new("UIAspectRatioConstraint", Slider)
	UIAspectRatioConstraint_7.AspectRatio = 2.22222
	
	local state = false
	local bg, active, clicker = Slider, Dot, Slider_Random
	local info = TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
	
	local function toggle()
		local posX = state and 0.688 or -0.135
		local colBg = state and Color3.new(0.13, 1, 0) or Color3.new(1, 0.13, 0.13)
		local colDot = state and Color3.new(0.08, 0.63, 0) or Color3.new(0.63, 0.08, 0.08)

		TweenService:Create(active, info, {
			Position = UDim2.new(posX, 0, active.Position.Y.Scale, active.Position.Y.Offset),
			BackgroundColor3 = colDot
		}):Play()

		TweenService:Create(bg, info, {BackgroundColor3 = colBg}):Play()
	end
	
	toggle()
	
	Slider_Random.MouseButton1Click:Connect(function()
		state = not state
		toggle()
		if PressCallback then
			PressCallback(state)
		end
	end)
end

function ArchivableLibGlobal:AddSeparator(TabData, BlockText: string)
	local Theme = TabData.MenuData.Theme
	BlockText = #BlockText > 40 and string.sub(BlockText, 1, 40) or BlockText
	
	local Separator = Instance.new("TextLabel")
	Separator.Name = "Separator_" .. generateRandomString(10)
	Separator.Parent = TabData.Page
	Separator.Text = BlockText or ArchivableLib.Assets.NotSetText
	Separator.TextColor3 = Theme.Text
	Separator.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Separator.BackgroundTransparency = 1
	Separator.Size = UDim2.new(1.15541, 0, 0.07516, 0)
	Separator.Position = UDim2.new(-0.1888, 0, 0.58794, 0)
	Separator.FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
	Separator.TextSize = 14
	Separator.TextScaled = true
	Separator.TextWrapped = true
	Separator.TextXAlignment = Enum.TextXAlignment.Left
	Separator.BorderSizePixel = 0

	local SeparatorAspectRatio = Instance.new("UIAspectRatioConstraint", Separator)
	SeparatorAspectRatio.AspectRatio = 25.23212

	local SeparatorTextSizeConstraint = Instance.new("UITextSizeConstraint", Separator)
	SeparatorTextSizeConstraint.MaxTextSize = 20
end

function ArchivableLibGlobal:AddInputValue(TabData, BlockTitle: string, BlockDescription: string, PlaceHolderText: string, OnEditCompleteCallback)
	local Theme = TabData.MenuData.Theme
	BlockTitle = #BlockTitle > 27 and string.sub(BlockTitle, 1, 27) or BlockTitle
	BlockDescription = #BlockDescription > 27 and string.sub(BlockDescription, 1, 27) or BlockDescription
	
	local InputValue_Random = Instance.new("Frame")
	InputValue_Random.Name = "InputValue_" .. generateRandomString(10)
	InputValue_Random.Parent = TabData.Page
	InputValue_Random.BorderSizePixel = 0
	InputValue_Random.BackgroundColor3 = Theme.ElementBG
	InputValue_Random.Size = UDim2.new(0.982, 0, 0.178, 0)
	InputValue_Random.Position = UDim2.new(0.01431, 0, 0, 0)
	InputValue_Random.BorderColor3 = Color3.fromRGB(0, 0, 0)
	InputValue_Random.BackgroundTransparency = 0.7

	local UICorner_3 = Instance.new("UICorner")
	UICorner_3.Parent = InputValue_Random

	local UIAspectRatioConstraint_3 = Instance.new("UIAspectRatioConstraint")
	UIAspectRatioConstraint_3.Parent = InputValue_Random
	UIAspectRatioConstraint_3.AspectRatio = 10.654

	local InputBox = Instance.new("TextBox")
	InputBox.Name = "InputBox"
	InputBox.Parent = InputValue_Random
	InputBox.CursorPosition = -1
	InputBox.BorderSizePixel = 0
	InputBox.TextWrapped = false
	InputBox.TextSize = 14
	InputBox.TextColor3 = Theme.Text
	InputBox.TextScaled = true
	InputBox.BackgroundColor3 = Theme.ElementActiveBG
	InputBox.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	InputBox.Size = UDim2.new(0.258, 0,0.687, 0)
	InputBox.Position = UDim2.new(0.72441, 0, 0.14143, 0)
	InputBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
	InputBox.Text = ""
	InputBox.PlaceholderText = PlaceHolderText or ArchivableLib.Assets.NotSetText
	InputBox.BackgroundTransparency = 0.8
	
	local UIAspectRatio = Instance.new("UIAspectRatioConstraint")
	UIAspectRatio.Parent = InputBox
	UIAspectRatio.AspectRatio = 4
	UIAspectRatio.DominantAxis = Enum.DominantAxis.Width
	UIAspectRatio.AspectType = Enum.AspectType.FitWithinMaxSize

	local UITextSizeConstraint = Instance.new("UITextSizeConstraint")
	UITextSizeConstraint.Parent = InputBox
	UITextSizeConstraint.MaxTextSize = 25

	local UICorner_4 = Instance.new("UICorner")
	UICorner_4.Parent = InputBox

	local Title = Instance.new("TextLabel")
	Title.Name = "Title"
	Title.Parent = InputValue_Random
	Title.TextWrapped = true
	Title.BorderSizePixel = 0
	Title.TextSize = 14
	Title.TextXAlignment = Enum.TextXAlignment.Left
	Title.TextScaled = true
	Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Title.FontFace = Font.new("rbxasset://fonts/families/RobotoMono.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	Title.TextColor3 = Theme.Text
	Title.BackgroundTransparency = 1
	Title.Size = UDim2.new(0.59399, 0, 0.46296, 0)
	Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Title.Text = BlockTitle or ArchivableLib.Assets.NotSetText
	Title.Position = UDim2.new(-0.00188, 0, 0.05556, 0)

	local UIPadding = Instance.new("UIPadding")
	UIPadding.Parent = Title
	UIPadding.PaddingLeft = UDim.new(0, 10)

	local UITextSizeConstraint_2 = Instance.new("UITextSizeConstraint")
	UITextSizeConstraint_2.Parent = Title
	UITextSizeConstraint_2.MaxTextSize = 25

	local UIAspectRatioConstraint_4 = Instance.new("UIAspectRatioConstraint")
	UIAspectRatioConstraint_4.Parent = Title
	UIAspectRatioConstraint_4.AspectRatio = 12.64

	local Description = Instance.new("TextLabel")
	Description.Name = "Description"
	Description.Parent = InputValue_Random
	Description.TextWrapped = true
	Description.BorderSizePixel = 0
	Description.TextSize = 14
	Description.TextXAlignment = Enum.TextXAlignment.Left
	Description.TextScaled = true
	Description.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Description.FontFace = Font.new("rbxasset://fonts/families/RobotoMono.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	Description.TextColor3 = Theme.Text
	Description.BackgroundTransparency = 1
	Description.Size = UDim2.new(0.59399, 0, 0.46296, 0)
	Description.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Description.Text = BlockDescription or ArchivableLib.Assets.NotSetText
	Description.Position = UDim2.new(0, 0, 0.51852, 0)

	local UIPadding_2 = Instance.new("UIPadding")
	UIPadding_2.Parent = Description
	UIPadding_2.PaddingLeft = UDim.new(0, 10)

	local UITextSizeConstraint_3 = Instance.new("UITextSizeConstraint")
	UITextSizeConstraint_3.Parent = Description
	UITextSizeConstraint_3.MaxTextSize = 25

	local UIAspectRatioConstraint_5 = Instance.new("UIAspectRatioConstraint")
	UIAspectRatioConstraint_5.Parent = Description
	UIAspectRatioConstraint_5.AspectRatio = 12.64
	
	InputBox.FocusLost:Connect(function()
		if OnEditCompleteCallback then
			OnEditCompleteCallback(InputBox.Text)
		end
	end)
end

--End
ArchivableLibGlobal:CreateNotification("Hello!", "ArchivableLib Loaded!", 3, _G.ALib.Assets.dogLOLImage)
ArchivableLibGlobal:CreateNotification("Developed:", "xolaDev", 3, _G.ALib.Assets.dogLOLImage)
