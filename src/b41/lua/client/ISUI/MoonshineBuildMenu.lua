--
-- Copyright (c) 2023 outdead.
-- Use of this source code is governed by the Apache 2.0 license
-- that can be found in the LICENSE file.
--

-- MoonshineBuildMenu contains build options.
-- TODO: Remove file after release b42 on stable.
MoonshineBuildMenu = {}

-- doContextMenu adds "Build Moonshine" option to context menu.
function MoonshineBuildMenu.doContextMenu(player, context, worldobjects, test)
    if test and ISWorldObjectContextMenu.Test then return true end

    local character = getSpecificPlayer(player)

    if character:getVehicle() then
        return true
    end

    -- Add Build Moonshine option to context menu.
    if SandboxVars.Permanent.CanBuildMoonshineStill or isAdmin() then
        local buildOption = context:getOptionFromName(getText("ContextMenu_Build"))
        if buildOption then
            local buildMenu = context:getSubMenu(buildOption.subOption)
            if buildMenu then
                local moonshineOption = buildMenu:addOption(getText("ContextMenu_Moonshine"), worldobjects, nil);
                local moonshineMenu = buildMenu:getNew(buildMenu);
                context:addSubMenu(moonshineOption, moonshineMenu);

                MoonshineBuildMenu.AddBuildOption(player, context, worldobjects, moonshineMenu)
            end
        end
    end
end

-- AddBuildOption adds options to click menu.
function MoonshineBuildMenu.AddBuildOption(player, context, worldobjects, workbenchesSubMenu)
    local square = nil;

    -- Get the thumpable item (like wall/door/furniture etc.) if exist on the tile which right clicked.
    for i, v in ipairs(worldobjects) do
        square = v:getSquare();
    end

    local sprite = {};
    sprite.sprite1 = "MoonshineStill_1";
    sprite.sprite2 = "MoonshineStill_0";
    sprite.northSprite1 = "MoonshineStill_2";
    sprite.northSprite2 = "MoonshineStill_3";

    local option = workbenchesSubMenu:addOption(getText("ContextMenu_MoonshineStill"), worldobjects, MoonshineBuildMenu.OnBuildMoonshineStill, square, sprite, player);
    local tooltip = ISBuildMenu.canBuild(12, 48, 0, 0, 0, 10, option, player);
    tooltip:setName(getText("ContextMenu_MoonshineStill"));
    tooltip.description = getText("ContextMenu_MoonshineStill_Description") .. tooltip.description;
    tooltip:setTexture(sprite.sprite1);
end

-- onBuildMoonshineStill adds callback to build Moonshine Still option.
MoonshineBuildMenu.OnBuildMoonshineStill = function(worldobjects, square, sprite, player)
    -- name, sprite, northSprite
    local furniture = ISDoubleTileFurniture:new(getText("ContextMenu_MoonshineStill"), sprite.sprite1, sprite.sprite2, sprite.northSprite1, sprite.northSprite2);
    furniture.modData["xp:Woodwork"] = 5;
    furniture.modData["need:Base.Plank"] = "6";
    furniture.modData["need:Base.Nails"] = "4";
    furniture.player = player
    furniture.completionSound = "BuildWoodenStructureLarge";
    getCell():setDrag(furniture, player);
end

Events.OnFillWorldObjectContextMenu.Add(MoonshineBuildMenu.doContextMenu);
