require_relative './piece'
require_relative './display'
require_relative './cursor'

class Board
  attr_accessor :grid

  def initialize
    @grid = Array.new(8) do
      Array.new(8) {[]}
    end
    @grid.each_with_index do |row, i|
      if i == 0
        place_row(:black, i)
      elsif i == 1
        row.each_with_index {|el, j| el << Pawn.new(:black, [i, j])}
      elsif i >= 2 && i <= 5
        row.each {|el| el << NilPiece.instance}
      elsif i == 6
        row.each_with_index {|el, j| el << Pawn.new(:white, [i, j])}
      elsif i == 7
        place_row(:white, i)
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
  def place_row(color, i)
    @grid[i].each_with_index do |el, j|
      case j
      when 0
        el << Rook.new(color, [i, j])
      when 1
        el << Knight.new(color, [i, j])
      when 2
        el << Bishop.new(color, [i, j])
      when 3
        el << Queen.new(color, [i, j])
      when 4
        el << King.new(color, [i, j])
      when 5
        el << Bishop.new(color, [i, j])
      when 6
        el << Knight.new(color, [i, j])
      when 7
        el << Rook.new(color, [i, j])
      end
    end
  end

  def move_piece(start_pos, end_pos)
    a, b = start_pos
    x, y = end_pos
    if !is_board_pos(start_pos)
      raise "Your starting position is not on the board."
    elsif @grid[a][b].is_a? DummyPiece
      raise "There is no piece in that spot!"
    elsif !is_board_pos(end_pos)
      raise "You can't move your piece off the board, dummy."
    end
    @grid[x][y] = @grid[a][b]
    @grid[a][b] = NilPiece.new()
  end

  def is_board_pos(pos)
    if pos.select {|x| x < 0 || x > 7}.empty?
      return true
    end
    false
  end

  def display_board
    system('clear')
    board = Display.new(self)
    10.times do
      board.render
      board.cursor.get_input
      system('clear')
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  board = Board.new
  board.display_board
end
