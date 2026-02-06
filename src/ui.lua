local UI = {}

function UI.load(state, settings)
	local _ = state
	local __ = settings
end

function UI.draw(state, settings)
	local gridWidth = settings.gridXCount * settings.cellSize
	local gridHeight = settings.gridYCount * settings.cellSize
	local isCircle = settings.shapeStyle == "circle"
	local menuRadius = 0
	if isCircle then
		menuRadius = 10
	end
	local theme = settings.getTheme(settings)

	local function drawCell(x, y)
		local cellX = (x - 1) * settings.cellSize
		local cellY = (y - 1) * settings.cellSize
		if isCircle then
			love.graphics.circle(
				"fill",
				cellX + settings.cellSize / 2,
				cellY + settings.cellSize / 2,
				(settings.cellSize - 1) / 2
			)
		else
			love.graphics.rectangle("fill", cellX, cellY, settings.cellSize - 1, settings.cellSize - 1)
		end
	end

	if state.currentScreen == "start" then
		love.graphics.setColor(theme.background)
		love.graphics.rectangle("fill", 0, 0, gridWidth, gridHeight)
		love.graphics.setColor(theme.menuPanel)
		love.graphics.rectangle("fill", 8, 8, gridWidth - 16, gridHeight - 16, menuRadius, menuRadius)

		love.graphics.setFont(settings.titleFont)
		love.graphics.setColor(theme.titleText)
		love.graphics.printf("LOVE SNAKE", 0, 20, gridWidth, "center")

		love.graphics.setFont(settings.menuFont)
		for index, option in ipairs(state.menuOptions) do
			local y = 78 + (index - 1) * 24
			if index == state.menuIndex then
				love.graphics.setColor(theme.selectedHighlight)
				local optionRadius = 0
				if isCircle then
					optionRadius = 6
				end
				love.graphics.rectangle("fill", 60, y - 2, gridWidth - 120, 20, optionRadius, optionRadius)
				love.graphics.setColor(theme.selectedText)
			else
				love.graphics.setColor(theme.menuText)
			end
			love.graphics.printf(option, 0, y, gridWidth, "center")
		end

		love.graphics.setFont(settings.hintFont)
		love.graphics.setColor(theme.hintText)
		love.graphics.printf("(Up/Down), (w/s), (k/j) to choose", 0, gridHeight - 36, gridWidth, "center")
		love.graphics.printf("Enter/Space to select", 0, gridHeight - 22, gridWidth, "center")

		if state.overlayScreen == "highscore" then
			love.graphics.setColor(theme.overlayDim)
			love.graphics.rectangle("fill", 0, 0, gridWidth, gridHeight)
			love.graphics.setColor(theme.modalPanel)
			love.graphics.rectangle("fill", 30, 60, gridWidth - 60, 90, menuRadius, menuRadius)
			love.graphics.setColor(theme.menuText)
			love.graphics.setFont(settings.menuFont)
			love.graphics.printf("Highscore", 0, 72, gridWidth, "center")
			love.graphics.printf(tostring(state.highScore), 0, 98, gridWidth, "center")
			love.graphics.setFont(settings.hintFont)
			love.graphics.setColor(theme.modalHintText)
			love.graphics.printf("Esc to close", 0, 128, gridWidth, "center")
		elseif state.overlayScreen == "settings" then
			love.graphics.setColor(theme.overlayDim)
			love.graphics.rectangle("fill", 0, 0, gridWidth, gridHeight)
			love.graphics.setColor(theme.modalPanel)
			love.graphics.rectangle("fill", 30, 28, gridWidth - 60, 164, menuRadius, menuRadius)
			love.graphics.setColor(theme.menuText)
			love.graphics.setFont(settings.menuFont)
			love.graphics.printf("Settings", 0, 46, gridWidth, "center")

			local baseY = 74
			local function drawSettingRow(index, label, valueText)
				local y = baseY + (index - 1) * 26
				if index == state.settingsIndex then
					love.graphics.setColor(theme.settingsHighlight)
					local rowRadius = 0
					if isCircle then
						rowRadius = 6
					end
					love.graphics.rectangle("fill", 44, y - 4, gridWidth - 88, 22, rowRadius, rowRadius)
					love.graphics.setColor(theme.settingsHighlightText)
				else
					love.graphics.setColor(theme.settingsText)
				end
				love.graphics.print(label, 54, y)
				love.graphics.print(valueText, gridWidth - 120, y)
			end

			drawSettingRow(1, "Wrapping", settings.wrappingEnabled and "On" or "Off")

			local speedPercent = math.floor(
				((settings.moveInterval - settings.speedMin) / (settings.speedMax - settings.speedMin)) * 100 + 0.5
			)
			if speedPercent < 0 then
				speedPercent = 0
			elseif speedPercent > 100 then
				speedPercent = 100
			end
			drawSettingRow(2, "Speed", tostring(speedPercent) .. "%")

			drawSettingRow(3, "Shape", settings.shapeStyle == "circle" and "Circle" or "Square")
			drawSettingRow(4, "Theme", settings.themeName)

			local sliderX = 64
			local sliderY = baseY + 1 * 26 + 16
			local sliderWidth = gridWidth - 128
			local sliderHeight = 4
			love.graphics.setColor(theme.sliderTrack)
			love.graphics.rectangle("fill", sliderX, sliderY, sliderWidth, sliderHeight)
			local knobX = sliderX + (sliderWidth * (speedPercent / 100))
			love.graphics.setColor(theme.sliderKnob)
			if isCircle then
				love.graphics.circle("fill", knobX, sliderY + 2, 5)
			else
				love.graphics.rectangle("fill", knobX - 3, sliderY - 2, 6, 8)
			end

			-- love.graphics.setFont(settings.hintFont)
			-- love.graphics.setColor(theme.modalHintText)
			-- love.graphics.printf("Left/Right to change", 0, 174, gridWidth, "center")
			-- love.graphics.printf("Esc to close", 0, 188, gridWidth, "center")
		end
		return
	end

	love.graphics.setColor(theme.playfield)
	love.graphics.rectangle("fill", 0, 0, gridWidth, gridHeight)

	for _, segment in ipairs(state.snakeSegments) do
		if state.snakeAlive then
			love.graphics.setColor(theme.snakeAlive)
		else
			love.graphics.setColor(theme.snakeDead)
		end
		drawCell(segment.x, segment.y)
	end

	love.graphics.setColor(theme.food)
	drawCell(state.foodPosition.x, state.foodPosition.y)

	love.graphics.setFont(settings.hintFont)
	love.graphics.setColor(theme.hudText)
	love.graphics.print("Score: " .. tostring(state.score), 6, 4)
	love.graphics.print("High: " .. tostring(state.highScore), 6, 18)
end

return UI
