# module Enumerable
    def my_each(arr)
      i = 0
      results = []
      while i < arr.length
        results << yield(arr[i])
        i += 1
      end
    end
  # end

  my_each([1, 2, 3, 4, 5]) {|x| puts x * 2}

  def my_each_with_index(arr)
    i = 0
    results = []
      while i < arr.length
        results << yield(arr[i],i)
        i += 1
      end
  end

  my_each_with_index([1, 2, 3, 4, 5]) {|val, index| puts "index: #{index} for val: #{val}"}