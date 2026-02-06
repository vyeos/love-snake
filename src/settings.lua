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
	Settings.titleFont = love.graphics.newFont(26)
	Settings.menuFont = love.graphics.newFont(14)
	Settings.hintFont = love.graphics.newFont(11)
end

return Settings
