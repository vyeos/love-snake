local State = require("src.state")
local Settings = require("src.settings")
local Game = require("src.game")
local UI = require("src.ui")
local Input = require("src.input")
local Persistence = require("src.persistence")

function love.load()
	Settings.load()
	State.load()
	Persistence.load(State, Settings)
	Game.load(State, Settings)
	UI.load(State, Settings)
end

function love.update(dt)
	Game.update(dt, State, Settings)
end

function love.keypressed(key)
	Input.keypressed(key, State, Settings, Game)
end

function love.quit()
	Persistence.save(State, Settings)
end

function love.draw()
	UI.draw(State, Settings, Game)
end
