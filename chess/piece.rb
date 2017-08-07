class Piece
  attr_reader :color
  def initialize
    @value = 'Q'
    @color = :red
  end

  def value
    @value
  end
end

class DummyPiece < Piece
  def initialize
    @value = ' '
  end
end
