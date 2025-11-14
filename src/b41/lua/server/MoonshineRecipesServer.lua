--
-- Copyright (c) 2025 outdead.
-- Use of this source code is governed by the Apache 2.0 license
-- that can be found in the LICENSE file.
--

local json = require "vendor/json/json"
local json_pretty_options = {pretty = true, indent = "  ", align_keys = false, array_newline = true}

-- MoonshineRecipesServer contains recipes for moonshine still.
MoonshineRecipesServer = {}

-- GetDefaultRecipes returns default recipes.
function MoonshineRecipesServer.GetDefaultRecipes()
    local recipes = {
        Vanilla = {
            {
                name = "MakeWhiskey",
                type = "Vanilla",
                disabled = false,
                sound = "PourWaterIntoObject",
                texture = "Item_WhiskeyFull",
                time = 300,
                cookingSkill = 3,
                usedItems = {
                    ["Base.WhiskeyWaterFull"] = 1,
                    ["Base.Yeast"] = 1,
                    ["Base.Corn"] = 1,
                    ["Base.UnusableWood"] = 1,
                },
                result = "Base.WhiskeyFull",
                additionalResults = {},
            },
            {
                name = "MakeWine",
                type = "Vanilla",
                disabled = false,
                sound = "PourWaterIntoObject",
                texture = "Item_Wine2Full",
                time = 300,
                cookingSkill = 3,
                usedItems = {
                    ["Base.WineWaterFull"] = 1,
                    ["Base.Sugar"] = 1,
                    ["Base.Grapes"] = 1,
                },
                result = "Base.Wine2",
                additionalResults = {},
            },
            {
                name = "MakeBeer",
                type = "Vanilla",
                disabled = false,
                sound = "PourWaterIntoObject",
                texture = "Item_BeerBottle",
                time = 300,
                cookingSkill = 3,
                usedItems = {
                    ["Base.BeerWaterFull"] = 1,
                    ["Base.Sugar"] = 1,
                    ["Base.Corn"] = 1,
                },
                result = "Base.BeerBottle",
                additionalResults = {},
            },
        },
        Exclusive = {
            {
                name = "MakeHastyHerring",
                type = "Exclusive",
                disabled = false,
                sound = "PourWaterIntoObject",
                texture = "media/textures/Item_HastyHerring.png",
                time = 300,
                cookingSkill = 10,
                usedItems = {
                    ["Permanent.ExclusiveRecipe"] = 1,
                    ["Base.WhiskeyFull"] = 5,
                    ["Base.Pike"] = 5,
                    ["Base.Butter"] = 5,
                    ["Base.HollyBerry"] = 5,
                    ["Base.Ginseng"] = 10,
                },
                result = "Permanent.HastyHerring",
                additionalResults = {},
            },
            {
                name = "MakeDoubleHastyHerring",
                type = "Exclusive",
                disabled = false,
                sound = "PourWaterIntoObject",
                texture = "media/textures/Item_DoubleHastyHerring.png",
                time = 300,
                cookingSkill = 10,
                usedItems = {
                    ["Permanent.ExclusiveRecipe"] = 1,
                    ["Permanent.HastyHerring"] = 1,
                    ["Base.WhiskeyFull"] = 5,
                    ["Base.Pike"] = 5,
                    ["Base.Yeast"] = 10,
                    ["Base.Ginseng"] = 30,
                    ["Base.Violets"] = 50,
                },
                result = "Permanent.DoubleHastyHerring",
                additionalResults = {},
            },
            {
                name = "MakeGreedyHammer",
                type = "Exclusive",
                disabled = false,
                sound = "PourWaterIntoObject",
                texture = "media/textures/Item_GreedyHammer.png",
                time = 300,
                cookingSkill = 10,
                usedItems = {
                    ["Permanent.ExclusiveRecipe"] = 1,
                    ["Base.WhiskeyFull"] = 5,
                    ["Base.Sledgehammer"] = 1,
                    ["Base.WildEggs"] = 10,
                    ["Base.Salt"] = 5,
                    ["Base.Acorn"] = 5,
                },
                result = "Permanent.GreedyHammer",
                additionalResults = {},
            },
            {
                name = "MakeDoubleGreedyHammer",
                type = "Exclusive",
                disabled = false,
                sound = "PourWaterIntoObject",
                texture = "media/textures/Item_DoubleGreedyHammer.png",
                time = 300,
                cookingSkill = 10,
                usedItems = {
                    ["Permanent.ExclusiveRecipe"] = 1,
                    ["Permanent.GreedyHammer"] = 1,
                    ["Base.WhiskeyFull"] = 5,
                    ["Base.WildEggs"] = 20,
                    ["Base.Yeast"] = 10,
                    ["Base.Acorn"] = 25,
                    ["Base.Violets"] = 50,
                },
                result = "Permanent.DoubleGreedyHammer",
                additionalResults = {},
            },
            {
                name = "MakeGreedyAxe",
                type = "Exclusive",
                disabled = false,
                sound = "PourWaterIntoObject",
                texture = "media/textures/Item_GreedyAxe.png",
                time = 300,
                cookingSkill = 10,
                usedItems = {
                    ["Permanent.ExclusiveRecipe"] = 1,
                    ["Base.WhiskeyFull"] = 5,
                    ["Base.Axe"] = 1,
                    ["Base.WildEggs"] = 10,
                    ["Base.Pepper"] = 5,
                    ["Base.Acorn"] = 10,
                },
                result = "Permanent.GreedyAxe",
                additionalResults = {},
            },
            {
                name = "MakeDoubleGreedyAxe",
                type = "Exclusive",
                disabled = false,
                sound = "PourWaterIntoObject",
                texture = "media/textures/Item_DoubleGreedyAxe.png",
                time = 300,
                cookingSkill = 10,
                usedItems = {
                    ["Permanent.ExclusiveRecipe"] = 1,
                    ["Permanent.GreedyAxe"] = 1,
                    ["Base.WhiskeyFull"] = 5,
                    ["Base.WildEggs"] = 20,
                    ["Base.Yeast"] = 10,
                    ["Base.Acorn"] = 25,
                    ["Base.Violets"] = 50,
                },
                result = "Permanent.DoubleGreedyAxe",
                additionalResults = {},
            },
            {
                name = "MakeStrayBullet",
                type = "Exclusive",
                disabled = false,
                sound = "PourWaterIntoObject",
                texture = "media/textures/Item_StrayBullet.png",
                time = 300,
                cookingSkill = 10,
                usedItems = {
                    ["Permanent.ExclusiveRecipe"] = 1,
                    ["Base.WhiskeyFull"] = 5,
                    ["Base.Worm"] = 100,
                    ["Base.ShotgunShells"] = 20,
                    ["Base.556Bullets"] = 20,
                    ["Base.308Bullets"] = 20,
                },
                result = "Permanent.StrayBullet",
                additionalResults = {},
            },
            {
                name = "MakeSlipperyFish",
                type = "Exclusive",
                disabled = false,
                sound = "PourWaterIntoObject",
                texture = "media/textures/Item_SlipperyFish.png",
                time = 300,
                cookingSkill = 10,
                usedItems = {
                    ["Permanent.ExclusiveRecipe"] = 1,
                    ["Base.WhiskeyFull"] = 5,
                    ["farming.RemouladeFull"] = 5,
                    ["Base.Butter"] = 10,
                    ["Base.OilOlive"] = 5,
                    ["Base.OilVegetable"] = 5,
                },
                result = "Permanent.SlipperyFish",
                additionalResults = {},
            },
            {
                name = "MakeSolidAdventurer",
                type = "Exclusive",
                disabled = false,
                sound = "PourWaterIntoObject",
                texture = "media/textures/Item_SolidAdventurer.png",
                time = 300,
                cookingSkill = 10,
                usedItems = {
                    ["Permanent.ExclusiveRecipe"] = 1,
                    ["Base.WhiskeyFull"] = 5,
                    ["Base.Wine2"] = 5,
                    ["farming.Bacon"] = 25,
                    ["Base.Pencil"] = 10,
                    ["Base.WildGarlic2"] = 25,
                },
                result = "Permanent.SolidAdventurer",
                additionalResults = {},
            },
            {
                name = "MakeSlenderDoe",
                type = "Exclusive",
                disabled = false,
                sound = "PourWaterIntoObject",
                texture = "media/textures/Item_SlenderDoe.png",
                time = 300,
                cookingSkill = 10,
                usedItems = {
                    ["Permanent.ExclusiveRecipe"] = 1,
                    ["Base.Wine2"] = 5,
                    ["Base.Wine"] = 5,
                    ["Base.GrapeLeaves"] = 25,
                    ["Base.Milk"] = 5,
                    ["Base.Pickles"] = 10,
                },
                result = "Permanent.SlenderDoe",
                additionalResults = {},
            },
            {
                name = "MakeNicotineOverdose",
                type = "Exclusive",
                disabled = false,
                sound = "PourWaterIntoObject",
                texture = "media/textures/Item_NicotineOverdose.png",
                time = 300,
                cookingSkill = 10,
                usedItems = {
                    ["Permanent.ExclusiveRecipe"] = 1,
                    ["Base.WhiskeyFull"] = 5,
                    ["Base.Sugar"] = 10,
                    ["Base.Cigarettes"] = 1000,
                    ["Base.Coffee2"] = 5,
                    ["Base.LemonGrass"] = 25
                },
                result = "Permanent.NicotineOverdose",
                additionalResults = {},
            },
        },
    }

    local pzversion = string.sub(getCore():getVersionNumber(), 1, 2)
    if pzversion == "42" then
        recipes = {
            Vanilla = {
                {
                    name = "MakeWhiskey",
                    type = "Vanilla",
                    disabled = false,
                    sound = "PourWaterIntoObject",
                    texture = "Item_WhiskeyFull",
                    time = 300,
                    cookingSkill = 3,
                    usedItems = {
                        ["Base.Yeast"] = 1,
                        ["Base.Corn"] = 1,
                        ["Base.UnusableWood"] = 1,
                    },
                    fluids = {
                        {code = "Base.Whiskey", name = "Water", amount = 1},
                    },
                    result = "Base.WhiskeyFull",
                    additionalResults = {},
                },
                {
                    name = "MakeWine",
                    type = "Vanilla",
                    disabled = false,
                    sound = "PourWaterIntoObject",
                    texture = "Item_Wine2Full",
                    time = 300,
                    cookingSkill = 3,
                    usedItems = {
                        ["Base.Sugar"] = 1,
                        ["Base.Grapes"] = 1,
                    },
                    fluids = {
                        {code = "Base.BottleCrafted", name = "Water", amount = 1},
                    },
                    result = "Base.Wine2",
                    additionalResults = {},
                },
                {
                    name = "MakeBeer",
                    type = "Vanilla",
                    disabled = false,
                    sound = "PourWaterIntoObject",
                    texture = "Item_BeerBottle",
                    time = 300,
                    cookingSkill = 3,
                    usedItems = {
                        ["Base.Sugar"] = 1,
                        ["Base.Corn"] = 1,
                    },
                    fluids = {
                        {code = "Base.BeerEmpty", name = "Water", amount = 1},
                    },
                    result = "Base.BeerBottle",
                    additionalResults = {},
                },
            },
            Exclusive = {
                {
                    name = "MakeHastyHerring",
                    type = "Exclusive",
                    disabled = false,
                    sound = "PourWaterIntoObject",
                    texture = "media/textures/Item_HastyHerring.png",
                    time = 300,
                    cookingSkill = 10,
                    usedItems = {
                        ["Permanent.ExclusiveRecipe"] = 1,
                        ["Base.Pike"] = 5,
                        ["Base.Butter"] = 5,
                        ["Base.HollyBerry"] = 5,
                        ["Base.Ginseng"] = 10,
                    },
                    fluids = {
                        {code = "Base.Whiskey", name = "Whiskey", amount = 5},
                    },
                    result = "Permanent.HastyHerring",
                    additionalResults = {},
                },
                {
                    name = "MakeDoubleHastyHerring",
                    type = "Exclusive",
                    disabled = false,
                    sound = "PourWaterIntoObject",
                    texture = "media/textures/Item_DoubleHastyHerring.png",
                    time = 300,
                    cookingSkill = 10,
                    usedItems = {
                        ["Permanent.ExclusiveRecipe"] = 1,
                        ["Permanent.HastyHerring"] = 1,
                        ["Base.Pike"] = 10,
                        ["Base.Yeast"] = 10,
                        ["Base.Ginseng"] = 30,
                        ["Base.Violets"] = 50,
                    },
                    fluids = {
                        {code = "Base.Whiskey", name = "Whiskey", amount = 5},
                    },
                    result = "Permanent.DoubleHastyHerring",
                    additionalResults = {},
                },
                {
                    name = "MakeGreedyHammer",
                    type = "Exclusive",
                    disabled = false,
                    sound = "PourWaterIntoObject",
                    texture = "media/textures/Item_GreedyHammer.png",
                    time = 300,
                    cookingSkill = 10,
                    usedItems = {
                        ["Permanent.ExclusiveRecipe"] = 1,
                        ["Base.Sledgehammer"] = 1,
                        ["Base.WildEggs"] = 10,
                        ["Base.Salt"] = 5,
                        ["Base.Acorn"] = 5,
                    },
                    fluids = {
                        {code = "Base.Whiskey", name = "Whiskey", amount = 5},
                    },
                    result = "Permanent.GreedyHammer",
                    additionalResults = {},
                },
                {
                    name = "MakeDoubleGreedyHammer",
                    type = "Exclusive",
                    disabled = false,
                    sound = "PourWaterIntoObject",
                    texture = "media/textures/Item_DoubleGreedyHammer.png",
                    time = 300,
                    cookingSkill = 10,
                    usedItems = {
                        ["Permanent.ExclusiveRecipe"] = 1,
                        ["Permanent.GreedyHammer"] = 1,
                        ["Base.WildEggs"] = 20,
                        ["Base.Yeast"] = 10,
                        ["Base.Acorn"] = 25,
                        ["Base.Violets"] = 50,
                    },
                    fluids = {
                        {code = "Base.Whiskey", name = "Whiskey", amount = 5},
                    },
                    result = "Permanent.DoubleGreedyHammer",
                    additionalResults = {},
                },
                {
                    name = "MakeGreedyAxe",
                    type = "Exclusive",
                    disabled = false,
                    sound = "PourWaterIntoObject",
                    texture = "media/textures/Item_GreedyAxe.png",
                    time = 300,
                    cookingSkill = 10,
                    usedItems = {
                        ["Permanent.ExclusiveRecipe"] = 1,
                        ["Base.Axe"] = 1,
                        ["Base.WildEggs"] = 10,
                        ["Base.Pepper"] = 5,
                        ["Base.Acorn"] = 10,
                    },
                    fluids = {
                        {code = "Base.Whiskey", name = "Whiskey", amount = 5},
                    },
                    result = "Permanent.GreedyAxe",
                    additionalResults = {},
                },
                {
                    name = "MakeDoubleGreedyAxe",
                    type = "Exclusive",
                    disabled = false,
                    sound = "PourWaterIntoObject",
                    texture = "media/textures/Item_DoubleGreedyAxe.png",
                    time = 300,
                    cookingSkill = 10,
                    usedItems = {
                        ["Permanent.ExclusiveRecipe"] = 1,
                        ["Permanent.GreedyAxe"] = 1,
                        ["Base.WildEggs"] = 20,
                        ["Base.Yeast"] = 10,
                        ["Base.Acorn"] = 25,
                        ["Base.Violets"] = 50,
                    },
                    fluids = {
                        {code = "Base.Whiskey", name = "Whiskey", amount = 5},
                    },
                    result = "Permanent.DoubleGreedyAxe",
                    additionalResults = {},
                },
                {
                    name = "MakeStrayBullet",
                    type = "Exclusive",
                    disabled = false,
                    sound = "PourWaterIntoObject",
                    texture = "media/textures/Item_StrayBullet.png",
                    time = 300,
                    cookingSkill = 10,
                    usedItems = {
                        ["Permanent.ExclusiveRecipe"] = 1,
                        ["Base.Worm"] = 100,
                        ["Base.ShotgunShells"] = 20,
                        ["Base.556Bullets"] = 20,
                        ["Base.308Bullets"] = 20,
                    },
                    fluids = {
                        {code = "Base.Whiskey", name = "Whiskey", amount = 5},
                    },
                    result = "Permanent.StrayBullet",
                    additionalResults = {},
                },
                {
                    name = "MakeSlipperyFish",
                    type = "Exclusive",
                    disabled = false,
                    sound = "PourWaterIntoObject",
                    texture = "media/textures/Item_SlipperyFish.png",
                    time = 300,
                    cookingSkill = 10,
                    usedItems = {
                        ["Permanent.ExclusiveRecipe"] = 1,
                        ["Base.RemouladeFull"] = 5,
                        ["Base.Butter"] = 10,
                        ["Base.OilOlive"] = 5,
                        ["Base.OilVegetable"] = 5,
                    },
                    fluids = {
                        {code = "Base.Whiskey", name = "Whiskey", amount = 5},
                    },
                    result = "Permanent.SlipperyFish",
                    additionalResults = {},
                },
                {
                    name = "MakeSolidAdventurer",
                    type = "Exclusive",
                    disabled = false,
                    sound = "PourWaterIntoObject",
                    texture = "media/textures/Item_SolidAdventurer.png",
                    time = 300,
                    cookingSkill = 10,
                    usedItems = {
                        ["Permanent.ExclusiveRecipe"] = 1,
                        ["Base.Bacon"] = 25,
                        ["Base.Pencil"] = 10,
                        ["Base.WildGarlic2"] = 25,
                    },
                    fluids = {
                        {code = "Base.Whiskey", name = "Whiskey", amount = 5},
                        {code = "Base.Wine2", name = "Wine", amount = 5},
                    },
                    result = "Permanent.SolidAdventurer",
                    additionalResults = {},
                },
                {
                    name = "MakeSlenderDoe",
                    type = "Exclusive",
                    disabled = false,
                    sound = "PourWaterIntoObject",
                    texture = "media/textures/Item_SlenderDoe.png",
                    time = 300,
                    cookingSkill = 10,
                    usedItems = {
                        ["Permanent.ExclusiveRecipe"] = 1,
                        ["Base.GrapeLeaves"] = 25,
                        ["Base.Pickles"] = 10,
                    },
                    fluids = {
                        {code = "Base.Wine2", name = "Wine", amount = 5},
                        {code = "Base.Wine", name = "Wine", amount = 5},
                        {code = "Base.Milk", name = "CowMilk", amount = 5},
                    },
                    result = "Permanent.SlenderDoe",
                    additionalResults = {},
                },
                {
                    name = "MakeNicotineOverdose",
                    type = "Exclusive",
                    disabled = false,
                    sound = "PourWaterIntoObject",
                    texture = "media/textures/Item_NicotineOverdose.png",
                    time = 300,
                    cookingSkill = 10,
                    usedItems = {
                        ["Permanent.ExclusiveRecipe"] = 1,
                        ["Base.Sugar"] = 10,
                        ["Base.CigaretteSingle"] = 100,
                        ["Base.Coffee2"] = 5,
                        ["Base.LemonGrass"] = 25,
                    },
                    fluids = {
                        {code = "Base.Whiskey", name = "Whiskey", amount = 5},
                    },
                    result = "Permanent.NicotineOverdose",
                    additionalResults = {},
                },
            },
        }
    end

    return recipes
end

-- LoadRecipes gets and returns recipes from moonshine-pecipes.json
-- file in Zomboid/Lua directory.
function MoonshineRecipesServer.LoadRecipes()
    if MoonshineRecipesServer.Recipes then
        return MoonshineRecipesServer.Recipes
    end

    local recipeFileName = "moonshine-recipes.json"
    local pzversion = string.sub(getCore():getVersionNumber(), 1, 2)
    if pzversion == "42" then
        recipeFileName = "moonshine-recipes-b42.json"
    end

    local recipes = MoonshineRecipesServer.ReadFile(recipeFileName)
    if not recipes then
        recipes = MoonshineRecipesServer.GetDefaultRecipes()

        MoonshineRecipesServer.WriteFile(recipeFileName, recipes)
    end

    MoonshineRecipesServer.Recipes = recipes

    return recipes
end

-- WriteFile saves values to file in Zomboid/Lua directory.
-- TODO: Add function to openutils.
function MoonshineRecipesServer.WriteFile(filename, data)
    local writer = getFileWriter(filename, false, false)
    if not writer then
        return false
    end

    if data ~= nil then
        local encodeddata = json:encode_pretty(data, nil, json_pretty_options)
        if encodeddata ~= nil then
            writer:write(encodeddata)
        end
    end

    writer:close()

    return true
end

-- ReadFile reads instance values from file in Zomboid/Lua directory.
-- TODO: Add function to openutils.
function MoonshineRecipesServer.ReadFile(filename)
    local reader = getFileReader(filename, false)
    if not reader then
        return
    end

    local rawdata = ""

    while true do
        local line = reader:readLine()
        if not line then
            reader:close()
            break
        end

        rawdata = rawdata .. line
    end

    if rawdata ~= "" then
        local data = json:decode(rawdata)
        return data
    end
end

-- OnClientCommand handles commands from client.
function MoonshineRecipesServer.OnClientCommand(module, command, character, args)
    if module ~= "Permanent" then
        return
    end

    if command == "GetRecipes" then
        local recipes = MoonshineRecipesServer.LoadRecipes()

        if isServer() then
            sendServerCommand(character, "Permanent", "GetRecipes", {recipes = recipes})
        else
            MoonshineRecipesClient.Recipes = recipes
        end
    end
end

-- OnServerStarted handles OnServerStarted Lua event.
function MoonshineRecipesServer.OnServerStarted()
    local _ = MoonshineRecipesServer.LoadRecipes()
end

Events.OnClientCommand.Add(MoonshineRecipesServer.OnClientCommand)
Events.OnServerStarted.Add(MoonshineRecipesServer.OnServerStarted)
