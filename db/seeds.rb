fixtures_path = APP_ROOT.join('db', 'fixtures')

fixtures_path.each_child do |entry|
  deck_name = entry.basename('-*').to_s.capitalize

  deck = Deck.create(name: deck_name)

  front = nil
  back = nil

  File.new(entry).readlines.each_with_index do |line, i|
    if i % 3 == 0
      front = line.chomp
    elsif i % 3 == 1
      back = line.chomp
      Card.create(deck_id: deck.id, front: front, back: back)
    end
  end
end

