# ✨ Archivable Library

> **Archivable Library** — это современная, быстрая и эстетичная библиотека интерфейсов для Roblox Luau, разработанная с упором на плавность, эффекты размытия и простоту использования.

---

## 🚀 Особенности
* 🎨 **Modern Design** — Минималистичный стиль и поддержка тем (Dark Theme).
* 🌫️ **Visual Effects** — Встроенные функции для создания Blur-эффектов.
* ⚡ **Easy Integration** — Быстрый доступ через глобальную переменную `_G.ALib`.
* 🖱️ **User Experience** — Встроенная система Drag-and-Drop и умные уведомления.
* 📱 **Responsive UI** — Адаптивные элементы интерфейса с поддержкой скроллинга.
* 🔑 **Key System** — Встроенная система ключей для защиты ваших скриптов.

---

## 🎨 Темы

* Тёмная: DarkTheme
* Светлая: WhiteTheme
* Красная (Bug): RedTheme
> [!NOTE]
> Можно добавлять свои темы

---

## 🛠 Полный список функций

> [!TIP]
> Желательно использовать: ```local ALib = _G.ALib```

### Основные функции интерфейса
```lua
-- Создание основного меню (Название в Explorer, Заголовок, Тема)
_G.ALib:CreateMenu(NameInExplorer: string, TitleText: string, ThemeName: string)

-- Добавление вкладок (Объект меню, Название вкладки, ID иконки)
_G.ALib:AddTab(MenuData, TabName: string, ImageID: string)

-- Добавление текстового блока (TabData, Заголовок, Описание)
_G.ALib:AddTextLabel(TabData, BlockTitle: string, BlockDescription: string)

-- Добавление кнопки (TabData, Заголовок, Описание, Callback-функция)
_G.ALib:AddButton(TabData, BlockTitle: string, BlockDescription: string, PressCallback)

-- Добавление слайдера (TabData, Заголовок, Описание, Callback-функция)
_G.ALib:AddSlider(TabData, BlockTitle: string, BlockDescription: string, PressCallback)

-- Добавление элемент ввода значения (TabData, Заголовок, Описание, PlaceHolder, OnEditCompleteCallback)
_G.ALib:AddInputValue(TabData, BlockTitle: string, BlockDescription: string, PlaceHolderText: string, OnEditCompleteCallback)

-- Добавление разделителя (TabData, Текст)
_G.ALib:AddSeparator(TabData, BlockText: string)

-- Создание плавающей кнопки (Название, ID иконки, ZIndex, Callback-функция)
_G.ALib:CreateFloatingButton(NameInExplorer: string, ImageID: string, zindex: number, OnClickedButtonCallback)

-- Создание системы ключей (Валидный ключ, URL для получения ключа, Заголовок, Тема, Callback при успехе)
_G.ALib:CreateKeySystem(ValidKey: string, GetKeyURL: string, WindowTitle: string, ThemeName: string, OKCallBack)

-- Создание уведомления (Заголовок, Сообщение, Время жизни, ID иконки)
_G.ALib:CreateNotification(TitleContent: string, MessageContent: string, TimeDelay: number, ImageID: string)

-- Применение эффекта размытия (Путь к Frame)
_G.ALib:MakeBlurEffect(FramePath)

-- Сделать элемент перетаскиваемым (Путь к Frame)
_G.ALib:MakeDraggable(FramePath: string)

-- Полная очистка и удаление библиотеки
_G.ALib:DestroyLib()
```
---

## ⚡ Начало работы

### Для читов\эксплоитов используйте это:
```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/xoladev/ArchivableLib/refs/heads/main/lib.lua"))()
```

### Для Roblox\Roblox Studio
Данная библиотека пока-что недоступна для Roblox Studio
