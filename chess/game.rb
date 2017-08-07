require_relative 'board'
require_relative 'display'
require_relative 'piece'
require_relative 'player'

class Game
  def initialize(player1, player2)
    @player1 = Player.new(player1)
    @player2 = Player.new(player2)
    @current_player = @player1
  end

  def play

  end

  private
  def swap_turn
    if @current_player == @player1
      @current_player = @player2
    else
      @current_player = @player1
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Who is playing white?"
  name1 = gets.chomp
  puts "Who is playing black?"
  name2 = gets.chomp
  Game.new.play(name1, name2)
end
