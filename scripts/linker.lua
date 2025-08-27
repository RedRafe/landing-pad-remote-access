local Linker = {}

-- == UTILS ===================================================================

local PAD_NAME = 'cargo-landing-pad'
local PROXY_NAME = 'lpra-proxy-container'

local function link_all_proxies(entity)
    for _, proxy in pairs(entity.surface.find_entities_filtered{
        force = entity.force,
        surface = entity.surface,
        name = PROXY_NAME,
    }) do
        proxy.proxy_target_entity = entity
        proxy.proxy_target_inventory = defines.inventory.cargo_landing_pad_main
    end
end

local function link_to_landing_pad(entity)
    for _, pad in pairs(entity.surface.find_entities_filtered{
        force = entity.force,
        surface = entity.surface,
        name = PAD_NAME,
    }) do
        entity.proxy_target_entity = pad
        entity.proxy_target_inventory = defines.inventory.cargo_landing_pad_main
    end
end

-- == EVENTS ==================================================================

local function on_built(event)
    if event.effect_id ~= 'lpra_on_built' then
        return
    end

    local entity = event.target_entity or event.cause_entity
    if not (entity and entity.valid) then
        return
    end

    if entity.type == PAD_NAME then
        link_all_proxies(entity)
    elseif entity.name == PROXY_NAME then
        link_to_landing_pad(entity)
    end
end

-- == APIs ====================================================================

Linker.events = {
    [defines.events.on_script_trigger_effect] = on_built,
}

return Linker