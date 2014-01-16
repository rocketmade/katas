require 'pp'

CARD_ORDER = %w(1 2 3 4 5 6 7 8 9 10 j q k a)
HAND_ORDER = %i(straight_flush four_kind full_house flush straight three_kind two_pair pair high_card)
class Card < Struct.new(:str, :suit, :value, :value_rank)
  def initialize card
    self.str = card
    self.value = card[0..-2]
    self.suit = card[-1]
    self.value_rank = CARD_ORDER.index value
  end
  def to_s; str; end
  def <=> other; value_rank <=> other.value_rank; end
end

class Hand < Struct.new(:str, :cards)
  def self.winner *hands
    hands = hands.map { |hand| new(hand) }.sort
    hands.select { |hand| (hand <=> hands.last) == 0 }.map &:to_s
  end

  def initialize str
    self.str = str
    self.cards = str.split.map { |card| Card.new card }
    self.cards.sort!
  end

  def to_s; str; end

  def <=> other
    result = if best_hand != other.best_hand
               HAND_ORDER.index(other.best_hand) <=> HAND_ORDER.index(best_hand) # reversed since the hand order list is in descending order
             elsif %i(four_kind three_kind).include? best_hand
               public_send(best_hand).first.first <=> other.public_send(best_hand).first.first
             elsif best_hand == :pair
               pairs.flatten.sort.last <=> other.pairs.flatten.sort.last
             elsif best_hand == :full_house
               three_kind.first.first <=> other.three_kind.first.first
             else
               0
             end

    result = compare_by_high_card(other) if result == 0

    result
  end

  def compare_by_high_card other
    pair_result = cards.each_index.map { |i| cards[0 - i] <=> other.cards[0 - i] }.find { |c| c != 0 }
    pair_result || 0
  end

  def best_hand
    @best_hand ||= HAND_ORDER.find do |type|
      send("#{type}?".to_sym)
    end
  end

  def cards_by_value
    @cards_by_value ||= cards.reduce({}) do |memo, card|
      memo[card.value] ||= []
      memo[card.value] << card
      memo
    end
  end

  def straight?
    cards.map(&:value_rank) == (cards.first.value_rank..(cards.first.value_rank + cards.length - 1)).to_a
  end

  def flush?; cards.map(&:suit).uniq.length == 1; end
  def four_kind; cards_by_value.values.select { |values| values.length == 4 }; end
  def four_kind?; four_kind.length > 0; end
  def full_house?; pair? && three_kind?; end
  def high_card; cards.last; end
  def high_card?; true; end
  def pair?; pairs.length > 0; end
  def pairs; cards_by_value.values.select { |values| values.length == 2 }; end
  def straight_flush?; straight? && flush?; end
  def three_kind; cards_by_value.values.select { |values| values.length == 3 }; end
  def three_kind?; three_kind.length > 0; end
  def two_pair?; pairs.length > 1; end
end
