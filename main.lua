function love.load()
	Score = 0
	HighScore = 0
	CurrentScreen = "start"
	MenuOptions = { "Play", "Highscore", "Settings" }
	MenuIndex = 1
	OverlayScreen = nil

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
		if Timer >= 0.15 then
			Timer = 0

			if #DirectionQueue > 1 then
				table.remove(DirectionQueue, 1)
			end

			local nextXPosition = SnakeSegments[1].x
			local nextYPosition = SnakeSegments[1].y

			if DirectionQueue[1] == "right" then
				nextXPosition = nextXPosition + 1
				if nextXPosition > GridXCount then
					nextXPosition = 1
				end
			elseif DirectionQueue[1] == "left" then
				nextXPosition = nextXPosition - 1
				if nextXPosition < 1 then
					nextXPosition = GridXCount
				end
			elseif DirectionQueue[1] == "down" then
				nextYPosition = nextYPosition + 1
				if nextYPosition > GridYCount then
					nextYPosition = 1
				end
			elseif DirectionQueue[1] == "up" then
				nextYPosition = nextYPosition - 1
				if nextYPosition < 1 then
					nextYPosition = GridYCount
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

	if
		key == "right"
		or key == "l"
		or key == "d" and DirectionQueue[#DirectionQueue] ~= "right" and DirectionQueue[#DirectionQueue] ~= "left"
	then
		table.insert(DirectionQueue, "right")
	elseif
		key == "left"
		or key == "h"
		or key == "a" and DirectionQueue[#DirectionQueue] ~= "left" and DirectionQueue[#DirectionQueue] ~= "right"
	then
		table.insert(DirectionQueue, "left")
	elseif
		key == "up"
		or key == "k"
		or key == "w" and DirectionQueue[#DirectionQueue] ~= "up" and DirectionQueue[#DirectionQueue] ~= "down"
	then
		table.insert(DirectionQueue, "up")
	elseif
		key == "down"
		or key == "j"
		or key == "s" and DirectionQueue[#DirectionQueue] ~= "down" and DirectionQueue[#DirectionQueue] ~= "up"
	then
		table.insert(DirectionQueue, "down")
	end
end

function love.draw()
	local gridWidth = GridXCount * CellSize
	local gridHeight = GridYCount * CellSize

	local function drawCell(x, y)
		love.graphics.rectangle("fill", (x - 1) * CellSize, (y - 1) * CellSize, CellSize - 1, CellSize - 1)
	end

	if CurrentScreen == "start" then
		love.graphics.setColor(0.12, 0.12, 0.12)
		love.graphics.rectangle("fill", 0, 0, gridWidth, gridHeight)
		love.graphics.setColor(0.28, 0.28, 0.28)
		love.graphics.rectangle("fill", 8, 8, gridWidth - 16, gridHeight - 16, 6, 6)

		love.graphics.setFont(TitleFont)
		love.graphics.setColor(0.85, 0.95, 0.8)
		love.graphics.printf("LOVE SNAKE", 0, 20, gridWidth, "center")

		love.graphics.setFont(MenuFont)
		for index, option in ipairs(MenuOptions) do
			local y = 78 + (index - 1) * 24
			if index == MenuIndex then
				love.graphics.setColor(0.6, 1, 0.32)
				love.graphics.rectangle("fill", 60, y - 2, gridWidth - 120, 20, 6, 6)
				love.graphics.setColor(0.1, 0.2, 0.1)
			else
				love.graphics.setColor(0.9, 0.9, 0.9)
			end
			love.graphics.printf(option, 0, y, gridWidth, "center")
		end

		love.graphics.setFont(HintFont)
		love.graphics.setColor(0.75, 0.75, 0.75)
		love.graphics.printf("Up/Down to choose", 0, gridHeight - 36, gridWidth, "center")
		love.graphics.printf("Enter to select", 0, gridHeight - 22, gridWidth, "center")

		if OverlayScreen == "highscore" then
			love.graphics.setColor(0, 0, 0, 0.75)
			love.graphics.rectangle("fill", 0, 0, gridWidth, gridHeight)
			love.graphics.setColor(0.2, 0.2, 0.2)
			love.graphics.rectangle("fill", 30, 60, gridWidth - 60, 90, 6, 6)
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
			love.graphics.rectangle("fill", 30, 60, gridWidth - 60, 90, 6, 6)
			love.graphics.setColor(0.9, 0.9, 0.9)
			love.graphics.setFont(MenuFont)
			love.graphics.printf("Settings", 0, 72, gridWidth, "center")
			love.graphics.printf("(Coming soon)", 0, 98, gridWidth, "center")
			love.graphics.setFont(HintFont)
			love.graphics.setColor(0.7, 0.7, 0.7)
			love.graphics.printf("Esc to close", 0, 128, gridWidth, "center")
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
