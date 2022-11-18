require_relative "board"
require_relative "human_player"
require_relative "ai_player"
require "byebug"

class Game

  attr_reader :prev_guess, :board

  def initialize(player)
    @board = Board.new
    @prev_guess = nil
    @player = player.map do |name, is_computer|  
      if is_computer
        ComputerPlayer.new(name)
      else
        HumanPlayer.new(name)
      end
    end
  end

  def game_over?
    @board.won?
  end

  def is_match?(guessed_pos, prev_guess)
    @board[guessed_pos] == prev_guess
  end

  def flip(card)
    card.hide
  end

  def make_guess(guessed_pos)
    @board.reveal(guessed_pos)
    @player.first.receive_revealed_card(guessed_pos, @board[guessed_pos])
    if @prev_guess
      if !self.is_match?(guessed_pos, @prev_guess)
        display
        sleep(2)
        flip(@board[guessed_pos])
        flip(@prev_guess)
        @prev_guess = nil
      end
      @prev_guess = nil
    else
      @prev_guess = @board[guessed_pos]
    end
  end

  def take_turn
      @player.first.prompt
      self.make_guess(@player.first.get_input)
    end
    
    def display
      system("clear")
      @board.render
      puts @player.first.known_cards
    end
    
  def play
    @board.populate
    until game_over?
      display
      take_turn
    end
  end

end