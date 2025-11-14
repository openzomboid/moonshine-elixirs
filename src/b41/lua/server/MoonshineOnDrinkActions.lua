--
-- Copyright (c) 2023 outdead.
-- Use of this source code is governed by the Apache 2.0 license
-- that can be found in the LICENSE file.
--

-- PerkLevelup creates level up for perk.
function PerkLevelup(player, perkType)
    local perkLevel = player:getPerkLevel(perkType);

    if perkLevel < 10 then
        local xp = player:getXp()
        local xpTotal = xp:getXP(perkType)
        local xpInLevel = xpTotal - ISSkillProgressBar.getPreviousXpLvl(perkType, perkLevel)
        if xpInLevel < 0 then
            xpInLevel = 0
        end

        player:LevelPerk(perkType, false);
        player:getXp():setXPToLevel(perkType, player:getPerkLevel(perkType));
        SyncXp(player)

        if SandboxVars.Permanent.KeepExperience then
            -- Add all XP: kicks with Type15 xp is large.
            player:getXp():AddXPNoMultiplier(perkType, xpInLevel);
            SyncXp(player)
        end
    end
end

-- OnDrink_HastyHerring adds action to drink Permanent.HastyHerring.
function OnDrink_HastyHerring(food, character, percent)
    if percent < 1 then
        character:Say(getText("Moodles_nothing_happened"))
        return
    end

    PerkLevelup(character, Perks.Sprinting);
end

-- OnDrink_DoubleHastyHerring adds action to drink Permanent.DoubleHastyHerring.
function OnDrink_DoubleHastyHerring(food, character, percent)
    if percent < 1 then
        character:Say(getText("Moodles_nothing_happened"))
        return
    end

    PerkLevelup(character, Perks.Sprinting);
    PerkLevelup(character, Perks.Fitness);
end

-- OnDrink_GreedyHammer adds action to drink Permanent.GreedyHammer.
function OnDrink_GreedyHammer(food, character, percent)
    if percent < 1 then
        character:Say(getText("Moodles_nothing_happened"))
        return
    end

    PerkLevelup(character, Perks.Blunt);
end

-- OnDrink_DoubleGreedyHammer adds action to drink Permanent.DoubleGreedyHammer.
function OnDrink_DoubleGreedyHammer(food, character, percent)
    if percent < 1 then
        character:Say(getText("Moodles_nothing_happened"))
        return
    end

    PerkLevelup(character, Perks.Blunt);
    PerkLevelup(character, Perks.Strength);
end

-- OnDrink_GreedyAxe adds action to drink Permanent.GreedyAxe.
function OnDrink_GreedyAxe(food, character, percent)
    if percent < 1 then
        character:Say(getText("Moodles_nothing_happened"))
        return
    end

    PerkLevelup(character, Perks.Axe);
end

-- OnDrink_DoubleGreedyAxe adds action to drink Permanent.DoubleGreedyAxe.
function OnDrink_DoubleGreedyAxe(food, character, percent)
    if percent < 1 then
        character:Say(getText("Moodles_nothing_happened"))
        return
    end

    PerkLevelup(character, Perks.Axe);
    PerkLevelup(character, Perks.Strength);
end

-- OnDrink_StrayBullet adds action to drink Permanent.StrayBullet.
function OnDrink_StrayBullet(food, character, percent)
    if percent < 1 then
        character:Say(getText("Moodles_nothing_happened"))
        return
    end

    PerkLevelup(character, Perks.Aiming);
end

-- OnDrink_SlipperyFish adds action to drink Permanent.SlipperyFish.
-- Permanently increases Nimble by 1.
function OnDrink_SlipperyFish(food, character, percent)
    if percent < 1 then
        character:Say(getText("Moodles_nothing_happened"))
        return
    end

    PerkLevelup(character, Perks.Nimble);
end

-- OnDrink_SolidAdventurer adds action to drink Permanent.SolidAdventurer.
-- Permanently increases Maintenance by 1.
function OnDrink_SolidAdventurer(food, character, percent)
    if percent < 1 then
        character:Say(getText("Moodles_nothing_happened"))
        return
    end

    PerkLevelup(character, Perks.Maintenance);
end

-- OnDrink_SlenderDoe adds action to drink Permanent.SlenderDoe.
-- Sets characters weight to SlenderDoeSetWeight value.
function OnDrink_SlenderDoe(food, character, percent)
    if percent < 1 then
        character:Say(getText("Moodles_nothing_happened"))
        return
    end

    character:getNutrition():setWeight(SandboxVars.Permanent.SlenderDoeSetWeight);

    if character:HasTrait("Overweight") then
        character:getTraits():remove("Overweight");
    end

    if character:HasTrait("Underweight") then
        character:getTraits():remove("Underweight");
    end

    if character:HasTrait("Obese") then
        character:getTraits():remove("Obese");
    end

    if character:HasTrait("Very Underweight") then
        character:getTraits():remove("Very Underweight");
    end
end

-- OnDrink_NicotineOverdose adds action to drink Permanent.NicotineOverdose.
function OnDrink_NicotineOverdose(food, character, percent)
    if percent < 1 then
        character:Say(getText("Moodles_nothing_happened"))
        return
    end

    if character:HasTrait("Smoker") then
        character:getTraits():remove("Smoker");
        character:getStats():setStressFromCigarettes(0);
        character:setTimeSinceLastSmoke(0);
    end
end

-- OnDrink_GreedySalvation cures zombie virus.
function OnDrink_GreedySalvation(food, character, percent)
    if percent < 1 then
        character:Say(getText("Moodles_nothing_happened"))
        return
    end

    local bodyDamage = character:getBodyDamage();

    bodyDamage:setInfected(false);
    bodyDamage:setInfectionMortalityDuration(-1);
    bodyDamage:setInfectionTime(-1);
    bodyDamage:setInfectionLevel(0);

    local bodyParts = bodyDamage:getBodyParts();
    for i=bodyParts:size()-1, 0, -1  do
        local bodyPart = bodyParts:get(i);
        bodyPart:SetInfected(false);
    end
end

local pzversion = string.sub(getCore():getVersionNumber(), 1, 2)

-- TODO: Remove after release b42 on stable.
if pzversion == "41" then
    -- DrinkHastyHerring adds action to drink Permanent.HastyHerring.
    function DrinkHastyHerring(items, result, player)
        PerkLevelup(player, Perks.Sprinting);
    end

    -- DrinkDoubleHastyHerring adds action to drink Permanent.DoubleHastyHerring.
    function DrinkDoubleHastyHerring(items, result, player)
        PerkLevelup(player, Perks.Sprinting);
        PerkLevelup(player, Perks.Fitness);
    end

    -- DrinkGreedyHammer adds action to drink Permanent.GreedyHammer.
    function DrinkGreedyHammer(items, result, player)
        PerkLevelup(player, Perks.Blunt);
    end

    -- DrinkDoubleGreedyHammer adds action to drink Permanent.DoubleGreedyHammer.
    function DrinkDoubleGreedyHammer(items, result, player)
        PerkLevelup(player, Perks.Blunt);
        PerkLevelup(player, Perks.Strength);
    end

    -- DrinkGreedyAxe adds action to drink Permanent.GreedyAxe.
    function DrinkGreedyAxe(items, result, player)
        PerkLevelup(player, Perks.Axe);
    end

    -- DrinkDoubleGreedyAxe adds action to drink Permanent.DoubleGreedyAxe.
    function DrinkDoubleGreedyAxe(items, result, player)
        PerkLevelup(player, Perks.Axe);
        PerkLevelup(player, Perks.Strength);
    end

    -- DrinkStrayBullet adds action to drink Permanent.StrayBullet.
    function DrinkStrayBullet(items, result, player)
        PerkLevelup(player, Perks.Aiming);
    end

    -- DrinkSlipperyFish adds action to drink Permanent.SlipperyFish.
    -- Permanently increases Nimble by 1.
    function DrinkSlipperyFish(items, result, player)
        PerkLevelup(player, Perks.Nimble);
    end

    -- DrinkSolidAdventurer adds action to drink Permanent.SolidAdventurer.
    -- Permanently increases Maintenance by 1.
    function DrinkSolidAdventurer(items, result, player)
        PerkLevelup(player, Perks.Maintenance);
    end

    -- DrinkSlenderDoe adds action to drink Permanent.SlenderDoe.
    -- Sets characters weight to SlenderDoeSetWeight value.
    function DrinkSlenderDoe(items, result, player)
        player:getNutrition():setWeight(SandboxVars.Permanent.SlenderDoeSetWeight);

        if player:HasTrait("Overweight") then
            player:getTraits():remove("Overweight");
        end

        if player:HasTrait("Underweight") then
            player:getTraits():remove("Underweight");
        end

        if player:HasTrait("Obese") then
            player:getTraits():remove("Obese");
        end

        if player:HasTrait("Very Underweight") then
            player:getTraits():remove("Very Underweight");
        end
    end

    -- DrinkNicotineOverdose adds action to drink Permanent.NicotineOverdose.
    function DrinkNicotineOverdose(items, result, player)
        if player:HasTrait("Smoker") then
            player:getTraits():remove("Smoker");
            player:getStats():setStressFromCigarettes(0);
            player:setTimeSinceLastSmoke(0);
        end
    end
end
