class Board
  attr_accessor :cups

  def initialize(name1, name2)
    @cups = Array.new(14) { Array.new }
    @player1, @player2 = name1, name2
    place_stones
  end

  def place_stones
    # helper method to #initialize every non-store cup with four stones each
    @cups.each_with_index do |ele, i|
      4.times { ele << :stone } unless i == 6 || i == 13
    end
  end

  def valid_move?(start_pos)
    if start_pos < 0 || start_pos > 12 || @cups[start_pos].empty?
      raise 'Invalid starting cup'
    end
    true
  end

  def make_move(start_pos, current_player_name)
    stones = @cups[start_pos]
    @cups[start_pos] = []
    idx = start_pos

    until stones.empty?
      idx += 1
      idx = 0 if idx > 13
      if @player1 == current_player_name
        @cups[idx] << stones.shift unless idx == 13
      elsif @player2 == current_player_name
        @cups[idx] << stones.shift unless idx == 6
      end
    end
    render
    next_turn(idx)
  end

  def next_turn(ending_cup_idx)
    if ending_cup_idx == 6 || ending_cup_idx == 13
      :prompt
    elsif @cups[ending_cup_idx].count == 1
      :switch
    else
      ending_cup_idx
    end
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
    @cups[0..5].all? {|ele| ele.empty?} ||
    @cups[7..12].all? {|ele| ele.empty?}
  end

  def winner
    player1_stones = @cups[6].count
    player2_stones = @cups[13].count
    if player1_stones == player2_stones
      return :draw
    else
      player1_stones > player2_stones ? @player1 : @player2
    end
  end
end
