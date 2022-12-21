arr = ['fish', 'fiiish', 'fiiiiish', 'fiiiish', 'fffish', 'ffiiiiisshh', 'fsh', 
    'fiiiissshhhhhh']

def sluggish_octopus(arr) # bubble sort O(n^2)
    sorted = false

    until sorted
        sorted = true
        (0...arr.length - 1).each do |i|
            if arr[i].length > arr[i + 1].length
                arr[i], arr[i + 1] = arr[i + 1], arr[i]
                sorted = false
            end
        end
    end
    arr.last # n^2 + 1 
end

# p sluggish_octopus(arr)

def dominant_octopus(arr, &prc) # merge sort O(n log n)

    prc||= Proc.new { |x, y| x <=> y}
    mid = arr.length / 2
    left = arr.take(mid)
    right = arr.drop(mid)
    
    merged = []
    until left.empty? || right.empty?
        case prc.call(left.first, right.first)
        when -1
            merged << left.shift
        when 1
            merged << right.shift
        when 0
            merged << right.shift
        end
    end
    merged.concat(left)
    merged.concat(right)
    merged.last
end

# p dominant_octopus(arr)

def clever_octopus(arr) # O(n)
    longest = arr[0]
    (0...arr.length).each do |i|
        longest = arr[i] if arr[i].length > longest.length
    end
    longest
end

# p clever_octopus(arr)

# Dancing Octopus

tiles_array = ["up", "right-up", "right", "right-down", "down", "left-down", 
    "left",  "left-up" ]

def slow_dance(tile, tiles_array) # O(n)
    tiles_array.each_with_index do |ele, i|
        return i if ele == tile
    end
end

# p slow_dance("up", tiles_array)
# p slow_dance("right-down", tiles_array)

new_tiles_data_structure = {"up"=>0, "right-up"=>1, "right"=>2, "right-down"=>3, "down"=>4, "left-down"=>5, 
    "left"=>6,  "left-up"=>7}


def fast_dance(tile, new_tiles_data_structure)
    new_tiles_data_structure[tile]
end

# p fast_dance("up", new_tiles_data_structure)
# p fast_dance("right-down", new_tiles_data_structure)
