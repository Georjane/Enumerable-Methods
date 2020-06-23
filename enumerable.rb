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

  def my_each_with_index
    return to_enum unless block_given?

    arr = [Hash, Range].member?(self.class) ? to_a.flatten : self
    i = 0
    while i < arr.length
      yield(arr[i], i) if arr[i].is_a? Integer
      i += 1
    end
    arr
  end

  def my_select
    return to_enum unless block_given?

    arr = [Hash, Range].member?(self.class) ? to_a.flatten : self
    results = []
    arr.my_each { |x| results << x if yield(x) }
    results
  end

  def my_all?(test = nil)
    check = true
    if block_given?
      my_each { |x| check = false unless yield(x) }
      check
    elsif test.is_a? Class
      my_each { |x| check = false if x.class != test }
    elsif test.is_a? Regexp
      my_each { |x| check = false unless test.match(x) }
    else
      my_each { |x| check = false if x.nil? || x == false }
    end
    check
  end

  def my_any?(test = nil)
    check = false
    if block_given?
      my_each { |x| check = true if yield(x) }
    elsif test.is_a? Class
      my_each { |x| check = true if x.class == test }
    elsif test.is_a? Regexp
      my_each { |x| check = true if test.match(x) }
    else
      test_array = [true, [], {}]
      my_each { |x| check = true if test_array.include?(x) }
    end
    check
  end

  def my_none?(test = nil)
    check = true
    if block_given?
      my_each { |x| check = false if yield(x) }
    elsif test.is_a? Class
      my_each { |x| check = false if x.class == test }
    elsif test.is_a? Regexp
      my_each { |x| check = false if test.match(x) }
    else
      my_each { |x| check = false if x == true }
    end
    check
  end

  def my_count
    return size unless block_given?

    j = 0
    my_each { |x| j += 1 if yield(x) }
    j
  end

  def my_map(proc = nil)
    arr = is_a?(Range) ? to_a : self
    results = []
    if block_given?
      arr.my_each { |x| results << yield(x) }
    elsif proc
      arr.my_each { |x| results << proc.call(x) }
    else
      return to_enum
    end
    results
  end

  def my_inject(*args)
    arr = is_a?(Range) ? to_a : self
    symbol = args[1]
    result = args[0]
    if block_given?
      if args[0].nil?
        result = arr[0]
        arr.drop(1).my_each { |x| result = yield(result, x) }
      elsif args[0].integer? && args[1].nil?
        arr.my_each { |x| result = yield(result, x) }
      end
    elsif args[1].nil?
      symbol = args[0]
      res = case symbol
            when :+ || :-
              0
            else
              1
            end
      arr.my_each { |x| res = res.send(symbol, x) }
      return res
    else
      arr.my_each { |x| result = result.send(symbol, x) }
    end
    result
  end
end

my_proc = proc { |y| y**2 }

def multiply_els(arr)
  arr.my_inject(:*)
end

a = [1, 2, 3, 4, 5]

puts(a.my_each { |x| x + 1 })
puts(a.my_each_with_index { |val, index| "index: #{index} for #{val}" if val < 30 })
puts(a.my_select(&:even?))
puts(a.my_all? { |x| x < 3 }) #=> false
puts(%w[ant bear cat].my_all? { |word| word.length >= 4 }) #=> false
puts(a.my_any? { |x| x >= 10 }) #=> true
puts(%w[ant bear cat].my_any? { |word| word.length >= 4 }) #=> true
puts(a.my_none? { |x| x == 5 }) #=> false
puts(%w[ant bear cat].my_none? { |word| word.length >= 4 }) #=> false
puts(a.my_count) #=> 5
puts(a.my_count { |x| x > 2 }) #=> 3
puts(%w[cat bear dog].my_map { |x| x + '!' })
puts(a.my_map { |x| x + 10 })
puts(a.my_map(my_proc))
puts(a.my_inject(:+)) #=> 15
puts(a.my_inject { |sum, n| sum + n }) #=> 15
puts(a.my_inject(1, :*)) #=> 120
puts(a.my_inject(1) { |product, n| product * n }) #=> 120
puts multiply_els([2, 4, 5])
