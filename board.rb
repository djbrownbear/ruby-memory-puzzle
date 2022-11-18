require_relative "card"
require "byebug"

class Board

  attr_reader :size
  
  LENGTH = 4
  ALPHABET = ("a".."z").to_a

  def self.print_grid(grid)
    displayed_grid = []

    grid.each do |row|
      displayed_row = []

      row.each do |ele|
        if ele.display
          displayed_row << ele.to_s
        else
          displayed_row << "_"
        end
      end
      displayed_grid << displayed_row
    end

    displayed_grid.each do |row|
      puts row.join(" ")
    end
  end

  def initialize(n=4)
    @grid = Array.new(n) { Array.new(n) }
    @size = n * n
  end

  def populate
    chars = ALPHABET.sample(@size/2) * 2
    chars.shuffle!

    @grid.map! do |row|
      row.map! do |ele|
        Card.new(chars.pop)
      end
    end
  end

  def render
    Board.print_grid(@grid)
  end

  def won?
    @grid.flatten.all? { |card| !card.face_down }
  end

  def reveal(guessed_pos)
    row, col = guessed_pos
    guessed_card = @grid[row][col]
    
    if guessed_card.face_down
      guessed_card.reveal
    end
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

end