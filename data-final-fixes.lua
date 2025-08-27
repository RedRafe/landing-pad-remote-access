--- Add trigger effect to Landing Pad
for _, entity in pairs(data.raw['cargo-landing-pad']) do
    local effects = entity.created_effect or {}

    table.insert(effects, {
        type = 'direct',
        action_delivery = {
            type = 'instant',
            source_effects = {
                type = 'script',
                effect_id = 'lpra_on_built'
            }
        }
    })

    entity.created_effect = effects
end
