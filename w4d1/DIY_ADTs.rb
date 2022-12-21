#DIY ADTs

# Exercise 1 - Stack
class Stack # LIFO 

    attr_reader :underlying_array

    def initialize
      underlying_array = []
    end

    def push(el)
      underlying_array << el
    end

    def pop
      underlying_array.pop
    end

    def peek
      underlying_array.last
    end

    private 
    # Private can only be called within the class. 
    # Private can be called explicitly or implicitly, Except private setter methods, which needs to be called explicitly.  

end

  # Exercise 2 - Queue
class Queue # FIFO

    attr_reader :underlying_array

    def initialize
        underlying_array = []
    end

    def enqueue(el)
        underlying_array.push(el)
    end

    def dequeue
        underlying_array.shift 
    end

    def peek
        # underlying_array.unshift
        underlying_array.first
    end
end


  # Exercise 3
class Map

    attr_reader :underlying_array

    def initialize
        @underlying_array = []
    end

    def set(key, value)
        pair_index = underlying_array.index do |pair|
            pair[0] == key
        end

        if pair_index
            underlying_array[pair_index][1] = value
        else
            underlying_array.push([key, value])
        end
        value
    end

    def get(key)
        underlying_array.each do |pair|
        return pair[1] if pair[0] == key
        end
    end

    def delete(key)
        underlying_array.reject do |pair|
            get(key) == pair[1]
        end
    end

    def show
        deep_dup(underlying_array)
    end

    def deep_dup(arr)
        arr.map do |el|
            if el.is_a?(Array)
                deep_dup(el)
            else
                el
            end
        end
    end

end

a = Map.new
a.set('k1', 'v1')
a.set('k2', 'v2')
a.set('k3', 'v3')

p a.show