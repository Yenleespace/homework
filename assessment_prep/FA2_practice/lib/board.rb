require 'byebug'

class Board

    def self.build_stacks(num)
        @stacks = Array.new(num) { Array.new() }
    end

    # This Board#print method is given for free and does not need to be modified
    # It is used to make your game playable.
    def print
        @stacks.each { |stack| p stack }
    end

    def initialize(stacks, max)
        raise 'rows and cols must be >= 4' if stacks < 4 || max < 4
        @max_height = max
        @stacks = Board.build_stacks(stacks)
    end

    def max_height
        @max_height
    end

    def add(token, index)
        # debugger
        if @stacks[index].length < @max_height
            @stacks[index] << token
            return true
        else 
            return false
        end
    end

    def vertical_winner?(token)
        # debugger
        return true if @stacks.max.all?(token) && @stacks.max.length == @max_height 
        return false 
    end

    def horizontal_winner?(token)
        (0...@stacks.min.length).each do |i|
            count = 0
            @stacks.each do |row|
                count += 1 if row[i] == token
            end
            return true if count == @stacks.length
        end
        false
    end

    def winner?(token)
        horizontal_winner?(token) || vertical_winner?(token)
    end
end
