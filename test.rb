module Enumerable
  def my_each
    return to_enum unless block_given?
    arr = [Hash, Range].member?(self.class) ? to_a.flatten : self
    
    i = 0
    while i < arr.length
      yield(arr[i])
      i += 1
    end
    arr
  end


end

a = (1..5)
puts a.my_inject{|results, x| results * x }
puts a.inject{|results, x| results * x}
