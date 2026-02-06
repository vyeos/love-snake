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

	local function drawCell(x, y)
		local cellX = (x - 1) * settings.cellSize
		local cellY = (y - 1) * settings.cellSize
		if isCircle then
			love.graphics.circle("fill", cellX + settings.cellSize / 2, cellY + settings.cellSize / 2, (settings.cellSize - 1) / 2)
		else
			love.graphics.rectangle("fill", cellX, cellY, settings.cellSize - 1, settings.cellSize - 1)
		end
	end

	if state.currentScreen == "start" then
		love.graphics.setColor(0.12, 0.12, 0.12)
		love.graphics.rectangle("fill", 0, 0, gridWidth, gridHeight)
		love.graphics.setColor(0.28, 0.28, 0.28)
		love.graphics.rectangle("fill", 8, 8, gridWidth - 16, gridHeight - 16, menuRadius, menuRadius)

		love.graphics.setFont(settings.titleFont)
		love.graphics.setColor(0.85, 0.95, 0.8)
		love.graphics.printf("LOVE SNAKE", 0, 20, gridWidth, "center")

		love.graphics.setFont(settings.menuFont)
		for index, option in ipairs(state.menuOptions) do
			local y = 78 + (index - 1) * 24
			if index == state.menuIndex then
				love.graphics.setColor(0.6, 1, 0.32)
				local optionRadius = 0
				if isCircle then
					optionRadius = 6
				end
				love.graphics.rectangle("fill", 60, y - 2, gridWidth - 120, 20, optionRadius, optionRadius)
				love.graphics.setColor(0.1, 0.2, 0.1)
			else
				love.graphics.setColor(0.9, 0.9, 0.9)
			end
			love.graphics.printf(option, 0, y, gridWidth, "center")
		end

		love.graphics.setFont(settings.hintFont)
		love.graphics.setColor(0.75, 0.75, 0.75)
		love.graphics.printf("(Up/Down), (w/s), (k/j) to choose", 0, gridHeight - 36, gridWidth, "center")
		love.graphics.printf("Enter/Space to select", 0, gridHeight - 22, gridWidth, "center")

		if state.overlayScreen == "highscore" then
			love.graphics.setColor(0, 0, 0, 0.75)
			love.graphics.rectangle("fill", 0, 0, gridWidth, gridHeight)
			love.graphics.setColor(0.2, 0.2, 0.2)
			love.graphics.rectangle("fill", 30, 60, gridWidth - 60, 90, menuRadius, menuRadius)
			love.graphics.setColor(0.9, 0.9, 0.9)
			love.graphics.setFont(settings.menuFont)
			love.graphics.printf("Highscore", 0, 72, gridWidth, "center")
			love.graphics.printf(tostring(state.highScore), 0, 98, gridWidth, "center")
			love.graphics.setFont(settings.hintFont)
			love.graphics.setColor(0.7, 0.7, 0.7)
			love.graphics.printf("Esc to close", 0, 128, gridWidth, "center")
		elseif state.overlayScreen == "settings" then
			love.graphics.setColor(0, 0, 0, 0.75)
			love.graphics.rectangle("fill", 0, 0, gridWidth, gridHeight)
			love.graphics.setColor(0.2, 0.2, 0.2)
			love.graphics.rectangle("fill", 30, 50, gridWidth - 60, 120, menuRadius, menuRadius)
			love.graphics.setColor(0.9, 0.9, 0.9)
			love.graphics.setFont(settings.menuFont)
			love.graphics.printf("Settings", 0, 58, gridWidth, "center")

			local baseY = 78
			local function drawSettingRow(index, label, valueText)
				local y = baseY + (index - 1) * 26
				if index == state.settingsIndex then
					love.graphics.setColor(0.6, 1, 0.32)
					local rowRadius = 0
					if isCircle then
						rowRadius = 6
					end
					love.graphics.rectangle("fill", 44, y - 4, gridWidth - 88, 22, rowRadius, rowRadius)
					love.graphics.setColor(0.1, 0.2, 0.1)
				else
					love.graphics.setColor(0.9, 0.9, 0.9)
				end
				love.graphics.print(label, 54, y)
				love.graphics.print(valueText, gridWidth - 120, y)
			end

			drawSettingRow(1, "Wrapping", settings.wrappingEnabled and "On" or "Off")

			local speedPercent = math.floor(((settings.moveInterval - settings.speedMin) / (settings.speedMax - settings.speedMin)) * 100 + 0.5)
			if speedPercent < 0 then
				speedPercent = 0
			elseif speedPercent > 100 then
				speedPercent = 100
			end
			drawSettingRow(2, "Speed", tostring(speedPercent) .. "%")

			drawSettingRow(3, "Shape", settings.shapeStyle == "circle" and "Circle" or "Square")

			local sliderX = 64
			local sliderY = baseY + 1 * 26 + 16
			local sliderWidth = gridWidth - 128
			local sliderHeight = 4
			love.graphics.setColor(0.35, 0.35, 0.35)
			love.graphics.rectangle("fill", sliderX, sliderY, sliderWidth, sliderHeight)
			local knobX = sliderX + (sliderWidth * (speedPercent / 100))
			love.graphics.setColor(0.8, 0.8, 0.8)
			if isCircle then
				love.graphics.circle("fill", knobX, sliderY + 2, 5)
			else
				love.graphics.rectangle("fill", knobX - 3, sliderY - 2, 6, 8)
			end

			love.graphics.setFont(settings.hintFont)
			love.graphics.setColor(0.7, 0.7, 0.7)
			love.graphics.printf("Left/Right to change", 0, 146, gridWidth, "center")
			love.graphics.printf("Esc to close", 0, 160, gridWidth, "center")
		end
		return
	end

	love.graphics.setColor(0.28, 0.28, 0.28)
	love.graphics.rectangle("fill", 0, 0, gridWidth, gridHeight)

	for _, segment in ipairs(state.snakeSegments) do
		if state.snakeAlive then
			love.graphics.setColor(0.6, 1, 0.32)
		else
			love.graphics.setColor(0.5, 0.5, 0.5)
		end
		drawCell(segment.x, segment.y)
	end

	love.graphics.setColor(1, 0.3, 0.3)
	drawCell(state.foodPosition.x, state.foodPosition.y)

	love.graphics.setFont(settings.hintFont)
	love.graphics.setColor(0.85, 0.85, 0.85)
	love.graphics.print("Score: " .. tostring(state.score), 6, 4)
	love.graphics.print("High: " .. tostring(state.highScore), 6, 18)
end

return UI
