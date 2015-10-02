get '/decks/:deck_id/cards' do
  set_card_order(params[:deck_id])
  card_id = get_card
  redirect "/decks/#{params[:deck_id]}/cards/#{card_id}"
end

get '/decks/:deck_id/cards/:id' do
  @card = Card.find(params[:id])
  erb :"cards/show-front"
end

