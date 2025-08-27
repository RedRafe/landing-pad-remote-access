local sounds = require '__base__.prototypes.entity.sounds'
local item_sounds = require '__base__.prototypes.item_sounds'
local path = '__landing-pad-remote-access__/graphics/entity/item-extractor/'
local PROXY_NAME = 'lpra-proxy-container'

data:extend({
    --- Item
    {
        type = 'item',
        name = PROXY_NAME,
        icon = path .. 'item-extractor-icon.png',
        icon_size = 64,
        subgroup = 'space-platform',
        order = 'c[lpra-proxy-container]',
        inventory_move_sound = item_sounds.mechanical_large_inventory_move,
        pick_sound = item_sounds.mechanical_large_inventory_pickup,
        drop_sound = item_sounds.mechanical_large_inventory_move,
        place_result = PROXY_NAME,
        stack_size = 10,
        weight = 100 * kg,
    },
    --- Recipe
    {
        type = 'recipe',
        name = PROXY_NAME,
        enabled = false,
        ingredients = {
            { type = 'item', name = 'steel-plate', amount = 20 },
            { type = 'item', name = 'low-density-structure', amount = 20 },
            { type = 'item', name = 'processing-unit', amount = 5 },
        },
        energy_required = 10,
        results = { { type = 'item', name = PROXY_NAME, amount = 1 } },
    },
    --- Technology
    {
        type = 'technology',
        name = PROXY_NAME,
        icon = path .. 'item-extractor-icon-big.png',
        icon_size = 640,
        effects = {
            {
                type = 'unlock-recipe',
                recipe = PROXY_NAME,
            },
        },
        prerequisites = { 'rocket-silo' },
        research_trigger = {
            type = 'build-entity',
            entity = {
                name = 'cargo-landing-pad',
            },
        },
    },
    --- Entity
    {
        type = 'proxy-container',
        name = PROXY_NAME,
        icon = path .. 'item-extractor-icon.png',
        icon_size = 64,
        flags = { 'placeable-player', 'player-creation', 'no-automated-item-insertion', 'hide-alt-info' },
        minable = { mining_time = 1, result = PROXY_NAME },
        max_health = 1000,
        corpse = 'cargo-landing-pad-remnants',
        dying_explosion = 'rocket-silo-explosion',
        collision_box = { { -3.7, -3.7 }, { 3.7, 3.7 } },
        selection_box = { { -4, -4 }, { 4, 4 } },
        damaged_trigger_effect = {
            damage_type_filters = 'fire',
            entity_name = 'spark-explosion',
            offset_deviation = { { -0.5, -0.5 }, { 0.5, 0.5 } },
            offsets = { { 0, 1 } },
            type = 'create-entity',
        },
        open_sound = sounds.mech_large_open,
        close_sound = sounds.mech_large_close,
        impact_category = 'metal',
        resistances = {
            {
                percent = 90,
                type = 'fire',
            },
            {
                percent = 60,
                type = 'impact',
            },
        },
        created_effect = {
            type = 'direct',
            action_delivery = {
                type = 'instant',
                source_effects = {
                    type = 'script',
                    effect_id = 'lpra_on_built',
                },
            },
        },
        picture = {
            layers = {
                {
                    filename = path .. 'item-extractor-hr-animation-1.png',
                    height = 530,
                    width = 530,
                    scale = 0.5,
                    shift = { 0, -0.25 },
                },
                {
                    blend_mode = 'additive-soft',
                    filename = path .. 'item-extractor-ball.png',
                    height = 530,
                    width = 530,
                    scale = 0.5,
                    shift = { 0, -0.25 },
                    tint = { r = 189, g = 183, b = 107, a = 255 }, -- ( 189, 183, 107 ) { 144,238,144 }
                },
                {
                    draw_as_shadow = true,
                    filename = path .. 'item-extractor-hr-shadow.png',
                    height = 666,
                    width = 1000,
                    scale = 0.5,
                    shift = { 0, -0.25 },
                },
                {
                    blend_mode = 'additive',
                    draw_as_glow = true,
                    filename = path .. 'item-extractor-hr-emission-1.png',
                    height = 530,
                    width = 530,
                    scale = 0.5,
                    shift = { 0, -0.25 },
                    tint = { r = 189, g = 183, b = 107, a = 255 }, -- ( 189, 183, 107 ) { 144,238,144 }
                },
            },
        },
        circuit_connector = {
            points = {
                shadow = {
                    green = {
                        4.6875,
                        3.03125,
                    },
                    red = {
                        4.9375,
                        3,
                    },
                },
                wire = {
                    green = {
                        1.9375,
                        1.375,
                    },
                    red = {
                        2,
                        1.1875,
                    },
                },
            },
            sprites = {
                blue_led_light_offset = {
                    1.78125,
                    1.25,
                },
                connector_main = {
                    filename = '__base__/graphics/entity/circuit-connector/ccm-universal-04a-base-sequence.png',
                    height = 50,
                    priority = 'low',
                    scale = 0.5,
                    shift = {
                        1.875,
                        1.03125,
                    },
                    width = 52,
                    x = 52,
                    y = 150,
                },
                led_blue = {
                    draw_as_glow = true,
                    filename = '__base__/graphics/entity/circuit-connector/ccm-universal-04e-blue-LED-on-sequence.png',
                    height = 60,
                    priority = 'low',
                    scale = 0.5,
                    shift = {
                        1.875,
                        1,
                    },
                    width = 60,
                    x = 60,
                    y = 180,
                },
                led_blue_off = {
                    filename = '__base__/graphics/entity/circuit-connector/ccm-universal-04f-blue-LED-off-sequence.png',
                    height = 44,
                    priority = 'low',
                    scale = 0.5,
                    shift = {
                        1.875,
                        1,
                    },
                    width = 46,
                    x = 46,
                    y = 132,
                },
                led_green = {
                    draw_as_glow = true,
                    filename = '__base__/graphics/entity/circuit-connector/ccm-universal-04h-green-LED-sequence.png',
                    height = 46,
                    priority = 'low',
                    scale = 0.5,
                    shift = {
                        1.875,
                        1,
                    },
                    width = 48,
                    x = 48,
                    y = 138,
                },
                led_light = {
                    intensity = 0,
                    size = 0.9,
                },
                led_red = {
                    draw_as_glow = true,
                    filename = '__base__/graphics/entity/circuit-connector/ccm-universal-04i-red-LED-sequence.png',
                    height = 46,
                    priority = 'low',
                    scale = 0.5,
                    shift = {
                        1.875,
                        1,
                    },
                    width = 48,
                    x = 48,
                    y = 138,
                },
                red_green_led_light_offset = {
                    1.75,
                    1.15625,
                },
                wire_pins = {
                    filename = '__base__/graphics/entity/circuit-connector/ccm-universal-04c-wire-sequence.png',
                    height = 58,
                    priority = 'low',
                    scale = 0.5,
                    shift = {
                        1.875,
                        1.03125,
                    },
                    width = 62,
                    x = 62,
                    y = 174,
                },
            },
        },
        circuit_wire_max_distance = default_circuit_wire_max_distance,
    },
})
