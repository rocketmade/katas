

Fibonacci = Hash.new do |h,k|
  (1..(k-2)).step(100).each { |i| h[i] } if k > 100 && !h.has_key?(k-100) # this is useful for avoiding stack too deep errors
  h[k] = h[k-2] + h[k-1]
end.merge! 0 => 0, 1 => 1


class Fixnum
  def fibonacci
    Fibonacci[self]
  end
end
