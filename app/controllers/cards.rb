get '/decks/:deck_id/cards/game-play' do
  @deck = Deck.find(params[:deck_id])
  erb :"cards/game-play"
end

post '/decks/:deck_id/cards/game-play' do
  params[:choice] == "mc" ? session[:mc] = "1" : session[:mc] = nil
  redirect "/decks/#{params[:deck_id]}/cards"
end

get '/decks/:deck_id/cards/next' do
  if session[:card_order].empty?
    @deck = : Deck.find(params[:deck_id])
    erb :"cards/game-end"
  else
    card_id = get_card
    redirect "/decks/#{params[:deck_id]}/cards/#{card_id}"
  end
end

get '/decks/:deck_id/cards' do
  set_card_order(params[:deck_id])

  initialize_attempts
  initialize_correct

  card_id = get_card
  redirect "/decks/#{params[:deck_id]}/cards/#{card_id}"
end

get '/decks/:deck_id/cards/:id' do
  @card = Card.find(params[:id])
  erb :"cards/show-front"
end

post '/decks/:deck_id/cards/:id' do
  increase_attempts

  @card = Card.find(params[:id])
  @guess = params[:guess]
  @correct = @card.back == @guess

  increase_correct if @correct

  erb :"cards/show-back"
end



