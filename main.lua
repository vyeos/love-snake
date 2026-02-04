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
		table.remove(SnakeSegments)
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

	love.graphics.setColor(0.28, 0.28, 0.28)
	love.graphics.rectangle("fill", 0, 0, GridXCount * cellSize, GridYCount * cellSize)

	for _, segment in ipairs(SnakeSegments) do
		love.graphics.setColor(0.6, 1, 0.32)
		love.graphics.rectangle(
			"fill",
			(segment.x - 1) * cellSize,
			(segment.y - 1) * cellSize,
			cellSize - 1,
			cellSize - 1
		)
	end

	for directionIndex, direction in ipairs(DirectionQueue) do
		love.graphics.setColor(1, 1, 1)
		love.graphics.print("DirectionQueue[" .. directionIndex .. "]: " .. direction, 15 * 15 * directionIndex)
	end
end
