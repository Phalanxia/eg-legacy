local getPlayerState = require(script.Parent.getPlayerState)

return function(state,player)
    local pstate = getPlayerState(state,player)
    if pstate then
        return pstate.portals
    end
end