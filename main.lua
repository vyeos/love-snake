function love.draw()
	local gridXCount = 20 -- cells
	local gridYCount = 15 -- cells
	local cellSize = 15 -- pixels

	love.graphics.setColor(0.28, 0.28, 0.28)
	love.graphics.rectangle("fill", 0, 0, gridXCount * cellSize, gridYCount * cellSize)

	local snakeSegments = {
		{ x = 3, y = 1 },
		{ x = 2, y = 1 },
		{ x = 1, y = 1 },
	}

	for _, segment in ipairs(snakeSegments) do
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
