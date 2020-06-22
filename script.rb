module Enumerable
  def my_each
    return to_enum unless block_given?
    i = 0
    while i < length
      yield(self[i])
      i += 1
    end
    return self
  end

  def my_each_with_index
    return to_enum unless block_given?
    results = []
    my_each {|x| results << yield(x, index(x))}
  end

  def my_select
    return to_enum unless block_given?
    results = []
    my_each {|x| results << x if yield(x)}    
    return results
  end

  def my_all?
    check = true
    my_each {|x| check = false if !yield(x)}
    return check 
  end

  def my_any?
    check = false
    my_each {|x| check = true if yield(x)}
    return check  
  end

  def my_none? 
    check = true
    if block_given?      
      my_each {|x| check = false if yield(x)}     
    else       
      unless self.nil? || self.empty? 
        check = false
      end
    end
    return check    
  end

  def my_count
    return self.size unless block_given?
    j = 0
    my_each {|x| j += 1 if yield(x)} 
    return j    
  end
# Correct methods below
  def my_map(arr)
    i = 0
    results = []
    while i < arr.length
      results << yield(arr[i])
      i += 1
    end
  end

 def my_inject(*args)
  array = [9, 20, 11]
  symbol = args[1]
  result = args[0]
  
  if block_given? 
    i = 0
    if args[0].nil?
      result = array[0]
      while i < array.length - 1
      result = yield(result, array[i+1])
      i += 1
      end
    elsif args[0].integer? && args[1].nil?
      while i < array.length
      result = yield(result, array[i])
      i += 1
      end
    end
  else
    if args[1].nil?
      symbol = args[0]
      case symbol 
       when :+ || :-
        res = 0
       else 
        res = 1
       end      
      array.each { |ar| res = res.send(symbol, ar)}
      return res
    else
      array.each { |ar| result = result.send(symbol, ar)}
    end
  end
  return result
 end

 def multiply_els(arr)   
 end

 
end