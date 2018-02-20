def select_sort(input)
  input.each_index do |idx|
    min_idx = idx
    (idx+1..input.size - 1).each do |next_idx|
      min_idx = next_idx if input[min_idx] > input[next_idx]
    end
    input[idx], input[min_idx] = input[min_idx], input[idx]
  end
end

p "SORTED RESULT => #{select_sort([rand(0..99), rand(0..99), rand(0..99), rand(0..99), rand(0..99), rand(0..99)])}"
