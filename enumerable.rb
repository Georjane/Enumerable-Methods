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

