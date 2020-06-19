module Enumerable
  def my_each(arr)
    i = 0
    while i < arr.length
      yield(arr[i])
      i += 1
    end
    return arr
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

  def my_all?(arr)
    i = 0
    check = true
      while i < arr.length
        if !yield(arr[i])
          check = false
        end
        i += 1
      end
      return check
  end

  def my_any?(arr)
    i = 0
    check = false
      while i < arr.length
        if yield(arr[i])
          check = true
        end
        i += 1
      end
      return check
  end

  def my_none?(arr)
    i = 0
    check = true
      while i < arr.length
        if yield(arr[i])
          check = false
        end
        i += 1
      end
      return check
  end

  def my_count(arr)
    i = 0
    j = 0
    if block_given?
      while i < arr.length
        if yield(arr[i])
          j += 1
        end
        i += 1
      end
      return j
    else 
      return arr.length
    end
  end

  def my_map(arr)
    i = 0
    results = []
    while i < arr.length
      results << yield(arr[i])
      i += 1
    end
  end
end