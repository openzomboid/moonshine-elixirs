--
-- Copyright (c) 2025 outdead.
-- Use of this source code is governed by the Apache 2.0 license
-- that can be found in the LICENSE file.
--

-- MoonshineZombieLoot contains logic for zombies loot distributions.
MoonshineZombieLoot = {}

-- CheckChance checks chance for spawn loot in dead zombie.
function MoonshineZombieLoot.CheckChance(chance)
    local generated = ZombRand(99) + 1

    return generated <= chance
end

-- OnZombieDead spawns items in zombie loot on zombie dead.
function MoonshineZombieLoot.OnZombieDead(corpse)
    if SandboxVars.Permanent.ExclusiveRecipeInZombiesLootChance <= 0 then
        return
    end

    if corpse == nil then
        return
    end

    local character = getPlayer()

    local x = math.floor(corpse:getX());
    local y = math.floor(corpse:getY());
    local z = math.floor(corpse:getZ());
    local isSprinter = false;
    local zombieInventory = corpse:getInventory();

    for i = 0, getNumClassFields(corpse) - 1 do
        local field = getClassField(corpse, i)

        if tostring(field) == "public boolean zombie.characters.IsoZombie.bRunning" then
            isSprinter = getClassFieldVal(corpse, field);
        end
    end

    local roomName = ""
    local square = corpse:getSquare()
    if square then
        local room = square:getRoom()

        if room then
            local roomDef = room:getRoomDef()
            if roomDef then
                roomName = roomDef:getName()
            end
        end
    end

    if roomName == "bar" then
        local spawnAllowed = MoonshineZombieLoot.CheckChance(SandboxVars.Permanent.ExclusiveRecipeInZombiesLootChance)

        if spawnAllowed then
            zombieInventory:AddItems("Permanent.ExclusiveRecipe", 1);
        end
    end
end

Events.OnZombieDead.Add(MoonshineZombieLoot.OnZombieDead);
