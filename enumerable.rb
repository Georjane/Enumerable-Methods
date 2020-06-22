  

def my_inject(*args)
  array = [9, 20, 11]
  symbol = args[1]
  result = args[0]
  res = array[0]
  
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
      array.each { |ar| res = res.send(symbol, ar)}
      return res
    else
      array.each { |ar| result = result.send(symbol, ar)}
    end
  end
  return result
end

puts my_inject(:*)
puts my_inject(1,:*)
puts my_inject(1) {|result,a| result * a }
puts my_inject() {|result,a| result * a}

