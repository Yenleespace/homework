class Board
  attr_accessor :cups

  def initialize(name1, name2)
    @name1 = name1
    @name2 = name2
    @cups = Array.new(14) {Array.new(0)}
    self.place_stones
  end

  def place_stones
    # helper method to #initialize every non-store cup with four stones each
    @cups.each_with_index do |ele, i|
      if i != 0 && i != 13
        4.times do 
          ele << :stone
        end
      end
    end
  end

  def valid_move?(start_pos)
    raise 'Invalid starting cup' if start_pos < 0 || start_pos > 13
    raise 'Starting cup is empty' if @cups[start_pos].empty?
  end

  def make_move(start_pos, current_player_name)
    @cups[start_pos] = []
    stones = @cups[start_pos]

    cup_index = start_pos
    until stones.empty?
      # self.place_stones
      cup_index += 1
      cup_index = 0 if cup_index > 13
      if cup_index == 6
        @cups[6] << stones.pop if current_player_name == @name1
      elsif cup_index == 13
        @cups[13] << stones.pop if current_player_name == @name2
      else
        @cups[cup_index] << stones.pop
      end     
    end
    render
    next_turn(cup_index)
  end

  def next_turn(ending_cup_idx)
    # helper method to determine whether #make_move returns :switch, :prompt, or ending_cup_idx
    if ending_cup_idx == 6 || ending_cup_idx == 13
      :prompt
    elsif @cups[ending_cup_idx].length > 1
      ending_cup_idx
    else
      :switch
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
    (0..5).all? { |idx| @cups[idx] == [] } || (6..13).all? { |idx| @cups[idx] == [] }
  end

  def winner
    if @cups[6].length > @cups[13].length
      return @name1
    elsif @cups[6].length < @cups[13].length
      return @name2
    else
      :draw
    end 
  end
end
