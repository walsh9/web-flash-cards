def set_card_order(deck_id)
  card_count = Deck.find(deck_id).cards.count

  serialized_card_order = (1..card_count).to_a.shuffle.join(' ')

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
