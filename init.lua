-- Funktion zum Leeren des Inventars
local function clear_inventory(player)
    local player_inv = player:get_inventory("main")
    local size = player_inv:get_size("main")

    for i = 1, size do
        player_inv:set_stack("main", i, ItemStack(nil))
    end
end

-- Funktion zum Hinzufügen von Gegenständen zum Inventar
local function give_starter_kit(player)
    local player_inv = player:get_inventory()

    -- Überprüfe, ob der Spieler das Starter-Kit bereits erhalten hat
    local starter_kit_given = player:get_attribute("starter_kit_given")
    if not starter_kit_given then
        -- Leere das gesamte Inventar
        clear_inventory(player)

        -- Füge ein Stein-Schwert hinzu
        player_inv:add_item("main", "default:sword_stone")

        -- Füge eine Stein-Spitzhacke hinzu
        player_inv:add_item("main", "default:pick_stone")

        -- Füge 30 Cobblestones hinzu
        player_inv:add_item("main", "default:cobble 30")

        -- Setze den Statusindikator auf true, um anzuzeigen, dass das Starter-Kit bereits gegeben wurde
        player:set_attribute("starter_kit_given", "true")
    end
end

-- Funktion zum Entfernen von Gegenständen aus dem Inventar
local function remove_starter_kit(player)
    -- Leere das gesamte Inventar
    clear_inventory(player)

    -- Setze den Statusindikator auf nil, um anzuzeigen, dass das Starter-Kit entfernt wurde
    player:set_attribute("starter_kit_given", nil)
end

-- Event: Spieler tritt dem Server bei
minetest.register_on_joinplayer(function(player)
    -- Setze den Statusindikator auf nil, um das Starter-Kit jedes Mal neu zu geben
    player:set_attribute("starter_kit_given", nil)

    -- Gib dem Spieler das Starter-Kit
    give_starter_kit(player)
end)

-- Event: Spieler verlässt den Server
minetest.register_on_leaveplayer(function(player)
    -- Entferne die Gegenstände aus dem Inventar
    remove_starter_kit(player)
end)
