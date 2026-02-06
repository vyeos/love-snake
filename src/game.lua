local Game = {}

local function moveFood(state, settings)
	local possibleFoodPositions = {}

	for foodX = 1, settings.gridXCount do
		for foodY = 1, settings.gridYCount do
			local possible = true

			for _, segment in ipairs(state.snakeSegments) do
				if foodX == segment.x and foodY == segment.y then
					possible = false
					break
				end
			end

			if possible then
				table.insert(possibleFoodPositions, { x = foodX, y = foodY })
			end
		end
	end

	state.foodPosition = possibleFoodPositions[love.math.random(#possibleFoodPositions)]
end

function Game.reset(state, settings)
	-- love.window.setMode(320, 180) Pixel Art
	-- love.window.setMode(480, 270) Retro 2D
	love.window.setMode(settings.gridXCount * settings.cellSize, settings.gridYCount * settings.cellSize)
	state.snakeSegments = {
		{ x = 3, y = 1 },
		{ x = 2, y = 1 },
		{ x = 1, y = 1 },
	}
	state.timer = 0
	state.directionQueue = { "right" }
	state.snakeAlive = true
	moveFood(state, settings)
end

function Game.load(state, settings)
	Game.reset(state, settings)
end

function Game.update(dt, state, settings)
	if state.currentScreen ~= "play" then
		return
	end

	state.timer = state.timer + dt

	if state.snakeAlive then
		if state.timer >= settings.moveInterval then
			state.timer = 0

			if #state.directionQueue > 1 then
				table.remove(state.directionQueue, 1)
			end

			local nextXPosition = state.snakeSegments[1].x
			local nextYPosition = state.snakeSegments[1].y

			if state.directionQueue[1] == "right" then
				nextXPosition = nextXPosition + 1
			elseif state.directionQueue[1] == "left" then
				nextXPosition = nextXPosition - 1
			elseif state.directionQueue[1] == "down" then
				nextYPosition = nextYPosition + 1
			elseif state.directionQueue[1] == "up" then
				nextYPosition = nextYPosition - 1
			end

			if settings.wrappingEnabled then
				if nextXPosition > settings.gridXCount then
					nextXPosition = 1
				elseif nextXPosition < 1 then
					nextXPosition = settings.gridXCount
				end
				if nextYPosition > settings.gridYCount then
					nextYPosition = 1
				elseif nextYPosition < 1 then
					nextYPosition = settings.gridYCount
				end
			else
				if
					nextXPosition > settings.gridXCount
					or nextXPosition < 1
					or nextYPosition > settings.gridYCount
					or nextYPosition < 1
				then
					state.snakeAlive = false
					return
				end
			end

			local canMove = true

			for segmentIndex, segment in ipairs(state.snakeSegments) do
				if segmentIndex ~= #state.snakeSegments and nextXPosition == segment.x and nextYPosition == segment.y then
					canMove = false
					break
				end
			end

			if canMove then
				table.insert(state.snakeSegments, 1, {
					x = nextXPosition,
					y = nextYPosition,
				})

				if state.snakeSegments[1].x == state.foodPosition.x and state.snakeSegments[1].y == state.foodPosition.y then
					state.score = state.score + 1
				if state.score > state.highScore then
					state.highScore = state.score
				end
					moveFood(state, settings)
				else
					table.remove(state.snakeSegments)
				end
			else
				state.snakeAlive = false
			end
		end
	elseif state.timer >= 2 then
		Game.reset(state, settings)
		state.score = 0
	end
end

function Game.queueDirection(direction, state)
	local last = state.directionQueue[#state.directionQueue]
	if (direction == "right" and last == "left")
		or (direction == "left" and last == "right")
		or (direction == "up" and last == "down")
		or (direction == "down" and last == "up")
	then
		return
	end
	if last == direction then
		return
	end
	table.insert(state.directionQueue, direction)
end

return Game
