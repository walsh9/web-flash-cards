get '/decks/:deck_id/cards/game-play' do
  @deck = Deck.find(params[:deck_id])
  erb :"cards/game-play"
end

post '/decks/:deck_id/cards/game-play' do
  params[:choice] == "mc" ? session[:mc] = "1" : session[:mc] = nil
  session[:retry_cards] = ""
  redirect "/decks/#{params[:deck_id]}/cards"
end

get '/decks/:deck_id/cards/next' do
  if session[:card_order].empty?
    @deck = Deck.find(params[:deck_id])
    session[:card_order] = session[:retry_cards]
    session[:retry_cards] = ""
    erb :"cards/game-end"
  else
    card_id = get_card
    redirect "/decks/#{params[:deck_id]}/cards/#{card_id}"
  end
end

get '/decks/:deck_id/cards/:id/skip' do
  skip_card(params[:id])
  redirect "/decks/#{params[:deck_id]}/cards/next"
end

get '/decks/:deck_id/cards' do
  set_card_order(params[:deck_id])

  initialize_stat(:attempts)
  initialize_stat(:correct)
  initialize_stat(:correct_on_first_try)

  card_id = get_card
  redirect "/decks/#{params[:deck_id]}/cards/#{card_id}"
end

get '/decks/:deck_id/cards/:id' do
  @card = Card.find(params[:id])
  erb :"cards/show-front"
end

post '/decks/:deck_id/cards/:id' do
  increment_stat(:attempts)

  @card = Card.find(params[:id])
  @guess = params[:guess]
  @correct = @card.back == @guess

  if @correct
    increment_stat(:correct)
    increment_stat(:correct_on_first_try) if get_stats[:attempts] <= @card.deck.cards.count
  else
    add_retry_card(params[:id])
  end

  erb :"cards/show-back"
end



