require 'rubygems'
require "rspec/autorun"

require './poker_hands.rb'

describe Card do
  describe ".initialize" do
    it "assigns the suit to the last character of the card description" do
      Card.new("10s").suit.should == "s"
    end

    it "assigns the value to the leading characters" do
      Card.new("as").value.should == "a"
    end

    it "correctly handles the 10 as input" do
      Card.new("10s").value.should == "10"
    end
  end

  describe "#<=>" do
    it "returns 1 when the recipient is a higher number" do
      (Card.new("2s") <=> Card.new("1s")).should == 1
    end

    it "returns 0 when the recipient is an equal number" do
      (Card.new("2s") <=> Card.new("2d")).should == 0
    end

    it "returns -1 when the recipient is a lower number" do
      (Card.new("2s") <=> Card.new("3d")).should == -1
    end

    it "returns 1 when the recipient is a higher face card" do
      (Card.new("as") <=> Card.new("1s")).should == 1
    end

    it "returns 0 when the recipient is an equal face card" do
      (Card.new("ks") <=> Card.new("kd")).should == 0
    end

    it "returns -1 when the recipient is a lower face card" do
      (Card.new("qs") <=> Card.new("ad")).should == -1
    end
  end
end


describe Hand do
  describe ".initialize" do
    it "creates cards for each input card" do
      Hand.new("5c 5h ks kh as").cards.length.should == 5
    end
  end

  describe "#high_card" do
    it "gets the highest card" do
      Hand.new("ac 5h 6s kh 3s").high_card.to_s.should == "ac"
    end
  end

  describe "#flush?" do
    it "returns true when all the suits are the same" do
      Hand.new("ac 5c 6c kc 3c").flush?.should == true
    end
    it "returns false when there are different suits" do
      Hand.new("ac 5c 6c kc 3d").flush?.should == false
    end
  end

  describe "#straight?" do
    it "returns true when the cards are continuous" do
      Hand.new("2c 6c 4c 5c 3c").straight?.should == true
    end
    it "returns false when there are different suits" do
      Hand.new("ac 5c 6c kc 3d").straight?.should == false
    end
  end

  describe "#full_house" do
    it "returns true when there is a full house" do
      Hand.new("2c 2d 3h 3d 3c").full_house?.should == true
    end
    it "returns false when there is not a full house" do
      Hand.new("2c 2d 5h 3d 3c").full_house?.should == false
    end
  end

  describe "#four_kind?" do
    it "returns true when there is a 4 of a kind" do
      Hand.new("2c 3h 3s 3d 3c").four_kind?.should == true
    end
    it "returns false when there is no 4 of a kind" do
      Hand.new("ac 5c 6c kc 3d").four_kind?.should == false
    end
  end

  describe "#three_kind?" do
    it "returns true when there is a 3 of a kind" do
      Hand.new("2c 4h 3s 3d 3c").three_kind?.should == true
    end
    it "returns false when there is no 3 of a kind" do
      Hand.new("ac 5c 3c 8h 3d").three_kind?.should == false
    end
  end

  describe "#two_pair?" do
    it "returns true when there are 2 pairs" do
      Hand.new("2c 4h 4s 3d 3c").two_pair?.should == true
    end
    it "returns false when there are not 2 pairs" do
      Hand.new("ac 5c 3c 8h 3d").two_pair?.should == false
    end
  end

  describe "#pair?" do
    it "returns true when there is a pair" do
      Hand.new("2c 4h as 3d 3c").pair?.should == true
    end
    it "returns false when there is not a pair" do
      Hand.new("ac 5c 3c 8h 9d").pair?.should == false
    end
  end

  describe ".winner" do
    it "returns a set of winners" do
      hands = ["2c 2d 3h 5s 6h", "5c 5h ks kh as"]
      Hand.winner(*hands).each do |winning_hand|
        hands.should include winning_hand
      end
    end

    it "gives high card winner" do
      hands = ["2c 9d 3h 5s 6h", "5c 9h qs kh as"]
      Hand.winner(*hands).should == [hands.last]
    end

    it "gives second card winner" do
      hands = ["2c 9d 3h 5s ah", "5c 9h qs kh as"]
      Hand.winner(*hands).should == [hands.last]
    end

    it "gives all hands with equal values" do
      hands = ["2c 9d 3h 5s ah", "2d 9h 3s 5h as"]
      Hand.winner(*hands).should =~ hands
    end

    it "pair beats high card" do
      hands = ["2c 9d 9h 5s qh", "5c 1c qs kh as"]
      Hand.winner(*hands).should == [hands.first]
    end

    it "higher pair determines pair tie" do
      hands = ["2c 9d 9h 5s qh", "5c 1c 5s kh as"]
      Hand.winner(*hands).should == [hands.first]
    end

    it "high card determines pair tie when pairs are tied" do
      hands = ["2c 5d 9h 5h 1h", "5c 1c 5s kh as"]
      Hand.winner(*hands).should == [hands.last]
    end

    it "equal pairs with other equal cards returns both" do
      hands = ["2c 5d 9h 5h 1h", "5c 2c 5s 9h 1s"]
      Hand.winner(*hands).should =~ hands
    end

    it "pair beats lower pair" do
      hands = ["2c 2d 3h 5s 6h", "5c 5h qs kh as"]
      Hand.winner(*hands).should == [hands.last]
    end

    it "three of a kind beats pair" do
      hands = ["2c 2d 3h 5s 6h", "5c 5h 5s kh as"]
      Hand.winner(*hands).should == [hands.last]
    end

    it "straight beats three of a kind" do
      hands = ["2c 3h 4d 5s 6h", "5c 5h 5s kh as"]
      Hand.winner(*hands).should == [hands.first]
    end

    it "flush beats straight" do
      hands = ["2c 3h 4d 5s 6h", "2c 3c 5c kc ac"]
      Hand.winner(*hands).should == [hands.last]
    end

    it "highcard determines flush tie" do
      hands = ["2d 3d 4d 5d 9d", "2c 3c 5c kc ac"]
      Hand.winner(*hands).should == [hands.last]
    end
  end
end
