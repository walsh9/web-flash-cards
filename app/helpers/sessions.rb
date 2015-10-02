def set_card_order(deck_id)
  card_ids = Deck.find(deck_id).cards.pluck(:id)

  serialized_card_order = card_ids.join(' ')

  set_session(serialized_card_order)
end

def set_session(string)
  session[:card_order] = string
end

def get_card

  cur_cards = unserialize

  card = cur_cards.pop

  set_session(cur_cards.join(' '))

  card
end

def unserialize
  session[:card_order].split(' ')
end
