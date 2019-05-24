local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local source = script.Parent.Parent
local lib = ReplicatedStorage:WaitForChild("lib")
local common = ReplicatedStorage:WaitForChild("common")

local Selectors = require(common:WaitForChild("Selectors"))

local Assets = require(common:WaitForChild("Assets"))
local AssetCatagories = require(common:WaitForChild("AssetCatagories"))
local Actions = require(common:WaitForChild("Actions"))
local Thunks = require(common:WaitForChild("Thunks"))

local Signal = require(lib:WaitForChild("Signal"))
 
local PlayerHandler = {}
PlayerHandler.playerLoaded = Signal.new()

local function playerAdded(player,store,api)
    print("Loading data for: ", player)
    store:dispatch(Thunks.PLAYER_JOINED(player,api))
    store:dispatch(Thunks.ASSET_TRYGIVE(player,"baseball2007"))
    store:dispatch(Thunks.ASSET_TRYGIVE(player,"bandit"))
    store:dispatch(Thunks.ASSET_TRYGIVE(player,"baconhair"))
    store:dispatch(Thunks.ASSET_TRYGIVE(player,"arrow"))
    store:dispatch(Thunks.ASSET_TRYGIVE(player,"footballHelmet"))
    store:dispatch(Thunks.ASSET_TRYGIVE(player,"material_pastelred"))
    store:dispatch(Thunks.ASSET_TRYGIVE(player,"material_pasteldeepgreen"))
    store:dispatch(Thunks.ASSET_TRYGIVE(player,"material_pastelcyan"))
    store:dispatch(Thunks.ASSET_TRYGIVE(player,"material_pastelyellow"))
    store:dispatch(Thunks.ASSET_TRYGIVE(player,"sixmil"))
    store:dispatch(Thunks.ASSET_TRYGIVE(player,"pet_rainbowsquid"))
    PlayerHandler.playerLoaded:fire(player)
end

local function playerLeaving(player,store)
	store:dispatch(Thunks.PLAYER_LEAVING(player))
end

function PlayerHandler:start(server)
    local store = server.store
    local api = server.api

    Players.PlayerAdded:Connect(function(player)
        playerAdded(player,store,api)
    end)

    Players.PlayerRemoving:Connect(function(player)
		playerLeaving(player,store)
    end)

	for _,player in pairs(Players:GetPlayers()) do
		playerAdded(player,store,api)
	end
end

function PlayerHandler:getLoadedPlayers(store)
    local loadedPlayers = {}


    for _,player in pairs(Players:GetPlayers()) do
        local playerState = Selectors.getPlayerState(store:getState(), player)
        if playerState then
            table.insert(loadedPlayers,player)
        end
    end

    return loadedPlayers
end

return PlayerHandler