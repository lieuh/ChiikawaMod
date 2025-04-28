--- STEAMODDED HEADER
--- MOD_NAME: Chiikawa Joker
--- MOD_ID: CHIIKAWA_JOKER
--- MOD_AUTHOR: [mack!]
--- MOD_DESCRIPTION: Cute little things as jokers. 
--- PREFIX: chii
----------------------------------------------
------------MOD CODE -------------------------

local jokers = {
    chiikawa = {
        name = "Chiikawa",
        text = {
            'Every played {C:attention}2{}',
            'permanently {S:1.2}doubles{}',
            'its chips when scored'
        },
        atlas = nil,
        pos = {x=0, y=0},
        rarity = 2,
        cost = 5,
        unlocked = true,
        discovered = true,
        blueprint_compat = true,
        eternal_compat = true,
        perishable_compat = true,
        config = {
            extra = 2
        },
        loc_vars = function(self, info_queue, cards)
            return {vars = { cards.ability.extra }}
        end,
        calculate = function(self, card, context)
            if context.individual and context.cardarea == G.play then
                if context.other_card:get_id() == 2 then
                    if context.other_card.ability.perma_bonus <= 0 then context.other_card.ability.perma_bonus = 1 end
                    context.other_card.ability.perma_bonus = context.other_card.ability.perma_bonus * card.ability.extra
                    return {
                        message = localize('k_upgrade_ex'),
                        colour = G.C.CHIPS,
                        card = context.other_card
                    }
                end
            end
        end
    },
    usagi = {
        name = "Usagi",
        text = {
            'Every played {C:attention}2{}',
            'permanently {S:1.2}doubles{}',
            'fat farming genius'
        },
        atlas = nil,
        pos = {x=0, y=0},
        rarity = 2,
        cost = 5,
        unlocked = true,
        discovered = true,
        blueprint_compat = true,
        eternal_compat = true,
        perishable_compat = true,
        config = {
            extra = 1
        },
        loc_vars = function(self, info_queue, cards)
            return {vars = { cards.ability.extra }}
        end,
        G.E_MANAGER:add_event(Event({
            func = function ()
                local _card = create_playing_card({
                    front = pseudorandom_element(G.P_CARDS, pseudoseed('cert_fr'))
                })
                G.GAME.blind:debuff_card(_card)
                G.hand:sort()
                if context.blueprint_card then context.blueprint_card:juice_up() else self.juice_up() end
                return true
            end
        })),
        calculate = function(self, card, context)
            if context.individual and context.cardarea == G.play then
                if context.other_card:get_id() == 2 then
                    if context.other_card.ability.perma_bonus <= 0 then context.other_card.ability.perma_bonus = 1 end
                    context.other_card.ability.perma_bonus = context.other_card.ability.perma_bonus * card.ability.extra
                    sendTraceMessage(tostring(context.other_card.ability.perma_bonus),"Chiikawa Joker")
                    return {
                        message = localize('k_upgrade_ex'),
                        colour = G.C.CHIPS,
                        card = context.other_card
                    }
                end
            end
        end
    }
}

function SMODS.INIT.CHIIKAWA_JOKER()
    for k, v in pairs(jokers) do
        local joker = SMODS.Joker:new(v.name, k, v.config, v.pos, { name = v.name, text = v.text }, v.rarity, v.cost,
            v.unlocked, v.discovered, v.blueprint_compat, v.eternal_compat, v.effect, v.atlas, v.soul_pos)
        joker:register()

        if not v.atlas then
            -- Register the individual sprite
            SMODS.Sprite:new("j_" .. k, SMODS.findModByID("CHIIKAWA_JOKER").path, "j_" .. k .. ".png", 71, 95, "asset_atli")
                :register()
            SMODS.Jokers[joker.slug].atlas = "j_" .. k
        end

        SMODS.Jokers[joker.slug].calculate = v.calculate
        SMODS.Jokers[joker.slug].loc_def = v.loc_def
    end
end

----------------------------------------------
------------MOD CODE END----------------------
    -- extra.chip_gain = joker itself gains chips
    -- extra.chip = joker gives chips
    --mmmmmmmm