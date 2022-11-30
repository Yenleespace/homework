require 'byebug'

class Simon
  COLORS = %w(red blue green yellow)

  attr_accessor :sequence_length, :game_over, :seq

  def initialize
    @seq = []
    @sequence_length = 1
    @game_over = false
  end

  def play
    until game_over
      take_turn
    end

    game_over_message
    reset_game
  end

  def take_turn
    show_sequence
    require_sequence
    if @game_over == false
      round_success_message
      @sequence_length += 1
    end
  end

  def show_sequence
    add_random_color
    @seq.each do |color|
      puts color
    end

  end

  def require_sequence
    puts "Enter the sequence"
    new_seq = []

    @sequence_length.times do 
      input = gets.chomp
      new_seq << input
    end

    @game_over == true if new_seq != @seq
  end

  def add_random_color
    # debugger
    # [5] pry(main)> rand(0..3)
    # => 1
    # [6] pry(main)> rand(0...3)
    # => 1
    # [7] pry(main)> rand(0..3)
    # => 0
    # [8] pry(main)> r=rand(0..3)
    # => 0
    # [9] pry(main)> COLORS[r]
    # => "red"
    i = rand(0...COLORS.length)
    @seq << COLORS[i]
    @sequence_length = 1
  end

  def round_success_message
    puts "The round success"
  end

  def game_over_message
    puts "Game Over"
  end

  def reset_game
    @sequence_length = 1
    @game_over = false
    @seq = []
  end
end
