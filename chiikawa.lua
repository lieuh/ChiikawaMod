--- STEAMODDED HEADER
--- MOD_NAME: Chiikawa Mod
--- MOD_ID: CHIIKAWA_MOD
--- MOD_AUTHOR: [lieuh]
--- MOD_DESCRIPTION: Cute little things in a mod. 
--- PREFIX: chii
----------------------------------------------
------------MOD CODE -------------------------

SMODS.Atlas {
    key = "chiikawa",
    path = "chiikawa.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "usagi",
    path = "usagi.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "hachiware",
    path = "hachiware.png",
    px = 71,
    py = 95
}

SMODS.Joker {
    key = "Chiikawa",
    loc_txt = {
        name = "Chiikawa",
        text = {
            'First played {C:attention}2{}',
            'permanently {S:1.2}doubles{}',
            'its chips when scored'
        }
    },
    atlas = "chiikawa",
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
            if context.other_card:get_id() == 2 and G.GAME.current_round.hands_played == 0 then
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

SMODS.Joker {
    key = "Usagi",
    loc_txt = {
        name = "Usagi",
        text = {
            'Played {C:attention}Wheel of Fortune{}',
            'adds a {C:attention}Red Seal Steel',
            '{C:attention}King{} to the deck'
        }
    },
    atlas = "usagi",
    pos = {x=0, y=0},
    rarity = 2,
    cost = 7,
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
        if context.using_consumeable and context.consumeable.config.center_key == "c_wheel_of_fortune" then 
            G.E_MANAGER:add_event(Event({
                func = function() 
                    local _card = create_playing_card({
                        front = pseudorandom_element(G.P_CARDS, pseudoseed('cert_fr')), 
                        center = G.P_CENTERS.c_base}, G.deck, nil, nil, {G.C.SECONDARY_SET.Enhanced})

                    _card:set_seal('Red', true)
                    _card:set_ability(G.P_CENTERS['m_steel'])
                    --_card:set_edition({ polychrome = true}, true)
                    assert(SMODS.change_base(_card, nil, 'King'))

                    return true
                end}))
                playing_card_joker_effects({true})
                card_eval_status_text(card, 'extra', nil, nil, nil, {message = '+1 King!'})
                return true
            end
        end
    }


SMODS.Joker {
    key = "Hachiware",
    loc_txt = {
        name = "Hachiware",
        text = {
            'Gains {X:mult,C:white}X0.2{} Mult for each',
            '{C:attention}8{} in your {C:attention}full deck',
            '{C:inactive}(Currently {X:mult,C:white}X#1# {C:inactive} Mult)'
        }
    },
    atlas = "hachiware",
    pos = {x=0, y=0},
    rarity = 2,
    cost = 5,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = {
        extra = 0.2,
    },
    loc_vars = function(self, info_queue, cards)
        local eight_tally = 0
        if G.playing_cards then
            for _, playing_card in ipairs(G.playing_cards) do
                if playing_card:get_id() == 8 then eight_tally = eight_tally+1 end
            end
        end
        cards.ability.xmult = cards.ability.extra * eight_tally
        return {vars = { cards.ability.extra * eight_tally }}
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local eight_tally = 0
            for _, playing_card in ipairs(G.playing_cards) do
                if playing_card:get_id() == 8  then eight_tally = eight_tally + 1 end  
            end
            return {
                Xmult = card.ability.extra * eight_tally
            }
        end
    end
}

----------------------------------------------
------------MOD CODE END----------------------
    -- mmmmmmmmmm