require 'singleton'

class Piece
  attr_reader :color, :value
  def initialize(position, color, board)
    @value = ' '
    @color = nil
    @position = position
    @board = board
  end

  def moves
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
  def moves(direction, max)
  end
end

module SteppingPiece
end

class Pawn < Piece
  include SteppingPiece
  def initialize(color, position)
    if color == :black
      @value = '♟'
    else
      @value = '♙'
    end
    @position = position
  end
end

class Rook < Piece
  include SlidingPiece
  def initialize(color, position)
    if color == :black
      @value = '♜'
    else
      @value = '♖'
    end
    @position = position
  end
end

class Knight < Piece
  include SteppingPiece
  def initialize(color, position)
    if color == :black
      @value = '♞'
    else
      @value = '♘'
    end
    @position = position
  end
end

class Bishop < Piece
  include SlidingPiece
  def initialize(color, position)
    if color == :black
      @value = '♝'
    else
      @value = '♗'
    end
    @position = position
  end
end

class Queen < Piece
  include SlidingPiece
  include SteppingPiece
  def initialize(color, position)
    if color == :black
      @value = '♛'
    else
      @value = '♕'
    end
    @position = position
  end
end

class King < Piece
  include SlidingPiece
  include SteppingPiece
  def initialize(color, position)
    if color == :black
      @value = '♚'
    else
      @value = '♔'
    end
    @position = position
  end
end
