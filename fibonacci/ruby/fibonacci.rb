
Fibonacci = { 0 => 0, 1 => 1 }
class Fixnum
  def fibonacci
    Fibonacci[self] ||= (self - 1).fibonacci + (self - 2).fibonacci
  end
end
