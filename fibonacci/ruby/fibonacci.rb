
Fibonacci = Hash.new do |h,k|
  h[k] = h[k-1] + h[k-2]
end.merge! 0 => 0, 1 => 1

class Fixnum
  def fibonacci
    Fibonacci[self]
  end
end
