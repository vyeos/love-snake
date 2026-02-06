local Settings = {}

function Settings.load()
	Settings.gridXCount = 20
	Settings.gridYCount = 15
	Settings.cellSize = 15
	Settings.wrappingEnabled = true
	Settings.moveInterval = 0.15
	Settings.speedMin = 0.05
	Settings.speedMax = 0.3
	Settings.speedStep = 0.01
	Settings.shapeStyle = "square"
	Settings.soundEnabled = false
	Settings.themeName = "Default"
	Settings.themes = {
		Default = {
			background = { 0.12, 0.12, 0.12 },
			menuPanel = { 0.28, 0.28, 0.28 },
			titleText = { 0.85, 0.95, 0.8 },
			selectedHighlight = { 0.6, 1, 0.32 },
			selectedText = { 0.1, 0.2, 0.1 },
			menuText = { 0.9, 0.9, 0.9 },
			hintText = { 0.75, 0.75, 0.75 },
			overlayDim = { 0, 0, 0, 0.75 },
			modalPanel = { 0.2, 0.2, 0.2 },
			modalHintText = { 0.7, 0.7, 0.7 },
			settingsHighlight = { 0.6, 1, 0.32 },
			settingsHighlightText = { 0.1, 0.2, 0.1 },
			settingsText = { 0.9, 0.9, 0.9 },
			sliderTrack = { 0.35, 0.35, 0.35 },
			sliderKnob = { 0.8, 0.8, 0.8 },
			playfield = { 0.28, 0.28, 0.28 },
			snakeAlive = { 0.6, 1, 0.32 },
			snakeDead = { 0.5, 0.5, 0.5 },
			food = { 1, 0.3, 0.3 },
			hudText = { 0.85, 0.85, 0.85 },
		},
		["Rose Pine"] = {
			background = { 0.11, 0.1, 0.14 },
			menuPanel = { 0.16, 0.15, 0.19 },
			titleText = { 0.88, 0.83, 0.92 },
			selectedHighlight = { 0.62, 0.75, 0.67 },
			selectedText = { 0.15, 0.18, 0.16 },
			menuText = { 0.88, 0.85, 0.9 },
			hintText = { 0.72, 0.69, 0.75 },
			overlayDim = { 0, 0, 0, 0.7 },
			modalPanel = { 0.14, 0.13, 0.17 },
			modalHintText = { 0.68, 0.65, 0.7 },
			sliderTrack = { 0.22, 0.21, 0.26 },
			sliderKnob = { 0.82, 0.79, 0.86 },
			playfield = { 0.16, 0.15, 0.19 },
			snakeAlive = { 0.62, 0.75, 0.67 },
			snakeDead = { 0.46, 0.46, 0.5 },
			food = { 0.93, 0.55, 0.6 },
			hudText = { 0.85, 0.82, 0.88 },
			settingsHighlight = { 0.62, 0.75, 0.67 },
			settingsHighlightText = { 0.15, 0.18, 0.16 },
			settingsText = { 0.88, 0.85, 0.9 },
		},
		["Catppuccin (Mocha)"] = {
			background = { 0.12, 0.12, 0.18 },
			menuPanel = { 0.18, 0.18, 0.26 },
			titleText = { 0.92, 0.9, 0.96 },
			selectedHighlight = { 0.65, 0.78, 0.93 },
			selectedText = { 0.15, 0.18, 0.24 },
			menuText = { 0.9, 0.9, 0.92 },
			hintText = { 0.75, 0.75, 0.8 },
			overlayDim = { 0, 0, 0, 0.75 },
			modalPanel = { 0.16, 0.16, 0.22 },
			modalHintText = { 0.7, 0.7, 0.75 },
			sliderTrack = { 0.3, 0.3, 0.4 },
			sliderKnob = { 0.85, 0.85, 0.9 },
			playfield = { 0.18, 0.18, 0.26 },
			snakeAlive = { 0.65, 0.78, 0.93 },
			snakeDead = { 0.5, 0.5, 0.6 },
			food = { 0.96, 0.55, 0.6 },
			hudText = { 0.88, 0.88, 0.9 },
			settingsHighlight = { 0.65, 0.78, 0.93 },
			settingsHighlightText = { 0.15, 0.18, 0.24 },
			settingsText = { 0.9, 0.9, 0.92 },
		},
		["Gruvbox (Dark)"] = {
			background = { 0.11, 0.10, 0.09 },
			menuPanel = { 0.18, 0.16, 0.14 },
			titleText = { 0.98, 0.87, 0.68 },
			selectedHighlight = { 0.72, 0.73, 0.35 },
			selectedText = { 0.18, 0.2, 0.1 },
			menuText = { 0.9, 0.86, 0.8 },
			hintText = { 0.7, 0.65, 0.55 },
			modalPanel = { 0.15, 0.13, 0.11 },
			sliderTrack = { 0.32, 0.28, 0.24 },
			sliderKnob = { 0.85, 0.8, 0.65 },
			snakeAlive = { 0.72, 0.73, 0.35 },
			food = { 0.8, 0.2, 0.2 },
			settingsHighlight = { 0.72, 0.73, 0.35 },
			settingsHighlightText = { 0.18, 0.2, 0.1 },
			settingsText = { 0.9, 0.86, 0.8 },
			hintText = { 0.7, 0.65, 0.55 },
			modalHintText = { 0.7, 0.65, 0.55 },
			overlayDim = { 0, 0, 0, 0.75 },
			playfield = { 0.18, 0.16, 0.14 },
			snakeDead = { 0.5, 0.5, 0.5 },
			hudText = { 0.85, 0.82, 0.75 },
		},
		["Solarized Dark"] = {
			background = { 0.0, 0.17, 0.21 },
			menuPanel = { 0.02, 0.21, 0.26 },
			titleText = { 0.51, 0.58, 0.59 },
			selectedHighlight = { 0.52, 0.6, 0.0 },
			selectedText = { 0.1, 0.2, 0.1 },
			menuText = { 0.58, 0.63, 0.63 },
			snakeAlive = { 0.52, 0.6, 0.0 },
			food = { 0.86, 0.2, 0.18 },
			settingsHighlight = { 0.52, 0.6, 0.0 },
			settingsHighlightText = { 0.1, 0.2, 0.1 },
			settingsText = { 0.58, 0.63, 0.63 },
			hintText = { 0.51, 0.58, 0.59 },
			modalPanel = { 0.02, 0.21, 0.26 },
			modalHintText = { 0.51, 0.58, 0.59 },
			overlayDim = { 0, 0, 0, 0.75 },
			sliderTrack = { 0.1, 0.25, 0.3 },
			sliderKnob = { 0.65, 0.7, 0.7 },
			playfield = { 0.02, 0.21, 0.26 },
			snakeDead = { 0.35, 0.4, 0.4 },
			hudText = { 0.58, 0.63, 0.63 },
		},
		["Tokyo Night"] = {
			background = { 0.07, 0.08, 0.13 },
			menuPanel = { 0.12, 0.14, 0.22 },
			titleText = { 0.9, 0.92, 0.98 },
			selectedHighlight = { 0.48, 0.7, 0.95 },
			selectedText = { 0.1, 0.15, 0.25 },
			menuText = { 0.85, 0.88, 0.95 },
			snakeAlive = { 0.48, 0.7, 0.95 },
			food = { 0.95, 0.3, 0.45 },
			settingsHighlight = { 0.48, 0.7, 0.95 },
			settingsHighlightText = { 0.1, 0.15, 0.25 },
			settingsText = { 0.85, 0.88, 0.95 },
			hintText = { 0.75, 0.78, 0.85 },
			modalPanel = { 0.12, 0.14, 0.22 },
			modalHintText = { 0.75, 0.78, 0.85 },
			overlayDim = { 0, 0, 0, 0.75 },
			sliderTrack = { 0.2, 0.22, 0.32 },
			sliderKnob = { 0.85, 0.88, 0.95 },
			playfield = { 0.12, 0.14, 0.22 },
			snakeDead = { 0.45, 0.48, 0.6 },
			hudText = { 0.85, 0.88, 0.95 },
		},
		Cyberpunk = {
			background = { 0.05, 0.05, 0.07 },
			menuPanel = { 0.12, 0.0, 0.15 },
			titleText = { 1.0, 0.95, 0.2 },
			selectedHighlight = { 0.0, 0.95, 1.0 },
			selectedText = { 0.0, 0.1, 0.1 },
			menuText = { 0.95, 0.95, 0.95 },
			snakeAlive = { 0.0, 0.95, 1.0 },
			food = { 1.0, 0.1, 0.6 },
			settingsHighlight = { 0.0, 0.95, 1.0 },
			settingsHighlightText = { 0.0, 0.1, 0.1 },
			settingsText = { 0.95, 0.95, 0.95 },
			hintText = { 0.9, 0.9, 0.9 },
			modalPanel = { 0.12, 0.0, 0.15 },
			modalHintText = { 0.9, 0.9, 0.9 },
			overlayDim = { 0, 0, 0, 0.75 },
			sliderTrack = { 0.25, 0.05, 0.3 },
			sliderKnob = { 1.0, 0.95, 0.2 },
			playfield = { 0.12, 0.0, 0.15 },
			snakeDead = { 0.3, 0.3, 0.35 },
			hudText = { 0.95, 0.95, 0.95 },
		},
		["One Dark"] = {
			background = { 0.11, 0.12, 0.14 },
			menuPanel = { 0.17, 0.18, 0.21 },
			titleText = { 0.85, 0.88, 0.92 },
			selectedHighlight = { 0.38, 0.66, 0.85 },
			menuText = { 0.83, 0.85, 0.88 },
			snakeAlive = { 0.38, 0.66, 0.85 },
			food = { 0.9, 0.35, 0.35 },
			settingsHighlight = { 0.38, 0.66, 0.85 },
			settingsHighlightText = { 0.1, 0.15, 0.2 },
			settingsText = { 0.83, 0.85, 0.88 },
			hintText = { 0.7, 0.72, 0.78 },
			modalPanel = { 0.17, 0.18, 0.21 },
			modalHintText = { 0.7, 0.72, 0.78 },
			overlayDim = { 0, 0, 0, 0.75 },
			sliderTrack = { 0.28, 0.3, 0.35 },
			sliderKnob = { 0.85, 0.88, 0.92 },
			playfield = { 0.17, 0.18, 0.21 },
			snakeDead = { 0.5, 0.5, 0.55 },
			hudText = { 0.83, 0.85, 0.88 },
		},
		Nord = {
			background = { 0.15, 0.17, 0.21 },
			menuPanel = { 0.2, 0.22, 0.27 },
			titleText = { 0.88, 0.9, 0.94 },
			selectedHighlight = { 0.53, 0.75, 0.82 },
			menuText = { 0.85, 0.87, 0.9 },
			snakeAlive = { 0.53, 0.75, 0.82 },
			food = { 0.75, 0.38, 0.42 },
			settingsHighlight = { 0.53, 0.75, 0.82 },
			settingsHighlightText = { 0.12, 0.18, 0.22 },
			settingsText = { 0.85, 0.87, 0.9 },
			hintText = { 0.7, 0.75, 0.8 },
			modalPanel = { 0.2, 0.22, 0.27 },
			modalHintText = { 0.7, 0.75, 0.8 },
			overlayDim = { 0, 0, 0, 0.75 },
			sliderTrack = { 0.28, 0.32, 0.38 },
			sliderKnob = { 0.88, 0.9, 0.94 },
			playfield = { 0.2, 0.22, 0.27 },
			snakeDead = { 0.5, 0.55, 0.6 },
			hudText = { 0.85, 0.87, 0.9 },
		},
		Kanagawa = {
			background = { 0.1, 0.09, 0.08 },
			menuPanel = { 0.16, 0.14, 0.12 },
			titleText = { 0.92, 0.86, 0.7 },
			selectedHighlight = { 0.72, 0.54, 0.35 },
			menuText = { 0.9, 0.85, 0.78 },
			snakeAlive = { 0.72, 0.54, 0.35 },
			food = { 0.8, 0.25, 0.25 },
			settingsHighlight = { 0.72, 0.54, 0.35 },
			settingsHighlightText = { 0.18, 0.14, 0.1 },
			settingsText = { 0.9, 0.85, 0.78 },
			hintText = { 0.72, 0.66, 0.58 },
			modalPanel = { 0.16, 0.14, 0.12 },
			modalHintText = { 0.72, 0.66, 0.58 },
			overlayDim = { 0, 0, 0, 0.75 },
			sliderTrack = { 0.26, 0.22, 0.2 },
			sliderKnob = { 0.92, 0.86, 0.7 },
			playfield = { 0.16, 0.14, 0.12 },
			snakeDead = { 0.5, 0.45, 0.4 },
			hudText = { 0.9, 0.85, 0.78 },
		},
	}
	local defaultTheme = Settings.themes.Default
	for _, theme in pairs(Settings.themes) do
		for key, value in pairs(defaultTheme) do
			if theme[key] == nil then
				theme[key] = value
			end
		end
	end
	Settings.themeOrder = {
		"Default",
		"Rose Pine",
		"Catppuccin (Mocha)",
		"Gruvbox (Dark)",
		"Solarized Dark",
		"Tokyo Night",
		"Cyberpunk",
		"One Dark",
		"Nord",
		"Kanagawa",
	}
	Settings.titleFont = love.graphics.newFont(26)
	Settings.menuFont = love.graphics.newFont(14)
	Settings.hintFont = love.graphics.newFont(11)
	Settings.sounds = {
		eat = love.audio.newSource("gawk.mp3", "static"),
		die = love.audio.newSource("moan.mp3", "static"),
	}
end

function Settings.reset(settings)
	settings.wrappingEnabled = true
	settings.moveInterval = 0.15
	settings.shapeStyle = "square"
	settings.soundEnabled = false
	settings.themeName = "Default"
end

function Settings.getTheme(settings)
	return settings.themes[settings.themeName] or settings.themes.Default
end

function Settings.changeTheme(settings, direction)
	local currentIndex = 1
	for index, name in ipairs(settings.themeOrder) do
		if name == settings.themeName then
			currentIndex = index
			break
		end
	end
	local nextIndex = currentIndex + direction
	if nextIndex < 1 then
		nextIndex = #settings.themeOrder
	elseif nextIndex > #settings.themeOrder then
		nextIndex = 1
	end
	settings.themeName = settings.themeOrder[nextIndex]
end

return Settings
