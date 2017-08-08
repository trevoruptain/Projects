require_relative './board'
require 'colorize'
require './cursor'

class Display
  attr_reader :cursor

  def initialize(board)
    @cursor = Cursor.new([0, 0], board)
    @grid = board.grid
  end

  def render
    puts "    A B C D E F G H"
    @grid.each_with_index do |row, i|
      print "#{8 - i}: "
      row.each_with_index do |p, j|
        if @cursor.cursor_pos == [i, j]
          print "#{p.first.value} ".colorize(:color => :white, :background => :blue)
        elsif ((i % 2) + j) % 2 == 0
          print "#{p.first.value} ".colorize(:color => :black, :background => :grey)
        else
          print "#{p.first.value} ".colorize(:color => :black, :background => :white)
        end
      end
      print "\n"
    end
  end
end
