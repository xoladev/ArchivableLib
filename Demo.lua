

function menuv()
	local myMenu = _G.ALib:CreateMenu("LibDemo", "Archivable Library Demo", "DarkTheme")
	local ElementsTab = _G.ALib:AddTab(myMenu, "Elements", _G.ALib.Assets.dogLOLImage)
	local SettingsTab = _G.ALib:AddTab(myMenu, "Settings", _G.ALib.Assets.catLOLImage)

	local function toggleMenu()
		myMenu.Main.Visible = not myMenu.Main.Visible
	end
	
	local function buttonClick()
		_G.ALib:CreateNotification("Button clicked!", "", 1.5, _G.ALib.Assets.catLOLImage)
	end
	local function sliderClick(state)
		_G.ALib:CreateNotification("Slider Clicked!", "Current State: " .. tostring(state), 1.5, _G.ALib.Assets.catLOLImage)
	end
	local function InputValueEdited(text)
		_G.ALib:CreateNotification("New text!", text, 1.5, _G.ALib.Assets.catLOLImage)
	end

	_G.ALib:AddTextLabel(ElementsTab, "Text Label", "Description")
	_G.ALib:AddSeparator(ElementsTab, "Separator")
	_G.ALib:AddButton(ElementsTab, "Button", "Description", buttonClick)
	_G.ALib:AddSlider(ElementsTab, "Slider", "Description", sliderClick)
	_G.ALib:AddInputValue(ElementsTab, "Input Value", "Description", "PlaceHolder", InputValueEdited)
	
	_G.ALib:CreateFloatingButton("DemoToggleMenu", _G.ALib.Assets.catLOLImage, 999, toggleMenu)

	_G.ALib:AddButton(SettingsTab, "Unload Library", "Deletes GUIs.", function()
		_G.ALib:DestroyLib()
	end)
end

_G.ALib:CreateKeySystem("", "Its working!", "Archivable Library Demo (Press 'CheckKey')", "WhiteTheme", menuv)
