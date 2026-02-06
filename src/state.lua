local State = {}

function State.load()
	State.score = 0
	State.highScore = 0
	State.currentScreen = "start"
	State.menuOptions = { "Play", "Highscore", "Settings" }
	State.menuIndex = 1
	State.overlayScreen = nil
	State.settingsOptions = { "Wrapping", "Speed", "Shape", "Theme", "Sound", "Reset" }
	State.settingsIndex = 1
	State.timer = 0
	State.snakeSegments = {}
	State.directionQueue = { "right" }
	State.snakeAlive = true
	State.foodPosition = { x = 1, y = 1 }
end

function State.setScreen(screen)
	State.currentScreen = screen
	State.overlayScreen = nil
end

return State
