class HumanPlayer

  def initialize(name)
    @name = name
    @known_cards = {}
    @matched_cards = []
  end

  def prompt
    puts "\nPlayer #{@name}, enter two numbers respresenting a position in the format `row col` 0 2\n"
  end
  
  def get_input
    pos = gets.chomp.split.map(&:to_i)
  end

  def receive_revealed_card(pos, card)
    @known_cards[pos] = card.to_s
  end

  def receive_match(pos1, pos2)
    @matched_cards << pos1
    @matched_cards << pos2
    @known_cards.delete(pos1)
    @known_cards.delete(pos2)
  end
end