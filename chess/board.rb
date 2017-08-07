require_relative 'piece'
require_relative 'display'

class Board
  attr_accessor :grid
  def initialize
    @grid = Array.new(8) do
      Array.new(8) {[]}
    end
    @grid.each_with_index do |row, i|
      if i < 2 || i > 5
        row.each {|el| el << Piece.new()}
      end
    end
  end
  #
  # def [](pos)
  #   x, y = pos
  #   @grid[x][y]
  # end
  #
  # def []=(pos, value)
  #   x, y = pos
  #   @grid[x][y] = value
  # end

  def move_piece(start_pos, end_pos)
    a, b = start_pos
    x, y = end_pos
    if !is_board_pos(start_pos)
      raise "Your starting position is not on the board."
    elsif @grid[a][b].nil?
      raise "There is no piece in that spot!"
    elsif !is_board_pos(end_pos)
      raise "You can't move your piece off the board, dummy."
    end
    @grid[x][y] << @grid[a][b]
    @grid[a][b] = nil
  end

  def is_board_pos(pos)
    if pos.select {|x| x < 0 || x > 7}.empty?
      return true
    end
    false
  end
end
