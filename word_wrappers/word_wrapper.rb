
class String
  def wrap line_length
    split(' ').reduce(['']) do |memo, word|
      if memo.last.length + word.length + 1 <= line_length
        memo.last << " #{word}"
      else
        memo << word
      end
      memo
    end.join("\n").strip
  end
end
