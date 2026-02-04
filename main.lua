function love.load()
	SnakeSegments = {
		{ x = 3, y = 1 },
		{ x = 2, y = 1 },
		{ x = 1, y = 1 },
	}
	Timer = 0
	Direction = "right"
end

function love.update(dt)
	Timer = Timer + dt
	if Timer >= 0.15 then
		Timer = 0
		local nextXPosition = SnakeSegments[1].x
		local nextYPosition = SnakeSegments[1].y

		if Direction == "right" then
			nextXPosition = nextXPosition + 1
		elseif Direction == "left" then
			nextXPosition = nextXPosition - 1
		elseif Direction == "down" then
			nextYPosition = nextYPosition + 1
		elseif Direction == "up" then
			nextYPosition = nextYPosition - 1
		end

		table.insert(SnakeSegments, 1, {
			x = nextXPosition,
			y = nextYPosition,
		})
		table.remove(SnakeSegments)
	end
end

function love.keypressed(key)
	if key == "right" and Direction ~= "left" then
		Direction = "right"
	elseif key == "left" and Direction ~= "right" then
		Direction = "left"
	elseif key == "up" and Direction ~= "down" then
		Direction = "up"
	elseif key == "down" and Direction ~= "up" then
		Direction = "down"
	end
end

function love.draw()
	local gridXCount = 20 -- cells
	local gridYCount = 15 -- cells
	local cellSize = 15 -- pixels

	love.graphics.setColor(0.28, 0.28, 0.28)
	love.graphics.rectangle("fill", 0, 0, gridXCount * cellSize, gridYCount * cellSize)

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
end
