local Persistence = {}

local savePath = "save.lua"

function Persistence.load(state, settings)
	if not love.filesystem.getInfo(savePath) then
		return
	end

	local chunk = love.filesystem.load(savePath)
	if not chunk then
		return
	end

	local ok, data = pcall(chunk)
	if not ok or type(data) ~= "table" then
		return
	end

	if type(data.highScore) == "number" then
		state.highScore = data.highScore
	end
	if type(data.wrappingEnabled) == "boolean" then
		settings.wrappingEnabled = data.wrappingEnabled
	end
	if type(data.moveInterval) == "number" then
		settings.moveInterval = data.moveInterval
	end
	if type(data.shapeStyle) == "string" then
		settings.shapeStyle = data.shapeStyle
	end
	if type(data.themeName) == "string" then
		settings.themeName = data.themeName
	end
end

function Persistence.save(state, settings)
	local data = {
		version = 1,
		highScore = state.highScore or 0,
		wrappingEnabled = settings.wrappingEnabled,
		moveInterval = settings.moveInterval,
		shapeStyle = settings.shapeStyle,
		themeName = settings.themeName,
	}

	local lines = {
		"return {",
		string.format("\tversion = %d,", data.version),
		string.format("\thighScore = %d,", data.highScore),
		string.format("\twrappingEnabled = %s,", tostring(data.wrappingEnabled)),
		string.format("\tmoveInterval = %.3f,", data.moveInterval),
		string.format("\tshapeStyle = %q,", data.shapeStyle),
		string.format("\tthemeName = %q,", data.themeName),
		"}",
	}

	love.filesystem.write(savePath, table.concat(lines, "\n"))
end

return Persistence
