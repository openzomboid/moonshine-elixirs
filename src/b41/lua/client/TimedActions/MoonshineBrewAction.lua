--
-- Copyright (c) 2023 outdead.
-- Use of this source code is governed by the Apache 2.0 license
-- that can be found in the LICENSE file.
--

require "TimedActions/ISBaseTimedAction"
require 'MoonshineRecipesClient'

-- MoonshineBrewAction implements TimedAction for brew recipes.
MoonshineBrewAction = ISBaseTimedAction:derive("MoonshineBrewAction");

-- new creates instance of MoonshineBrewAction TimedAction.
function MoonshineBrewAction:new(character, recipe, object)
    local cookingLevel = character:getPerkLevel(Perks.Cooking)

    local o = {}
    setmetatable(o, self)
    self.__index = self
    o.character = character;
    o.stopOnWalk = true;
    o.stopOnRun = true;
    o.maxTime = recipe.time - (cookingLevel * 20 - 100);
    o.object = object
    o.recipe = recipe
    return o
end

-- isValid returns true if recipe is allowed and character's inventory has
-- enough materials.
function MoonshineBrewAction:isValid()
    if not MoonshineRecipesClient.IsEnoughMaterials(self.character, self.recipe) then
        return false
    end

    if not MoonshineRecipesClient.IsEnoughFluids(self.character, self.recipe) then
        return false
    end

    return true
end

-- waitToStart returns false. Needed for TimedAction implementation.
function MoonshineBrewAction:waitToStart()
    return false
end

-- update does nothing. Needed for TimedAction implementation.
function MoonshineBrewAction:update()
end

-- start starts brewing action.
-- TODO: Add animation.
-- local animation = MoonshineRecipesClient.GetAnimation(self.recipe.animationType)
-- self:setActionAnim(animation).
function MoonshineBrewAction:start()
    self.sound = self.character:playSound(self.recipe.sound)
end

-- stop stops brewing action.
function MoonshineBrewAction:stop()
    ISBaseTimedAction.stop(self);
end

-- perform takes recipe materials and spawns recipe result.
function MoonshineBrewAction:perform()
    local inventory = self.character:getInventory()

    self:takeMaterials()
    self:takeFluids()

    -- Add results to player inventory.
    inventory:AddItems(self.recipe.result, 1)
    for itemCode, addItemsCount in pairs(self.recipe.additionalResults) do
        inventory:AddItems(itemCode, addItemsCount)
    end

    return self:performNext()
end

-- performNext removes action from queue and allows to start next action.
function MoonshineBrewAction:performNext()
    ISBaseTimedAction.perform(self)
end

-- takeMaterials removes recipe materials from character's inventory.
function MoonshineBrewAction:takeMaterials()
    local inventory = self.character:getInventory()

    for itemCode, neededItemsCount in pairs(self.recipe.usedItems) do
        local items = inventory:getAllType(itemCode)

        if items:size() < neededItemsCount then
            return self:performNext()
        end

        local removedItemsCount = 0

        for i=1, items:size() do
            local itemToRemove = items:get(i-1)

            if not MoonshineRecipesClient.IsItemBlocked(self.character, itemToRemove) then
                if removedItemsCount >= neededItemsCount then
                    break
                end

                if itemToRemove:getContainer() then
                    itemToRemove:getContainer():Remove(itemToRemove)
                else
                    inventory:Remove(itemToRemove)
                end

                removedItemsCount = removedItemsCount + 1
            end
        end

        if removedItemsCount ~= neededItemsCount then
            return self:performNext()
        end
    end
end

-- takeFluids removes recipe fluids from character's inventory.
function MoonshineBrewAction:takeFluids()
    local inventory = self.character:getInventory()

    if not self.recipe.fluids then
        return
    end

    for _, fluid in pairs(self.recipe.fluids) do
        local items = inventory:getAllType(fluid.code)

        if items:size() < 1 then
            return self:performNext()
        end

        local removedItemsCount = 0

        for i=1, items:size() do
            local itemToRemove = items:get(i-1)

            if not MoonshineRecipesClient.IsItemBlocked(self.character, itemToRemove) and MoonshineRecipesClient.IsFluidReady(itemToRemove, fluid) then
                if removedItemsCount >= 1 then
                    break
                end

                if itemToRemove:getContainer() then
                    itemToRemove:getContainer():Remove(itemToRemove)
                else
                    inventory:Remove(itemToRemove)
                end

                removedItemsCount = removedItemsCount + 1
            end
        end

        if removedItemsCount ~= 1 then
            return self:performNext()
        end
    end
end
