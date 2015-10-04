def initialize_attempts
  session[:attempts] = "0"
end

def initialize_correct
  session[:correct] = "0"
end

def increase_attempts
  session[:attempts] = (session[:attempts].to_i + 1).to_s
end

def increase_attempts
  session[:attempts] = (session[:attempts].to_i + 1).to_s
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

def multi_choice?
  !!session[:mc]
end

def multiple_choice(card)
  Card.where.not(id: card.id).where(deck_id: card.deck_id).limit(3).order("RANDOM()").pluck(:back)
end

def selection(card)
  (multiple_choice(card) << card.back)
end

# def bot_selection(card) 
#   %w(A B C D).zip((multiple_choice(card.deck_id) << card.back).shuffle).map { |e| e.join(": ") }
# end

# def bot_correct_letter_choice(card, choices)
#   choices.select { |choice| choice.include?(card.back) }.flatten.first
# end