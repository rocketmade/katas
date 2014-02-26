UniqueSquares = [0, 1]
class Fixnum
	def unique_squares
		UniqueSquares[self] ||= (self * (self + 1) * (2 * self + 1)) / 6

		# Original implementation before exact formula:
		# 	UniqueSquares[self] ||= (self-1).unique_squares + self**2
	end
end