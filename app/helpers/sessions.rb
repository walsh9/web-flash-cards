def stats_list
  [:attempts, :correct, :correct_on_first_try, :skipped]
end

def initialize_stat(stat)
  session[stat] = "0" if stats_list.include?(stat)
end

def increment_stat(stat)
  if stats_list.include?(stat)
    session[stat] = (session[stat].to_i + 1).to_s
  end
end

def get_stats
  stats_list.map do |stat|
    [stat, session[stat].to_i]
  end.to_h
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

def add_retry_card(card_id)
  session[:card_order] = card_id + " " + session[:card_order]
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
  (multiple_choice(card) << card.back).shuffle
end

# def bot_selection(card)
#   %w(A B C D).zip((multiple_choice(card.deck_id) << card.back).shuffle).map { |e| e.join(": ") }
# end

# def bot_correct_letter_choice(card, choices)
#   choices.select { |choice| choice.include?(card.back) }.flatten.first
# end
