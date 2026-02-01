loadstring(game:HttpGet("https://raw.githubusercontent.com/xoladev/ArchivableLib/refs/heads/main/lib.lua"))()

local ALib = _G.ALib

function MenuFunc()
	local myMenu = ALib:CreateMenu("LibDemo", "Archivable Library Demo", "Midnight")
	local ElementsTab = ALib:AddTab(myMenu, "Elements", ALib.Assets.dogLOLImage)
	local SettingsTab = ALib:AddTab(myMenu, "Settings", ALib.Assets.catLOLImage)

	local function toggleMenu()
		myMenu.Main.Visible = not myMenu.Main.Visible
	end
	
	local function buttonClick()
		ALib:CreateNotification("Button clicked!", "", 1.5, ALib.Assets.catLOLImage)
	end
	local function sliderClick(state)
		ALib:CreateNotification("Slider Clicked!", "Current State: " .. tostring(state), 1.5, ALib.Assets.catLOLImage)
	end
	local function InputValueEdited(text)
		ALib:CreateNotification("New text!", text, 1.5, ALib.Assets.catLOLImage)
	end

	ALib:AddTextLabel(ElementsTab, "Text Label", "Description")
	ALib:AddSeparator(ElementsTab, "Separator")
	ALib:AddButton(ElementsTab, "Button", "Description", buttonClick)
	ALib:AddSlider(ElementsTab, "Slider", "Description", sliderClick)
	ALib:AddInputValue(ElementsTab, "Input Value", "Description", "PlaceHolder", InputValueEdited)
	
	ALib:CreateFloatingButton("DemoToggleMenu", ALib.Assets.catLOLImage, 999, toggleMenu)

	ALib:AddButton(SettingsTab, "Unload Library", "Deletes GUIs.", function()
		ALib:DestroyLib()
	end)
end

ALib:NewTheme({
	ThemeName = "Midnight",
	Bg = Color3.fromRGB(20, 20, 20),
	ElementBG = Color3.fromRGB(40, 40, 40),
	Text = Color3.fromRGB(255, 255, 255),
	Accent = Color3.fromRGB(0, 28, 50),
	Close = Color3.fromRGB(255, 50, 50),
	PlaceHoldersColor = Color3.fromRGB(100, 100, 100),
	ElementActiveBG = Color3.fromRGB(60, 60, 60)
})
ALib:CreateKeySystem("", "Its working!", "Archivable Library Demo (Press 'CheckKey')", "WhiteTheme", MenuFunc)
