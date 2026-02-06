local Persistence = require("src.persistence")

local Input = {}

function Input.keypressed(key, state, settings, game)
	if state.overlayScreen == "settings" and state.currentScreen == "start" then
		if key == "up" or key == "w" or key == "k" then
			state.settingsIndex = state.settingsIndex - 1
			if state.settingsIndex < 1 then
				state.settingsIndex = #state.settingsOptions
			end
		elseif key == "down" or key == "s" or key == "j" then
			state.settingsIndex = state.settingsIndex + 1
			if state.settingsIndex > #state.settingsOptions then
				state.settingsIndex = 1
			end
		elseif key == "left" or key == "a" or key == "h" then
			if state.settingsOptions[state.settingsIndex] == "Wrapping" then
				settings.wrappingEnabled = not settings.wrappingEnabled
				Persistence.save(state, settings)
			elseif state.settingsOptions[state.settingsIndex] == "Speed" then
				settings.moveInterval = settings.moveInterval - settings.speedStep
				if settings.moveInterval < settings.speedMin then
					settings.moveInterval = settings.speedMin
				end
				Persistence.save(state, settings)
			elseif state.settingsOptions[state.settingsIndex] == "Shape" then
				settings.shapeStyle = "square"
				Persistence.save(state, settings)
			elseif state.settingsOptions[state.settingsIndex] == "Theme" then
				settings.changeTheme(settings, -1)
				Persistence.save(state, settings)
			elseif state.settingsOptions[state.settingsIndex] == "Reset" then
				settings.reset(settings)
				Persistence.save(state, settings)
			end
		elseif key == "right" or key == "d" or key == "l" then
			if state.settingsOptions[state.settingsIndex] == "Wrapping" then
				settings.wrappingEnabled = not settings.wrappingEnabled
				Persistence.save(state, settings)
			elseif state.settingsOptions[state.settingsIndex] == "Speed" then
				settings.moveInterval = settings.moveInterval + settings.speedStep
				if settings.moveInterval > settings.speedMax then
					settings.moveInterval = settings.speedMax
				end
				Persistence.save(state, settings)
			elseif state.settingsOptions[state.settingsIndex] == "Shape" then
				settings.shapeStyle = "circle"
				Persistence.save(state, settings)
			elseif state.settingsOptions[state.settingsIndex] == "Theme" then
				settings.changeTheme(settings, 1)
				Persistence.save(state, settings)
			elseif state.settingsOptions[state.settingsIndex] == "Reset" then
				settings.reset(settings)
				Persistence.save(state, settings)
			end
		elseif key == "return" or key == "space" then
			if state.settingsOptions[state.settingsIndex] == "Wrapping" then
				settings.wrappingEnabled = not settings.wrappingEnabled
				Persistence.save(state, settings)
			elseif state.settingsOptions[state.settingsIndex] == "Shape" then
				if settings.shapeStyle == "square" then
					settings.shapeStyle = "circle"
				else
					settings.shapeStyle = "square"
				end
				Persistence.save(state, settings)
			elseif state.settingsOptions[state.settingsIndex] == "Theme" then
				settings.changeTheme(settings, 1)
				Persistence.save(state, settings)
			elseif state.settingsOptions[state.settingsIndex] == "Reset" then
				settings.reset(settings)
				Persistence.save(state, settings)
			end
		elseif key == "escape" then
			state.overlayScreen = nil
		end
		return
	end

	if state.currentScreen == "start" then
		if key == "up" or key == "w" or key == "k" then
			state.menuIndex = state.menuIndex - 1
			if state.menuIndex < 1 then
				state.menuIndex = #state.menuOptions
			end
		elseif key == "down" or key == "s" or key == "j" then
			state.menuIndex = state.menuIndex + 1
			if state.menuIndex > #state.menuOptions then
				state.menuIndex = 1
			end
		elseif key == "return" or key == "space" then
			if state.menuOptions[state.menuIndex] == "Play" then
				state.score = 0
				game.reset(state, settings)
				state.setScreen("play")
			elseif state.menuOptions[state.menuIndex] == "Highscore" then
				state.overlayScreen = "highscore"
			elseif state.menuOptions[state.menuIndex] == "Settings" then
				state.overlayScreen = "settings"
			end
		elseif key == "escape" then
			state.overlayScreen = nil
		end
		return
	end

	if key == "escape" then
		if state.currentScreen == "play" then
			state.setScreen("start")
		else
			state.overlayScreen = nil
		end
		return
	end

	if state.currentScreen ~= "play" then
		return
	end

	if key == "right" or key == "l" or key == "d" then
		game.queueDirection("right", state)
	elseif key == "left" or key == "h" or key == "a" then
		game.queueDirection("left", state)
	elseif key == "up" or key == "k" or key == "w" then
		game.queueDirection("up", state)
	elseif key == "down" or key == "j" or key == "s" then
		game.queueDirection("down", state)
	end
end

return Input
