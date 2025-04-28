--- STEAMODDED HEADER
--- MOD_NAME: Chiikawa Joker
--- MOD_ID: CHIIKAWA_JOKER
--- MOD_AUTHOR: [mack!]
--- MOD_DESCRIPTION: Cute little things as jokers. 
--- PREFIX: chii
----------------------------------------------
------------MOD CODE -------------------------

SMODS.Atlas {
    key = "Jokers",
    path = "chiikawa.png",
    px = 71,
    py = 95
}

SMODS.Joker {
    key = "Chiikawa",
    loc_txt = {
        name = "Chiikawa",
        text = {
            'Every played {C:attention}2{}',
            'permanently {S:1.2}doubles{}',
            'its chips when scored'
        }
    },
    atlas = "Jokers",
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

----------------------------------------------
------------MOD CODE END----------------------
    -- extra.chip_gain = joker itself gains chips
    -- extra.chip = joker gives chipsmmmmmmmmmmmmmmmmmmmmmmmmmmm