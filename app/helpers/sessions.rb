def initialize_attempts
  session[:attempts] = "0"
end

def initialize_correct
  session[:correct] = "0"
end

def increase_attempts
  session[:attempts] = (session[:attempts].to_i + 1).to_s
end

def increase_correct
  session[:correct] = (session[:correct].to_i + 1).to_s
end

def set_card_order(deck_id)
  card_ids = Deck.find(deck_id).cards.pluck(:id)

  card_ids.shuffle!

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
