get '/decks/:deck_id/cards/next' do
  if session[:card_order].empty?
    "<p>Redirect to end game route<p>"
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
