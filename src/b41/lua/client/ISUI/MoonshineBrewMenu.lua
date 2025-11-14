--
-- Copyright (c) 2023 outdead.
-- Use of this source code is governed by the Apache 2.0 license
-- that can be found in the LICENSE file.
--

require 'MoonshineRecipesClient'

-- MoonshineBrewMenu is the game context menu extender.
MoonshineBrewMenu = {}

MoonshineBrewMenu.ghs = " <RGB:" .. getCore():getGoodHighlitedColor():getR() .. "," .. getCore():getGoodHighlitedColor():getG() .. "," .. getCore():getGoodHighlitedColor():getB() .. "> "
MoonshineBrewMenu.bhs = " <RGB:" .. getCore():getBadHighlitedColor():getR() .. "," .. getCore():getBadHighlitedColor():getG() .. "," .. getCore():getBadHighlitedColor():getB() .. "> "

-- doContextMenu adds "Brewing" option to context menu.
function MoonshineBrewMenu.doContextMenu(player, context, worldobjects, test)
    if test and ISWorldObjectContextMenu.Test then return true end

    local character = getSpecificPlayer(player)

    if character:getVehicle() then
        return true
    end

    -- Add Brewing options to context menu.
    local object = worldobjects[1];
    local sprite = object:getSprite()

    local isMoonshineStill

    if sprite and sprite:getName() then
        local spriteName = sprite:getName()

        isMoonshineStill = spriteName == "MoonshineStill_0" or spriteName == "MoonshineStill_1" or
                spriteName == "MoonshineStill_2" or spriteName == "MoonshineStill_3"
    end

    if isMoonshineStill and (SandboxVars.Permanent.AllowBrewingVanillaAlcohol or SandboxVars.Permanent.AllowBrewingExclusiveAlcohol) then
        local distilOption = context:addOption(getText("ContextMenu_DistillAlcohol"), worldobjects, nil);
        local distilMenu = context:getNew(context);
        context:addSubMenu(distilOption, distilMenu);

        if SandboxVars.Permanent.AllowBrewingVanillaAlcohol then
            for _, recipe in pairs(MoonshineRecipesClient.Recipes.Vanilla) do
                MoonshineBrewMenu.AddBrewOption(distilMenu, character, object, recipe)
            end
        end

        if SandboxVars.Permanent.AllowBrewingExclusiveAlcohol then
            local distilExclusiveOption = distilMenu:addOption(getText("ContextMenu_DistillExclusiveAlcohol"), worldobjects, nil);
            local distilExclusiveMenu = distilMenu:getNew(distilMenu);
            context:addSubMenu(distilExclusiveOption, distilExclusiveMenu);

            for _, recipe in pairs(MoonshineRecipesClient.Recipes.Exclusive) do
                MoonshineBrewMenu.AddBrewOption(distilExclusiveMenu, character, object, recipe)
            end
        end
    end

    return true
end

function MoonshineBrewMenu.AddBrewOption(distilMenu, character, object, recipe)
    if recipe.disabled then
        return
    end

    local optionName = getText("ContextMenu_MakeAlcohol") .. " " .. getItemNameFromFullType(recipe.result)
    local option = distilMenu:addOption(optionName, worldobjects, MoonshineBrewMenu.OnBrew, character, object, recipe);
    option.iconTexture = getTexture(recipe.texture);

    local toolTip = MoonshineBrewMenu.CreateBrewTooltip(option, character, recipe);
    toolTip:setName(optionName);
    toolTip:setTexture(recipe.texture);
end

function MoonshineBrewMenu.CreateBrewTooltip(option, character, recipe)
    local inventory = character:getInventory()
    local cookingSkill = character:getPerkLevel(Perks.Cooking);

    local tooltip = ISWorldObjectContextMenu.addToolTip();
    option.toolTip = tooltip;
    if recipe.type == "Vanilla" then
        tooltip.footNote = getText("Tooltip_brew_FootNote")
    end

    local enabled = true;
    tooltip.description = getText("Tooltip_craft_Needs") .. ": <LINE>";

    for itemCode, neededItemsCount in pairs(recipe.usedItems) do
        local enabledItem = MoonshineBrewMenu.AddMaterialItemToBrewTooltip(tooltip, character, itemCode, neededItemsCount)
        if not enabledItem then
            enabled = false
        end
    end

    if recipe.fluids then
        for _, fluid in pairs(recipe.fluids) do
            local enabledItem = MoonshineBrewMenu.AddFluidItemToBrewTooltip(tooltip, character, fluid)
            if not enabledItem then
                enabled = false
            end
        end
    end

    local color = MoonshineBrewMenu.ghs;
    if cookingSkill < recipe.cookingSkill then
        color = MoonshineBrewMenu.bhs
        enabled = false;
    end

    tooltip.description = tooltip.description .. "<LINE>" .. color .. getText("IGUI_perks_Cooking") .. " " .. cookingSkill .. "/" .. recipe.cookingSkill .. " <LINE>";

    if not enabled then
        option.onSelect = nil;
        option.notAvailable = true;
    end

    tooltip.description = " " .. tooltip.description .. " ";

    return tooltip;
end

function MoonshineBrewMenu.AddMaterialItemToBrewTooltip(tooltip, character, itemCode, neededItemsCount)
    local inventory = character:getInventory()
    local enabled = true

    local items = inventory:getAllType(itemCode)
    local itemsCount = 0

    if items then
        for i=1, items:size() do
            local itemToRemove = items:get(i-1);
            if not MoonshineRecipesClient.IsItemBlocked(character, itemToRemove) then
                itemsCount = itemsCount + 1;
            end
        end
    end

    local color = MoonshineBrewMenu.ghs;
    if itemsCount < neededItemsCount then
        color = MoonshineBrewMenu.bhs
        enabled = false;
    end

    tooltip.description = tooltip.description .. color .. getItemNameFromFullType(itemCode) .. " " .. itemsCount .. "/" .. neededItemsCount .. " <LINE>";

    return enabled
end

function MoonshineBrewMenu.AddFluidItemToBrewTooltip(tooltip, character, fluid)
    local inventory = character:getInventory()
    local enabled = true

    local items = inventory:getAllType(fluid.code)
    local itemsCount = 0

    if items then
        for i=1, items:size() do
            local itemToRemove = items:get(i-1);
            if not MoonshineRecipesClient.IsItemBlocked(character, itemToRemove) and MoonshineRecipesClient.IsFluidReady(itemToRemove, fluid) then
                itemsCount = itemsCount + 1;
            end
        end
    end

    local color = MoonshineBrewMenu.ghs;
    if itemsCount < 1 then
        color = MoonshineBrewMenu.bhs
        enabled = false;
    end

    tooltip.description = tooltip.description .. color .. getItemNameFromFullType(fluid.code) .. " " .. itemsCount .. "/" .. "1" .. " <LINE>";

    return enabled
end

function MoonshineBrewMenu.OnBrew(worldobjects, character, object, recipe)
    if ISCampingMenu.walkToCampfire(character, object:getSquare()) then
        ISTimedActionQueue.add(MoonshineBrewAction:new(character, recipe, object));
    end
end

Events.OnFillWorldObjectContextMenu.Add(MoonshineBrewMenu.doContextMenu);
