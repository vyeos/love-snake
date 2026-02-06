function love.load()
	Score = 0
	HighScore = 0
	CurrentScreen = "start"
	MenuOptions = { "Play", "Highscore", "Settings" }
	MenuIndex = 1
	OverlayScreen = nil
	WrappingEnabled = true
	MoveInterval = 0.15
	SpeedMin = 0.05
	SpeedMax = 0.3
	SpeedStep = 0.01
	ShapeStyle = "square"
	SettingsOptions = { "Wrapping", "Speed", "Shape" }
	SettingsIndex = 1

	TitleFont = love.graphics.newFont(26)
	MenuFont = love.graphics.newFont(14)
	HintFont = love.graphics.newFont(11)

	GridXCount = 20
	GridYCount = 15
	CellSize = 15

	function Reset()
		-- love.window.setMode(320, 180) Pixel Art
		-- love.window.setMode(480, 270) Retro 2D
		love.window.setMode(300, 225)
		SnakeSegments = {
			{ x = 3, y = 1 },
			{ x = 2, y = 1 },
			{ x = 1, y = 1 },
		}

		Timer = 0
		DirectionQueue = { "right" }
		SnakeAlive = true
		MoveFood()
	end

	function MoveFood()
		local possibleFoodPositions = {}

		for foodX = 1, GridXCount do
			for foodY = 1, GridYCount do
				local possible = true

				for _, segment in ipairs(SnakeSegments) do
					if foodX == segment.x and foodY == segment.y then
						possible = false
					end
				end

				if possible then
					table.insert(possibleFoodPositions, { x = foodX, y = foodY })
				end
			end
		end

		FoodPosition = possibleFoodPositions[love.math.random(#possibleFoodPositions)]
	end

	Reset()
end

function love.update(dt)
	if CurrentScreen ~= "play" then
		return
	end

	Timer = Timer + dt

	if SnakeAlive then
		if Timer >= MoveInterval then
			Timer = 0

			if #DirectionQueue > 1 then
				table.remove(DirectionQueue, 1)
			end

			local nextXPosition = SnakeSegments[1].x
			local nextYPosition = SnakeSegments[1].y

			if DirectionQueue[1] == "right" then
				nextXPosition = nextXPosition + 1
			elseif DirectionQueue[1] == "left" then
				nextXPosition = nextXPosition - 1
			elseif DirectionQueue[1] == "down" then
				nextYPosition = nextYPosition + 1
			elseif DirectionQueue[1] == "up" then
				nextYPosition = nextYPosition - 1
			end

			if WrappingEnabled then
				if nextXPosition > GridXCount then
					nextXPosition = 1
				elseif nextXPosition < 1 then
					nextXPosition = GridXCount
				end
				if nextYPosition > GridYCount then
					nextYPosition = 1
				elseif nextYPosition < 1 then
					nextYPosition = GridYCount
				end
			else
				if
					nextXPosition > GridXCount
					or nextXPosition < 1
					or nextYPosition > GridYCount
					or nextYPosition < 1
				then
					SnakeAlive = false
					return
				end
			end

			local canMove = true

			for segmentIndex, segment in ipairs(SnakeSegments) do
				if segmentIndex ~= #SnakeSegments and nextXPosition == segment.x and nextYPosition == segment.y then
					canMove = false
				end
			end

			if canMove then
				table.insert(SnakeSegments, 1, {
					x = nextXPosition,
					y = nextYPosition,
				})

				if SnakeSegments[1].x == FoodPosition.x and SnakeSegments[1].y == FoodPosition.y then
					Score = Score + 1
					if Score > HighScore then
						HighScore = Score
					end
					MoveFood()
				else
					table.remove(SnakeSegments)
				end
			else
				SnakeAlive = false
			end
		end
	elseif Timer >= 2 then
		Reset()
		Score = 0
	end
end

local function setScreen(screen)
	CurrentScreen = screen
	OverlayScreen = nil
end

function love.keypressed(key)
	if OverlayScreen == "settings" and CurrentScreen == "start" then
		if key == "up" or key == "w" or key == "k" then
			SettingsIndex = SettingsIndex - 1
			if SettingsIndex < 1 then
				SettingsIndex = #SettingsOptions
			end
		elseif key == "down" or key == "s" or key == "j" then
			SettingsIndex = SettingsIndex + 1
			if SettingsIndex > #SettingsOptions then
				SettingsIndex = 1
			end
		elseif key == "left" or key == "a" or key == "h" then
			if SettingsOptions[SettingsIndex] == "Wrapping" then
				WrappingEnabled = not WrappingEnabled
			elseif SettingsOptions[SettingsIndex] == "Speed" then
				MoveInterval = MoveInterval - SpeedStep
				if MoveInterval < SpeedMin then
					MoveInterval = SpeedMin
				end
			elseif SettingsOptions[SettingsIndex] == "Shape" then
				ShapeStyle = "square"
			end
		elseif key == "right" or key == "d" or key == "l" then
			if SettingsOptions[SettingsIndex] == "Wrapping" then
				WrappingEnabled = not WrappingEnabled
			elseif SettingsOptions[SettingsIndex] == "Speed" then
				MoveInterval = MoveInterval + SpeedStep
				if MoveInterval > SpeedMax then
					MoveInterval = SpeedMax
				end
			elseif SettingsOptions[SettingsIndex] == "Shape" then
				ShapeStyle = "circle"
			end
		elseif key == "return" or key == "space" then
			if SettingsOptions[SettingsIndex] == "Wrapping" then
				WrappingEnabled = not WrappingEnabled
			elseif SettingsOptions[SettingsIndex] == "Shape" then
				if ShapeStyle == "square" then
					ShapeStyle = "circle"
				else
					ShapeStyle = "square"
				end
			end
		elseif key == "escape" then
			OverlayScreen = nil
		end
		return
	end

	if CurrentScreen == "start" then
		if key == "up" or key == "w" or key == "k" then
			MenuIndex = MenuIndex - 1
			if MenuIndex < 1 then
				MenuIndex = #MenuOptions
			end
		elseif key == "down" or key == "s" or key == "j" then
			MenuIndex = MenuIndex + 1
			if MenuIndex > #MenuOptions then
				MenuIndex = 1
			end
		elseif key == "return" or key == "space" then
			if MenuOptions[MenuIndex] == "Play" then
				Score = 0
				Reset()
				setScreen("play")
			elseif MenuOptions[MenuIndex] == "Highscore" then
				OverlayScreen = "highscore"
			elseif MenuOptions[MenuIndex] == "Settings" then
				OverlayScreen = "settings"
			end
		elseif key == "escape" then
			OverlayScreen = nil
		end
		return
	end

	if key == "escape" then
		if CurrentScreen == "play" then
			setScreen("start")
		else
			OverlayScreen = nil
		end
		return
	end

	if CurrentScreen ~= "play" then
		return
	end

	local function queueDirection(direction)
		local last = DirectionQueue[#DirectionQueue]
		if
			(direction == "right" and last == "left")
			or (direction == "left" and last == "right")
			or (direction == "up" and last == "down")
			or (direction == "down" and last == "up")
		then
			return
		end
		table.insert(DirectionQueue, direction)
	end

	if key == "right" or key == "l" or key == "d" then
		queueDirection("right")
	elseif key == "left" or key == "h" or key == "a" then
		queueDirection("left")
	elseif key == "up" or key == "k" or key == "w" then
		queueDirection("up")
	elseif key == "down" or key == "j" or key == "s" then
		queueDirection("down")
	end
end

function love.draw()
	local gridWidth = GridXCount * CellSize
	local gridHeight = GridYCount * CellSize
	local isCircle = ShapeStyle == "circle"
	local menuRadius = 0
	if isCircle then
		menuRadius = 10
	end

	local function drawCell(x, y)
		local cellX = (x - 1) * CellSize
		local cellY = (y - 1) * CellSize
		if isCircle then
			love.graphics.circle("fill", cellX + CellSize / 2, cellY + CellSize / 2, (CellSize - 1) / 2)
		else
			love.graphics.rectangle("fill", cellX, cellY, CellSize - 1, CellSize - 1)
		end
	end

	if CurrentScreen == "start" then
		love.graphics.setColor(0.12, 0.12, 0.12)
		love.graphics.rectangle("fill", 0, 0, gridWidth, gridHeight)
		love.graphics.setColor(0.28, 0.28, 0.28)
		love.graphics.rectangle("fill", 8, 8, gridWidth - 16, gridHeight - 16, menuRadius, menuRadius)

		love.graphics.setFont(TitleFont)
		love.graphics.setColor(0.85, 0.95, 0.8)
		love.graphics.printf("LOVE SNAKE", 0, 20, gridWidth, "center")

		love.graphics.setFont(MenuFont)
		for index, option in ipairs(MenuOptions) do
			local y = 78 + (index - 1) * 24
			if index == MenuIndex then
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

		love.graphics.setFont(HintFont)
		love.graphics.setColor(0.75, 0.75, 0.75)
		love.graphics.printf("(Up/Down), (w/s), (k/j) to choose", 0, gridHeight - 36, gridWidth, "center")
		love.graphics.printf("Enter/Space to select", 0, gridHeight - 22, gridWidth, "center")

		if OverlayScreen == "highscore" then
			love.graphics.setColor(0, 0, 0, 0.75)
			love.graphics.rectangle("fill", 0, 0, gridWidth, gridHeight)
			love.graphics.setColor(0.2, 0.2, 0.2)
			love.graphics.rectangle("fill", 30, 60, gridWidth - 60, 90, menuRadius, menuRadius)
			love.graphics.setColor(0.9, 0.9, 0.9)
			love.graphics.setFont(MenuFont)
			love.graphics.printf("Highscore", 0, 72, gridWidth, "center")
			love.graphics.printf(tostring(HighScore), 0, 98, gridWidth, "center")
			love.graphics.setFont(HintFont)
			love.graphics.setColor(0.7, 0.7, 0.7)
			love.graphics.printf("Esc to close", 0, 128, gridWidth, "center")
		elseif OverlayScreen == "settings" then
			love.graphics.setColor(0, 0, 0, 0.75)
			love.graphics.rectangle("fill", 0, 0, gridWidth, gridHeight)
			love.graphics.setColor(0.2, 0.2, 0.2)
			love.graphics.rectangle("fill", 30, 50, gridWidth - 60, 120, menuRadius, menuRadius)
			love.graphics.setColor(0.9, 0.9, 0.9)
			love.graphics.setFont(MenuFont)
			love.graphics.printf("Settings", 0, 58, gridWidth, "center")

			local baseY = 78
			local function drawSettingRow(index, label, valueText)
				local y = baseY + (index - 1) * 26
				if index == SettingsIndex then
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

			drawSettingRow(1, "Wrapping", WrappingEnabled and "On" or "Off")

			local speedPercent = math.floor(((MoveInterval - SpeedMin) / (SpeedMax - SpeedMin)) * 100 + 0.5)
			if speedPercent < 0 then
				speedPercent = 0
			elseif speedPercent > 100 then
				speedPercent = 100
			end
			drawSettingRow(2, "Speed", tostring(speedPercent) .. "%")

			drawSettingRow(3, "Shape", ShapeStyle == "circle" and "Circle" or "Square")

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

			love.graphics.setFont(HintFont)
			love.graphics.setColor(0.7, 0.7, 0.7)
			love.graphics.printf("Left/Right to change", 0, 146, gridWidth, "center")
			love.graphics.printf("Esc to close", 0, 160, gridWidth, "center")
		end
		return
	end

	love.graphics.setColor(0.28, 0.28, 0.28)
	love.graphics.rectangle("fill", 0, 0, gridWidth, gridHeight)

	for _, segment in ipairs(SnakeSegments) do
		if SnakeAlive then
			love.graphics.setColor(0.6, 1, 0.32)
		else
			love.graphics.setColor(0.5, 0.5, 0.5)
		end
		drawCell(segment.x, segment.y)
	end

	love.graphics.setColor(1, 0.3, 0.3)
	drawCell(FoodPosition.x, FoodPosition.y)

	love.graphics.setFont(HintFont)
	love.graphics.setColor(0.85, 0.85, 0.85)
	love.graphics.print("Score: " .. tostring(Score), 6, 4)
	love.graphics.print("High: " .. tostring(HighScore), 6, 18)
end
