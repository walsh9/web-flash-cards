get '/decks/:deck_id/cards/:id' do
  @card = Card.find(params[:id])
  erb :"cards/show-front"
end

