require './cells'

class Board
  attr_accessor :hash

  NEIGHBOR_OFFSETS = [-1,0,1].product([-1,0,1]) - [[0,0]]

  attr_accessor :view_area

  def initialize data="", height: 40, width: 120
    @key_map = {}
    self.hash = hash_from_string data
    hash.default = dead
    configure_view_area height, width
  end

  def configure_view_area height, width
    self.view_area = (0..height).map { |y| [y].product (0..width).to_a  }
  end

  def key x,y; :"#{x},#{y}"; end
  def coordinates_from_key k; @key_map[k] ||= k.to_s.split(',').map(&:to_i); end

  def hash_from_string str
    h = {}
    str.split.each_with_index do |s, j|
      s.split('').each_with_index do |c, i|
        h[key(j,i)] = alive if c == "#"
      end
    end

    h
  end

  def [] x, y
    hash[key(x,y)]
  end

  def []= x, y, val
    hash[key(x,y)] = val
  end

  def neighbors_of x, y
    NEIGHBOR_OFFSETS.map { |o| self[x + o.first, y + o.last] }
  end

  def neighbors_coordinates x, y
    NEIGHBOR_OFFSETS.map { |o| [x + o.first, y + o.last] }
  end

  def live_neighbor_count x, y
    (neighbors_of(x,y) - [dead]).length
  end

  def to_s
    view_area.map { |arr| arr.map { |coords| self[*coords] }.join('') }.join("\n")
  end

  def next_generation!
    @previous_generation = @hash
    @hash = next_generation
  end

  def next_generation
    new_generation = nil
    new_generation = hash.clone
    next_generation_candidates.each do |k|

      if next_state_for(*k).alive?
        new_generation[key(*k)] = alive
      else
        new_generation.delete key(*k)
      end
    end
    new_generation

    new_generation
  end

  def next_generation_candidates
    keys = hash.keys.map { |k| coordinates_from_key(k) }
    final_keys = (keys.reduce(keys) { |memo, k| memo + neighbors_coordinates(*k) }).uniq
  end

  def next_state_for x,y
    current = self[x,y]
    live_count = live_neighbor_count x, y
    if live_count == 3
      alive
    elsif live_count == 2
      current
    else
      dead
    end
  end
end
