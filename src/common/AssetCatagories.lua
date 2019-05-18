local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage:WaitForChild("common")
local EquipmentRenderers = require(common:WaitForChild("EquipmentRenderers"))

local by = require(script.Parent.util:WaitForChild("by"))

local catagories = {
    {
        id = "hat",
        image = "rbxassetid://3185662736", -- image used to represent this catagory
        name = "Hat",
        maxEquipped = 3,
        defaultRenderer = EquipmentRenderers.HatRenderer
    },
    {
        id = "face",
        image = "rbxassetid://3185662253",
        name = "Face",
        maxEquipped = 1,
    },
    {
        id = "material",
        image = "rbxassetid://3185662381",
        name = "Material",
        maxEquipped = 1,
    },
    {
        id = "effect",
        image = "rbxassetid://3185662510",
        name = "Effect",
        maxEquipped = 2,
    },
    {
        id = "tool",
        image = "rbxassetid://3185662627",
        name = "Tool",
        maxEquipped = 3,
    },
    {
        id = "ability",
        image = "rbxassetid://3185662029",
        name = "Ability",
        maxEquipped = 99,
    },
}

return {
    all = catagories,
    byId = by("id", catagories),
}