function love.load()
	SnakeSegments = {
		{ x = 3, y = 1 },
		{ x = 2, y = 1 },
		{ x = 1, y = 1 },
	}
	Timer = 0
	DirectionQueue = { "right" }

	GridXCount = 20 -- cells
	GridYCount = 15 -- cells

	FoodPosition = {
		x = love.math.random(1, GridXCount),
		y = love.math.random(1, GridYCount),
	}

	function MoveFood()
		local possibleFoodPosition = {}

		for foodX = 1, GridXCount do
			for foodY = 1, GridXCount do
				local possible = true
				for _, segment in ipairs(SnakeSegments) do
					if foodX == segment.x and foodY == segment.y then
						possible = false
					end
				end

				if possible then
					table.insert(possibleFoodPosition, { x = foodX, y = foodY })
				end
			end
		end

		FoodPosition = possibleFoodPosition[love.math.random(#possibleFoodPosition)]
	end

	MoveFood()
end

function love.update(dt)
	Timer = Timer + dt
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

		table.insert(SnakeSegments, 1, {
			x = nextXPosition,
			y = nextYPosition,
		})

		if SnakeSegments[1].x == FoodPosition.x and SnakeSegments[1].y == FoodPosition.y then
			MoveFood()
		else
			table.remove(SnakeSegments)
		end
	end
end

function love.keypressed(key)
	if key == "right" and DirectionQueue[#DirectionQueue] ~= "right" and DirectionQueue[#DirectionQueue] ~= "left" then
		table.insert(DirectionQueue, "right")
	elseif
		key == "left"
		and DirectionQueue[#DirectionQueue] ~= "left"
		and DirectionQueue[#DirectionQueue] ~= "right"
	then
		table.insert(DirectionQueue, "left")
	elseif key == "up" and DirectionQueue[#DirectionQueue] ~= "up" and DirectionQueue[#DirectionQueue] ~= "down" then
		table.insert(DirectionQueue, "up")
	elseif key == "down" and DirectionQueue[#DirectionQueue] ~= "down" and DirectionQueue[#DirectionQueue] ~= "up" then
		table.insert(DirectionQueue, "down")
	end
end

function love.draw()
	local cellSize = 15 -- pixels

	local function drawCell(x, y)
		love.graphics.rectangle("fill", (x - 1) * cellSize, (y - 1) * cellSize, cellSize - 1, cellSize - 1)
	end

	love.graphics.setColor(0.28, 0.28, 0.28)
	love.graphics.rectangle("fill", 0, 0, GridXCount * cellSize, GridYCount * cellSize)

	for _, segment in ipairs(SnakeSegments) do
		love.graphics.setColor(0.6, 1, 0.32)
		drawCell(segment.x, segment.y)
	end

	for directionIndex, direction in ipairs(DirectionQueue) do
		love.graphics.setColor(1, 1, 1)
		love.graphics.print("DirectionQueue[" .. directionIndex .. "]: " .. direction, 15 * 15 * directionIndex)
	end

	love.graphics.setColor(1, 0.3, 0.3)
	drawCell(FoodPosition.x, FoodPosition.y)
end
