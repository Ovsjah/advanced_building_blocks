def bubble_sort(arr)
  arr.each_index do |i|
    (i+1..arr.length-1).each do |n|
      arr[i], arr[n] = arr[n], arr[i] if arr[i] > arr[n]
    end
  end
end

p bubble_sort([4,3,78,2,0,2])

def bubble_sort_by(arr, &block)
  arr.each_index do |i|
    (i+1..arr.length-1).each do |n|
      if block_given?
        arr[i], arr[n] = arr[n], arr[i] if block.call(arr[i], arr[n]) > 0
      else
        arr[i], arr[n] = arr[n], arr[i] if arr[i] > arr[n]
      end
    end
  end
end

p bubble_sort_by(['hack', 'them', 'all', 'to', 'death']) {|left, right| left.length - right.length}
