local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage:WaitForChild("common")

local Actions = require(common:WaitForChild("Actions"))

return {
    id = "coins50000",
    name = "50000 Coins",
    desc = (
        "Gives 50,000 coins."
    ),
    productId = 838301043,
    onSale = true,

    order = 12,

    onProductPurchase = (function(player, server)
        server:getModule("StoreContainer"):getStore():andThen(function(store)
            store:dispatch(Actions.COIN_ADD(player,50000))
        end)
        return true -- Successful
    end)
}