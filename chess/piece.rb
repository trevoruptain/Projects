require 'singleton'

class Piece
  attr_reader :color, :value
  def initialize(position, color, board)
    @value = ' '
    @color = nil
    @position = position
    @board = board
  end

  def update_pos(pos)
    @position = pos
  end
end

class NilPiece < Piece
  include Singleton
  attr_reader :value, :color
  def initialize
    @value = ' '
    @color = nil
  end
end

module SlidingPiece
  DIAGONALS = [
    [1, 1],
    [1, -1],
    [-1, 1],
    [-1, -1]
  ]
  def moves
    possible_moves = []
    directions = move_dirs
    column, row = @position

    if directions.include?(:horizontal)
      right_index = row + 1
      left_index = row - 1
      until !@board.grid[column][right_index].first.is_a?(NilPiece)
        break unless @board.is_board_pos([column, right_index + 1])
        possible_moves << [column, right_index]
        right_index += 1
      end
      until !@board.grid[column][left_index].first.is_a?(NilPiece)
        break unless @board.is_board_pos([column, left_index - 1])
        possible_moves << [column, left_index]
        left_index -= 1
      end
      possible_moves << [column, right_index]
      possible_moves << [column, left_index]
    end

    if directions.include?(:vertical)
      top_index = column + 1
      bottom_index = column - 1
      until !@board.grid[top_index][row].first.is_a?(NilPiece)
        break unless @board.is_board_pos([top_index + 1, row])
        possible_moves << [top_index, row]
        top_index += 1
      end
      until !@board.grid[bottom_index][row].first.is_a?(NilPiece)
        break unless @board.is_board_pos([bottom_index - 1, row])
        possible_moves << [bottom_index, row]
        bottom_index -= 1
      end
      possible_moves << [top_index, row]
      possible_moves << [bottom_index, row]
    end

    if directions.include?(:diagonal)
      
    end
    possible_moves.reject! do |pos|
      x, y = pos
      @board.grid[x][y].first.color == self.color
    end
    possible_moves
  end
end

module SteppingPiece
end

class Pawn < Piece
  include SteppingPiece
  attr_reader :value, :color
  def initialize(color, position, board)
    if color == :black
      @value = '♟'
    else
      @value = '♙'
    end
    @position = position
    @board = board
    @color = color
  end
end

class Rook < Piece
  include SlidingPiece
  attr_reader :value, :color
  def initialize(color, position, board)
    if color == :black
      @value = '♜'
    else
      @value = '♖'
    end
    @position = position
    @board = board
    @color = color
  end

  def move_dirs
    [:horizontal, :vertical]
  end

end

class Knight < Piece
  include SteppingPiece
  attr_reader :value, :color
  def initialize(color, position, board)
    if color == :black
      @value = '♞'
    else
      @value = '♘'
    end
    @position = position
    @board = board
    @color = color
  end
end

class Bishop < Piece
  include SlidingPiece
  attr_reader :value, :color
  def initialize(color, position, board)
    if color == :black
      @value = '♝'
    else
      @value = '♗'
    end
    @position = position
    @board = board
    @color = color
  end

  def move_dirs
    [:diagonal]
  end
end

class Queen < Piece
  include SlidingPiece
  attr_reader :value, :color
  def initialize(color, position, board)
    if color == :black
      @value = '♛'
    else
      @value = '♕'
    end
    @position = position
    @board = board
    @color = color
  end

  def move_dirs
    [:horizontal, :vertical, :diagonal]
  end
end

class King < Piece
  include SteppingPiece
  attr_reader :value, :color
  def initialize(color, position, board)
    if color == :black
      @value = '♚'
    else
      @value = '♔'
    end
    @position = position
    @board = board
    @color = color
  end
end
