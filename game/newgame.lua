local Class = require("libs/basics/middleclass")
local Button = require("libs/basics/Button")
local Scene = require("libs/basics/Scene")
local Scenes = require("libs/basics/Scenes")
local globals = require("globals")
local gamemode = require("gamemode")
local hSieska = require("libs/heros/sieska")

NewGameScene = Scene:new("newgame")

local wSieska = hSieska:new()
wSieska.canmove = false

