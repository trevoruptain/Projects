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
        row.each_with_index {|el, j| el << Pawn.new(:black, [i, j], self)}
      elsif i >= 2 && i <= 5
        row.each {|el| el << NilPiece.instance}
      elsif i == 6
        row.each_with_index {|el, j| el << Pawn.new(:white, [i, j], self)}
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
        el << Rook.new(color, [i, j], self)
      when 1
        el << Knight.new(color, [i, j], self)
      when 2
        el << Bishop.new(color, [i, j], self)
      when 3
        el << Queen.new(color, [i, j], self)
      when 4
        el << King.new(color, [i, j], self)
      when 5
        el << Bishop.new(color, [i, j], self)
      when 6
        el << Knight.new(color, [i, j], self)
      when 7
        el << Rook.new(color, [i, j], self)
      end
    end
  end

  def move_piece(start_pos, end_pos)
    a, b = start_pos
    x, y = end_pos
    if !is_board_pos(start_pos)
      puts "Your starting position is not on the board."
      sleep(2)
      return
    elsif @grid[a][b].first.is_a? NilPiece
      puts "There is no piece in that starting position."
      sleep(2)
      return
    elsif !is_board_pos(end_pos)
      puts "You can't move your piece off the board, dummy."
      sleep(2)
      return
    elsif start_pos == end_pos
      puts "Nice try, but that's not really a move, is it?"
      sleep(2)
      return
    elsif !@grid[a][b].first.moves.include?([x, y])
      puts "Sorry buddy, you can't move there."
      sleep(1)
      return
    elsif x < 0 || y < 0
      puts "Invalid ending position"
      sleep(1)
      return
    end
    @grid[x][y] = @grid[a][b]
    @grid[a][b] = [NilPiece.instance]
    @grid[x][y].first.update_pos([x, y])
  end

  def is_board_pos(pos)
    if pos.select {|x| x < 0 || x > 7}.empty?
      return true
    end
    false
  end

  def play
    system('clear')
    board = Display.new(self)
    commands = []
    loop do
      board.render
      command = board.cursor.get_input
      commands << command.dup unless command.nil?
      if commands.length == 2
        move_piece(commands[0], commands[1])
        commands = []
      end

      system('clear')
    end
  end

  def in_check?(color)
    if color == :black
      opponent_color = :white
    else
      opponent_color = :black
    end

    opponent_possible_moves = []
    king_pos = []

    @grid.each_with_index do |row, i|
      row.each_with_index do |piece, j|
        if piece.first.class == King && piece.first.color == color
          king_pos << i << j
        end
        if piece.first.color == opponent_color
          puts piece.first.moves
        end
      end
    end

    opponent_possible_moves << 1
  end
end

if __FILE__ == $PROGRAM_NAME
  board = Board.new
  board.play
end
