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

SMODS.Joker {
    key = "Usagi",
    loc_txt = {
        name = "Usagi",
        text = {
            'Every played {C:attention}Wheel of Fortune{}',
            'adds a {C:attention}Steel Polychrome',
            'King{} to the deck'
        }
    },
    atlas = "usagi",
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
        if context.using_consumeable and context.consumeable.config.center_key == "c_wheel_of_fortune" then 
            G.E_MANAGER:add_event(Event({
                func = function() 
                    local _card = create_playing_card({
                        front = pseudorandom_element(G.P_CARDS, pseudoseed('cert_fr')), 
                        center = G.P_CENTERS.c_base}, G.deck, nil, nil, {G.C.SECONDARY_SET.Enhanced})

                    _card:set_seal('Red', true)
                    _card:set_ability(G.P_CENTERS['m_steel'])
                    _card:set_edition({ polychrome = true}, true)
                    assert(SMODS.change_base(_card, nil, 'King'))

                    return true
                end}))
                playing_card_joker_effects({true})
                card_eval_status_text(card, 'extra', nil, nil, nil, {message = '+1 King!'})
                return true
            end
        end
    }
                --card_eval_status_text(self, 'extra',mmmmmmmm nil, nil, nil, {message = localize('k_plus_steel'), colour = G.C.SECONDARY_SET.Enhanced})
                --
                -- G.E_MANAGER:add_event(Event({
                --     func = function() 
                --         G.deck.config.card_limit = G.deck.config.card_limit + 1
                --         return true
                --     end}))
                --     draw_card(G.play,G.deck, 90,'up', nil)  

                --playing_card_joker_effects({true})
            -- G.E_MANAGER:add_event(Event({
            --     func = function() 
            --         local front = pseudorandom_element(G.P_CARDS, pseudoseed('marb_fr'))
            --         G.playing_card = (G.playing_card and G.playing_card + 1) or 1
            --         local card = Card(G.play.T.x + G.play.T.w/2, G.play.T.y, G.CARD_W, G.CARD_H, front, G.P_CENTERS.m_stone, {playing_card = G.playing_card})
            --         card:start_materialize({G.C.SECONDARY_SET.Enhanced})
            --         G.play:emplace(card)
            --         table.insert(G.playing_cards, card)
            --         return true
            --     end}))
            -- card_eval_status_text(context.blueprint_card or self, 'extra', nil, nil, nil, {message = localize('k_plus_stone'), colour = G.C.SECONDARY_SET.Enhanced})

            -- G.E_MANAGER:add_event(Event({
            --     func = function() 
            --         G.deck.config.card_limit = G.deck.config.card_limit + 1
            --         return true
            --     end}))
            --     draw_card(G.play,G.deck, 90,'up', nil)  

            -- playing_card_joker_effects({true})
        
            --{
            --     message = localize('k_upgrade_ex'),
            --     colour = G.C.CHIPS,
            --     card = card
            -- }


----------------------------------------------
------------MOD CODE END----------------------
    -- extra.chip_gain = joker itself gains chips
    -- extra.chip = joker gives mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm