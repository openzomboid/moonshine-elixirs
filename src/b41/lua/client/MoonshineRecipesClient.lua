--
-- Copyright (c) 2025 outdead.
-- Use of this source code is governed by the Apache 2.0 license
-- that can be found in the LICENSE file.
--

-- MoonshineRecipesClient contains recipes for moonshine still.
MoonshineRecipesClient = {
    RecipesLoadTicker = {}
}

-- IsEnoughMaterials checks character's inventory has enough materials
-- for recipe.
function MoonshineRecipesClient.IsEnoughMaterials(character, recipe)
    if not recipe then return false end

    local inventory = character:getInventory()

    for itemCode, neededItemsCount in pairs(recipe.usedItems) do
        local items = inventory:getAllType(itemCode)

        if not items or items:size() < neededItemsCount then
            return false
        end

        local inventoryItemsCount = 0

        for i=1, items:size() do
            local itemToRemove = items:get(i-1)

            if not MoonshineRecipesClient.IsItemBlocked(character, itemToRemove) then
                if inventoryItemsCount >= neededItemsCount then
                    break
                end

                inventoryItemsCount = inventoryItemsCount + 1
            end
        end

        if inventoryItemsCount ~= neededItemsCount then
            return false
        end
    end

    return true
end

-- MoonshineRecipesClient checks character's inventory has enough fluids
-- for recipe.
function MoonshineRecipesClient.IsEnoughFluids(character, recipe)
    if not recipe then return false end

    local inventory = character:getInventory()

    if recipe.fluids then
        for _, fluid in pairs(recipe.fluids) do
            local items = inventory:getAllType(fluid.code)

            if not items or items:size() < 1 then
                return false
            end

            local inventoryItemsCount = 0

            for i=1, items:size() do
                local itemToRemove = items:get(i-1)

                if not MoonshineRecipesClient.IsItemBlocked(character, itemToRemove) and MoonshineRecipesClient.IsFluidReady(itemToRemove, fluid) then
                    if inventoryItemsCount >= 1 then
                        break
                    end

                    inventoryItemsCount = inventoryItemsCount + 1
                end
            end

            if inventoryItemsCount ~= 1 then
                return false
            end
        end
    end

    return true
end

-- IsItemBlocked returns true if item is not allowed for recipe.
function MoonshineRecipesClient.IsItemBlocked(character, item)
    if item:isBroken() then
        return true
    end

    if item:isFavorite() then
        return true
    end

    if item:isEquipped() then
        return true
    end

    return character:isEquipped(item) or character:isAttachedItem(item)
end

-- IsFluidReady returns true if item with fluid is allowed for recipe.
function MoonshineRecipesClient.IsFluidReady(item, fluid)
    if not fluid then
        return true
    end

    if item:getFullType() ~= fluid.code then
        return true
    end

    -- Temporary true while b42 is unstable.
    -- TODO: Return false if item is not a FluidContainer.
    if not item.getFluidContainer then
        return true
    end

    local fluidContainer = item:getFluidContainer()

    if fluidContainer:isEmpty() then
        return false
    end

    local primaryFluid = fluidContainer:getPrimaryFluid()
    if not primaryFluid then
        return false
    end

    local primaryFluidName = primaryFluid:toString()
    if primaryFluidName ~= fluid.name then
        return false
    end

    local primaryFluidAmount = fluidContainer:getPrimaryFluidAmount()
    if primaryFluidAmount < fluid.amount then
        return false
    end

    return true
end

-- OnServerCommand handles commands from server.
function MoonshineRecipesClient.OnServerCommand(module, command, args)
    if module ~= "Permanent" then
        return
    end

    if command == "GetRecipes" then
        MoonshineRecipesClient.Recipes = args.recipes
    end
end

-- OnCreatePlayer handles OnCreatePlayer Lua event.
function MoonshineRecipesClient.OnCreatePlayer(id)
    MoonshineRecipesClient.RecipesLoadTicker.OnTick = function()
        local character = getPlayer();

        if character then
            sendClientCommand(character, "Permanent", "GetRecipes", {})

            Events.OnTick.Remove(MoonshineRecipesClient.RecipesLoadTicker.OnTick)
        end
    end

    Events.OnTick.Add(MoonshineRecipesClient.RecipesLoadTicker.OnTick);
end

Events.OnServerCommand.Add(MoonshineRecipesClient.OnServerCommand)
Events.OnCreatePlayer.Add(MoonshineRecipesClient.OnCreatePlayer);
