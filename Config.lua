Config = {}

-- =========================================================
--  FRAMEWORK DETECTION
-- =========================================================
CreateThread(function()
    if GetResourceState('es_extended') == 'started' then
        Config.Framework = 'ESX'
        ESX = exports['es_extended']:getSharedObject()
        print("[Inventory] ESX Framework detected.")
    elseif GetResourceState('qb-core') == 'started' then
        Config.Framework = 'QBCore'
        QBCore = exports['qb-core']:GetCoreObject()
        print("[Inventory] QBCore Framework detected.")
    else
        print("[Inventory] ERROR: No compatible framework detected! (ESX or QBCore)")
    end
end)

-- =========================================================
--  INVENTORY SETTINGS
-- =========================================================
Config.MaxWeight = 25000        -- Default player carry weight (grams)
Config.DefaultSlots = 40        -- Default inventory slots
Config.HotbarKeys = {1, 2, 3, 4, 5}  -- Quick use keys

-- =========================================================
--  ITEM DEFINITIONS
-- =========================================================
-- Example items: You can replace these with your real items or sync with database
Config.Items = {
    ['water'] = {
        label = 'Water Bottle',
        weight = 500,
        type = 'item',
        description = 'A refreshing bottle of water.',
        stack = true,
        close = true,
        consume = 25
    },
    ['sandwich'] = {
        label = 'Sandwich',
        weight = 700,
        type = 'item',
        description = 'A simple ham sandwich.',
        stack = true,
        close = true,
        consume = 35
    },
    ['repairkit'] = {
        label = 'Repair Kit',
        weight = 1200,
        type = 'item',
        description = 'Use this to repair vehicles.',
        stack = true,
        close = true,
        consume = 0
    },
    ['bandage'] = {
        label = 'Bandage',
        weight = 200,
        type = 'item',
        description = 'Heals minor wounds.',
        stack = true,
        close = true,
        consume = 0
    }
}

-- =========================================================
--  USABLE ITEMS
-- =========================================================
-- Add your own logic for ESX or QBCore
CreateThread(function()
    Wait(1000) -- wait for framework load
    if Config.Framework == 'ESX' then
        ESX.RegisterUsableItem('water', function(source)
            local xPlayer = ESX.GetPlayerFromId(source)
            xPlayer.removeInventoryItem('water', 1)
            TriggerClientEvent('inventory:client:useItem', source, 'water')
        end)
        ESX.RegisterUsableItem('sandwich', function(source)
            local xPlayer = ESX.GetPlayerFromId(source)
            xPlayer.removeInventoryItem('sandwich', 1)
            TriggerClientEvent('inventory:client:useItem', source, 'sandwich')
        end)
    elseif Config.Framework == 'QBCore' then
        QBCore.Functions.CreateUseableItem('water', function(source)
            local Player = QBCore.Functions.GetPlayer(source)
            Player.Functions.RemoveItem('water', 1)
            TriggerClientEvent('inventory:client:useItem', source, 'water')
        end)
        QBCore.Functions.CreateUseableItem('sandwich', function(source)
            local Player = QBCore.Functions.GetPlayer(source)
            Player.Functions.RemoveItem('sandwich', 1)
            TriggerClientEvent('inventory:client:useItem', source, 'sandwich')
        end)
    end
end)

-- =========================================================
--  SHOPS
-- =========================================================
Config.Shops = {
    ['generalstore'] = {
        label = '24/7 Store',
        coords = vector3(25.7, -1347.3, 29.5),
        items = {
            { name = 'water', price = 5, amount = 50 },
            { name = 'sandwich', price = 10, amount = 50 },
            { name = 'bandage', price = 25, amount = 20 }
        }
    },
    ['mechanic'] = {
        label = 'Mechanic Supplies',
        coords = vector3(-345.8, -133.0, 39.0),
        items = {
            { name = 'repairkit', price = 250, amount = 10 }
        }
    }
}

-- =========================================================
--  STORAGES / STASHES
-- =========================================================
Config.Stashes = {
    ['policelocker'] = {
        label = 'Police Locker',
        coords = vector3(450.5, -993.3, 30.7),
        slots = 100,
        maxWeight = 100000,
        jobs = {'police'}
    },
    ['house_storage'] = {
        label = 'House Storage',
        coords = vector3(-810.2, 175.0, 76.7),
        slots = 50,
        maxWeight = 50000,
        ownerOnly = true
    }
}

-- =========================================================
--  KEYS / HOTBAR SETTINGS
-- =========================================================
Config.Keybinds = {
    OpenInventory = 'TAB', -- Default key to open inventory
    UseItem1 = '1',
    UseItem2 = '2',
    UseItem3 = '3',
    UseItem4 = '4',
    UseItem5 = '5'
}
