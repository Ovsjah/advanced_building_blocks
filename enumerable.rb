module Enumerable
  def my_each
    i = 0
    if self.class == Hash
      arr = self.to_a
      while i < self.size
        yield(arr[i][0], arr[i][1])
        i+=1
      end
    end
    
    while i < self.length
      yield(self[i])
      i+=1
    end
    self
  end
  
  def my_each_with_index
    i = 0
    
    if self.class == Hash
      arr = self.to_a
      while i < self.size
        yield(arr[i], i)
        i+=1
      end
    end
    
    while i < self.length
      yield(self[i], i)
      i+=1
    end
    self
  end
  
  def my_select
    i = 0
    klass = self.class
    object = klass.new
    
    if self.is_a? Hash
      arr = self.to_a
      while i < self.size
        if yield(arr[i][0], arr[i][1])
          object.merge!(arr[i][0] => arr[i][1])
        end
        i += 1
      end
    end
    
    while i < self.size
      if yield(self[i])
        object << self[i]
      end
      i += 1
    end
    object
  end
  
  def my_all?
    i = 0
    flag = true
    
    if self.is_a? Hash
      arr = self.to_a
      while i < self.size && flag
        flag = false if yield(arr[i][0], arr[i][1]) == false
        i += 1
      end
    end
    
    while i < self.size && flag
      flag = false if yield(self[i]) == false
      i += 1
    end
    flag
  end
  
  def my_any?
    i = 0
    flag = false
    
    if self.is_a? Hash
      arr = self.to_a
      while i < self.size && !flag
        flag = true if yield(arr[i][0], arr[i][1]) == true
        i+=1
      end
    end
    
    while i < self.size && !flag
      flag = true if yield(self[i]) == true
      i+=1
    end
    flag
  end
  
  def my_none?
    i = 0
    flag = true
    
    if self.is_a? Hash
      arr = self.to_a
      while i < self.size && flag
        flag = false if yield(arr[i][0], arr[i][1]) == true
        i+=1
      end
    end
    
    while i < self.size && flag
      flag = false if yield(self[i]) == true
      i+=1
    end
    flag
  end
  
  def my_count(n=nil, &block)
    i = 0
    res = 0
    
    if block_given?
      while i < self.size
        if block.call(self[i])
          res += 1
        end
        i +=1
      end
    else
      while i < self.size
        if self[i] == n
          res += 1
        end
        i += 1
      end
    end
    res
  end
   
  def my_map
    i = 0
    object = Array.new
    
    if self.is_a? Hash
      arr = self.to_a
      while i < self.size
        object << yield(arr[i][0], arr[i][1])
        i += 1
      end
    end
    
    while i < self.size
      object << yield(self[i])
      i += 1
    end
    object
  end
  
  def my_inject(val=0)
    i = 0
    
    if self.is_a? Hash
      arr = self.to_a
      while i < self.size
        val = yield(val, arr[i])
        i += 1
      end
    end
    
    while i < self.size
      val = yield(val, self[i])
      i += 1
    end
    val
  end
  
  def self.multiply_els(arr)
    arr.my_inject(1) {|s, v| s * v}
  end   
    
end



[1, 2, 3, 4].my_each {|n| p n}
{a: 1, b: 0, c: -3, d: 5}.my_each {|k, v| p "#{k}, #{v}"}
[1, 2, 3, 4].my_each_with_index {|n, i| p "#{n}, #{i}"}
{a: 1, b: 0, c: -3, d: 5}.my_each_with_index {|n, i| p "#{n}, #{i}"}
p ({a: 1, b: 0, c: -3, d: 5}).my_select {|k, v| v > 0}
p [1, 0, -3, 5].my_select {|v| v > 0}
p ({a: 1, b: -2, c: 3, d: 5}).my_all? {|k, v| v <= 0}
p [1, 0, 3, 5].my_all? {|n| n >= 0}
p ({a: 1, b: 0, c: -3, d: 5}).my_any? {|k, v| k == :f}
p [1, 2, 3, -3].my_any? {|i| i < 0}
p ({a: 1, b: 0, c: -3, d: 5}).my_none? {|k, v| k == :f}
p [1, 2, 3, -3].my_none? {|i| i > 0}
p [1, 2, 4, 2].my_count(2)
p ({a: 1, b: 0, c: -3, d: 5}).my_map {|k, v|  k.to_s }
p [2, 3, -3, 5].my_map {|v| v**2}
p ({a: 1, b: 0, c: -3, d: 5}).my_inject(5) {|o, v| o + v[1]}
p [-2, -5, -3, -9].my_inject(Hash.new) {|hsh, i|  hsh.merge(i => i.abs)}
p Enumerable.multiply_els([2,4,5])
sym_to_s = Proc.new {|k, v| k.to_s}
p ({a: 1, b: 0, c: -3, d: 5}).my_map(&sym_to_s)
p ({a: 1, b: 0, c: -3, d: 5}).my_map {|k, v|  k.to_s }
