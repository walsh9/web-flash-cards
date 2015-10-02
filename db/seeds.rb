deck = Deck.create(name: 'Ruby')
front = nil
back = nil

File.new("db/fixtures/ruby-flashcards.txt").readlines.each_with_index do |line, i|
  if i % 3 == 0
    front = line.chomp
  elsif i % 3 == 1
    back = line.chomp
    Card.create(deck_id: deck.id, front: front, back: back)
  end 
end
