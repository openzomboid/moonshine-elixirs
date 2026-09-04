--
-- Copyright (c) 2023 outdead.
-- Use of this source code is governed by the Apache 2.0 license
-- that can be found in the LICENSE file.
--

-- Fallback logger initialization if ConsoleLogger is not present in the global environment.
local logger = ConsoleLogger and ConsoleLogger.new() or {
    Debug = function(msg) print("ConsoleLogger DEBUG: " .. msg) end
}

local getPreviousXpLvl = function(perk, level)
    if level == 0 then
        return 0
    end
    level = level - 1
    local previousXp = perk:getXp1()
    if level >= 1 then
        previousXp = previousXp + perk:getXp2()
    end
    if level >= 2 then
        previousXp = previousXp + perk:getXp3()
    end
    if level >= 3 then
        previousXp = previousXp + perk:getXp4()
    end
    if level >= 4 then
        previousXp = previousXp + perk:getXp5()
    end
    if level >= 5 then
        previousXp = previousXp + perk:getXp6()
    end
    if level >= 6 then
        previousXp = previousXp + perk:getXp7()
    end
    if level >= 7 then
        previousXp = previousXp + perk:getXp8()
    end
    if level >= 8 then
        previousXp = previousXp + perk:getXp9()
    end
    if level >= 9 then
        previousXp = previousXp + perk:getXp10()
    end
    return previousXp
end

-- PerkLevelup creates level up for perk.
function PerkLevelup(character, perkType)
    logger.Debug("called levelup " .. tostring(perkType) .. " by moonshine drinking for user " .. character:getUsername())

    if isClient() then
        return
    end

    local perkLevel = character:getPerkLevel(perkType)

    if perkLevel < 10 then
        local xp = character:getXp()
        local xpTotal = xp:getXP(perkType)
        local xpInLevel = xpTotal - getPreviousXpLvl(perkType, perkLevel)
        if xpInLevel < 0 then
            xpInLevel = 0
        end

        character:LevelPerk(perkType, false)
        character:getXp():setXPToLevel(perkType, character:getPerkLevel(perkType))
        SyncXp(character)

         if SandboxVars.Moonshine.KeepExperience then
            logger.Debug("add xp: " .. tostring(xpInLevel))
            character:getXp():AddXPNoMultiplier(perkType, xpInLevel)
            SyncXp(character)
        end
    end
end

-- OnDrink_HastyHerring adds action to drink Moonshine.HastyHerring.
function OnDrink_HastyHerring(food, character, percent)
    if percent < 1 then
        character:Say(getText("Moodles_NothingHappened"))
        return
    end

    PerkLevelup(character, Perks.Sprinting)
end

-- OnDrink_DoubleHastyHerring adds action to drink Moonshine.DoubleHastyHerring.
function OnDrink_DoubleHastyHerring(food, character, percent)
    if percent < 1 then
        character:Say(getText("Moodles_NothingHappened"))
        return
    end

    PerkLevelup(character, Perks.Sprinting)
    PerkLevelup(character, Perks.Fitness)
end

-- OnDrink_GreedyHammer adds action to drink Moonshine.GreedyHammer.
function OnDrink_GreedyHammer(food, character, percent)
    if percent < 1 then
        character:Say(getText("Moodles_NothingHappened"))
        return
    end

    PerkLevelup(character, Perks.Blunt)
end

-- OnDrink_DoubleGreedyHammer adds action to drink Moonshine.DoubleGreedyHammer.
function OnDrink_DoubleGreedyHammer(food, character, percent)
    if percent < 1 then
        character:Say(getText("Moodles_NothingHappened"))
        return
    end

    PerkLevelup(character, Perks.Blunt)
    PerkLevelup(character, Perks.Strength)
end

-- OnDrink_GreedyAxe adds action to drink Moonshine.GreedyAxe.
function OnDrink_GreedyAxe(food, character, percent)
    if percent < 1 then
        character:Say(getText("Moodles_NothingHappened"))
        return
    end

    PerkLevelup(character, Perks.Axe)
end

-- OnDrink_DoubleGreedyAxe adds action to drink Moonshine.DoubleGreedyAxe.
function OnDrink_DoubleGreedyAxe(food, character, percent)
    if percent < 1 then
        character:Say(getText("Moodles_NothingHappened"))
        return
    end

    PerkLevelup(character, Perks.Axe)
    PerkLevelup(character, Perks.Strength)
end

-- OnDrink_StrayBullet adds action to drink Moonshine.StrayBullet.
function OnDrink_StrayBullet(food, character, percent)
    if percent < 1 then
        character:Say(getText("Moodles_NothingHappened"))
        return
    end

    PerkLevelup(character, Perks.Aiming)
end

-- OnDrink_SlipperyFish adds action to drink Moonshine.SlipperyFish.
-- Permanently increases Nimble by 1.
function OnDrink_SlipperyFish(food, character, percent)
    if percent < 1 then
        character:Say(getText("Moodles_NothingHappened"))
        return
    end

    PerkLevelup(character, Perks.Nimble)
end

-- OnDrink_SolidAdventurer adds action to drink Moonshine.SolidAdventurer.
-- Permanently increases Maintenance by 1.
function OnDrink_SolidAdventurer(food, character, percent)
    if percent < 1 then
        character:Say(getText("Moodles_NothingHappened"))
        return
    end

    PerkLevelup(character, Perks.Maintenance)
end

-- OnDrink_SlenderDoe adds action to drink Moonshine.SlenderDoe.
-- Sets characters weight to SlenderDoeSetWeight value.
function OnDrink_SlenderDoe(food, character, percent)
    if percent < 1 then
        character:Say(getText("Moodles_NothingHappened"))
        return
    end

    character:getNutrition():setWeight(SandboxVars.Moonshine.SlenderDoeSetWeight)

    if character:hasTrait(CharacterTrait.OVERWEIGHT) then
        character:getCharacterTraits():remove(CharacterTrait.OVERWEIGHT)
    end

    if character:hasTrait(CharacterTrait.UNDERWEIGHT) then
        character:getCharacterTraits():remove(CharacterTrait.UNDERWEIGHT)
    end

    if character:hasTrait(CharacterTrait.OBESE) then
        character:getCharacterTraits():remove(CharacterTrait.OBESE)
    end

    if character:hasTrait(CharacterTrait.VERY_UNDERWEIGHT) then
        character:getCharacterTraits():remove(CharacterTrait.VERY_UNDERWEIGHT)
    end
end

-- OnDrink_NicotineOverdose adds action to drink Moonshine.NicotineOverdose.
function OnDrink_NicotineOverdose(food, character, percent)
    if percent < 1 then
        character:Say(getText("Moodles_NothingHappened"))
        return
    end

    if character:hasTrait(CharacterTrait.SMOKER) then
        character:getCharacterTraits():remove(CharacterTrait.SMOKER)
        character:setTimeSinceLastSmoke(0)
    end
end

-- OnDrink_GreedySalvation cures zombie virus.
function OnDrink_GreedySalvation(food, character, percent)
    if percent < 1 then
        character:Say(getText("Moodles_NothingHappened"))
        return
    end

    local bodyDamage = character:getBodyDamage()

    bodyDamage:setInfected(false)
    bodyDamage:setInfectionMortalityDuration(-1)
    bodyDamage:setInfectionTime(-1)

    local bodyParts = bodyDamage:getBodyParts()
    for i=bodyParts:size()-1, 0, -1  do
        local bodyPart = bodyParts:get(i)
        bodyPart:SetInfected(false)
    end
end
