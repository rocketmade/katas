

class String
  def first_letters
    gsub(/\s?(\w)\w*\s?/, '\1').gsub(/\p{P}/, ' ')
  end
end
