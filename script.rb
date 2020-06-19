module Enumerable
  def my_each(arr)
    i = 0
    results = []
    while i < arr.length
      results << yield(arr[i])
      i += 1
    end
  end
  
  def my_each_with_index(arr)
    i = 0
    results = []
    while i < arr.length
      results << yield(arr[i],i)
      i += 1
    end
  end

  def my_select(arr)
    i = 0
    results = []
      while i < arr.length
        if yield(arr[i])
          results << yield(arr[i])
        end
        i += 1
      end
  end
end