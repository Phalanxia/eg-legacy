local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local joinTimes = {}

Players.PlayerAdded:Connect(function(player)
    joinTimes[player] = tick()
end)

Players.PlayerRemoving:Connect(function(player)
    joinTimes[player] = nil
end)

for _,player in pairs(Players:GetPlayers()) do
    joinTimes[player] = tick()
end

return function(timeRequirement,name,desc,badgeId)

    local joinTimes = {}
    -- function that returns true if a player has completed this objective
    local function queryComplete(server,player)
        return (joinTimes[player] ~= nil) and ((tick() - joinTimes[player]) > timeRequirement)
    end

    return {
        id = "SessionLength_"..timeRequirement,
        name = name,
        desc = desc,
        badgeId = badgeId,
        startListening = (function(server, awardBadge)
            print("Listening for",name)
            spawn(function()
                while true do
                    for _,player in pairs(Players:GetPlayers()) do
                        if not joinTimes[player] then
                            joinTimes[player] = tick()
                        end
                        if queryComplete(server,player) then
                            awardBadge(player)
                        end
                    end
                    wait(0.3)
                end
            end)
        end),
        queryComplete = queryComplete,
    }
end